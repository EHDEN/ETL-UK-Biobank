# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# !/usr/bin/env python3
from __future__ import annotations
from abc import ABC
from dataclasses import dataclass, field
from typing import Dict, Optional, List, Union
from src.main.python.field_mapper.model.UsagiModel import UsagiRow, TargetMapping, MappingType, MappingStatus
from src.main.python.field_mapper.model.Validator import validator


@dataclass
class _AbstractMapping(ABC):
    field_id: str = None
    field_description: str = None
    value_code: str = None  # Only implemented for ValueMapping
    value_description: str = None  # Only implemented for ValueMapping
    event_targets: List[TargetMapping] = field(default_factory=list)
    value_targets: List[TargetMapping] = field(default_factory=list)
    unit_target: Optional[TargetMapping] = None
    comment: Optional[str] = None
    status: Optional[MappingStatus] = None
    source_file_name: Optional[str] = None

    def is_ignored(self):
        return self.status == MappingStatus.IGNORED

    def is_flagged(self) -> bool:
        return self.status == MappingStatus.FLAGGED

    def is_unchecked(self) -> bool:
        return self.status == MappingStatus.UNCHECKED

    def is_approved(self) -> bool:
        return self.status == MappingStatus.APPROVED

    def get_event_concept_ids(self) -> List[int]:
        return _AbstractMapping._get_concept_ids(self.event_targets)

    def get_value_concept_ids(self) -> List[int]:
        return _AbstractMapping._get_concept_ids(self.value_targets)

    @staticmethod
    def _get_concept_ids(targets) -> List[int]:
        return [x.concept_id for x in targets]

    def get_event_concept_id(self) -> int:
        return _AbstractMapping._get_concept_id(self.event_targets)

    def get_value_concept_id(self) -> int:
        return _AbstractMapping._get_concept_id(self.value_targets)

    @staticmethod
    def _get_concept_id(targets) -> int:
        if not targets:
            return 0

        if len(targets) > 1:
            print('Warning: multiple target concepts, only one returned')

        return targets.pop().concept_id

    def get_unit_concept_id(self):
        if not self.unit_target:
            return 0
        return self.unit_target.concept_id

    def set_status(self, status: MappingStatus):
        # Although each Usagi row has a comment and status, these are given on field-value level
        if self.status and self.status != status:
            message = f'Two conflicting statuses "{self.status}" and "{status}", the last is used'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)

        if status == MappingStatus.IGNORED and (self.event_targets or self.unit_target or self.value_targets):
            message = f'Ignored with target mappings. The mappings will not be used.'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)

        self.status = status

    def set_target(self, target: TargetMapping):
        if target.type == MappingType.EVENT:
            self.event_targets += [target]
        elif target.type == MappingType.UNIT:
            if self.unit_target:
                message = f'Existing unit_concept_id will be overwritten.'
                validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)
            self.unit_target = target
        elif target.type == MappingType.VALUE:
            self.value_targets += [target]
        else:
            message = f'Unknown MappingType "{target.type}"'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)


class FieldMapping(_AbstractMapping):
    def __init__(self, field_id: str):
        super().__init__()  # explicit init needed to initialize new lists
        self.field_id = field_id
        self.values: Dict[str, ValueMapping] = {}

    def has_unit(self) -> bool:
        # TODO: what about numeric mappings that do not have a unit assigned?
        return self.unit_target is not None

    def has_values(self) -> bool:
        # TODO: what about numeric mappings that also have a few codes (-1, -3)
        return bool(self.values)

    def has_flagged_values(self) -> bool:
        for value_mapping in self.values.values():
            if value_mapping.status == MappingStatus.FLAGGED:
                return True
        return False

    def get_values(self) -> List[ValueMapping]:
        return list(self.values.values())

    def add(self, usagi_row: UsagiRow):
        """
        If value_code is given, unit mapping is ignored with warning.
        If no value_code is given, value mapping is ignored with warning.
        :param usagi_row:
        :return:
        """
        if usagi_row.field_id != self.field_id:
            message = f'Given field_id "{usagi_row.field_id}" does not match field_id of mapping object "{self.field_id}". Row is skipped.'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)
            return

        self.source_file_name = usagi_row.source_file_name
        self.field_description = usagi_row.field_description
        if usagi_row.unit_description:
            self.field_description = f'{self.field_description} ({usagi_row.unit_description})'

        is_value_mapping = bool(usagi_row.value_code)
        if is_value_mapping:
            self._add_value_mapping(usagi_row)
        else:
            self._add_field_mapping(usagi_row)

    def _add_field_mapping(self, usagi_row: UsagiRow):
        """
        Mapping of just the the field_id to an event and (optionally) a unit.
        :param usagi_row:
        :return:
        """
        self.comment = usagi_row.comment
        self.set_status(usagi_row.status)

        if self.status == MappingStatus.IGNORED:
            return

        self.set_target(usagi_row.target)

    def _add_value_mapping(self, usagi_row: UsagiRow):
        """
        Mapping of field/value combination to an event and (optionally) a value concept.
        :param usagi_row:
        :return:
        """
        # Create new if does not exist, otherwise retrieve mapping for value
        value_mapping = self.values.setdefault(
            usagi_row.value_code,
            ValueMapping(usagi_row.value_code, self)
        )
        value_mapping.source_file_name = usagi_row.source_file_name

        # Although each Usagi row has a comment and status, these are given on field-value level in the tool.
        value_mapping.comment = usagi_row.comment
        value_mapping.value_description = usagi_row.value_description if usagi_row.value_description else usagi_row.field_description
        value_mapping.set_status(usagi_row.status)

        if value_mapping.status == MappingStatus.IGNORED:
            return

        self.add_target_for_value(usagi_row.value_code, usagi_row.target)

    def add_target_for_value(self, value_code: str, target: TargetMapping):
        """
        Convenience method to directly add mapping on value level
        :param value_code:
        :param target:
        :return:
        """
        if self.event_targets or self.unit_target or self.value_targets:
            message = f'Already mapping assigned on field level and we are trying to add a mapping of the value.'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)

        value_mapping = self.values.setdefault(
            value_code,
            ValueMapping(value_code, self)
        )

        value_mapping.set_target(target)

    def __str__(self):
        if self.is_ignored():
            return f'{self.field_id} => IGNORED'

        values = ', '.join([str(v) for k, v in self.values.items()])
        return f'{self.field_id} => ' \
               f'event_target: [{",".join(map(str, self.event_targets))}], ' \
               f'unit_target: [{self.unit_target}], ' \
               f'value_target: [{",".join(map(str, self.value_targets))}], ' \
               f'values ({len(self.values)}): [{values}], ' \
               f'comment: {self.comment}'


class ValueMapping(_AbstractMapping):

    def __init__(self, value_code: str, parent_field: FieldMapping):
        super().__init__()  # explicit init needed to initialize new lists
        self.value_code: str = value_code
        self.field_id: str = parent_field.field_id

    def set_target(self, target: TargetMapping):
        super().set_target(target)

        # Value specific warning
        if target.type == MappingType.UNIT:
            message = f'If value given as code, we expect no unit.'
            validator.add_warning(self.field_id, self.value_code, self.source_file_name, message)

    def __str__(self):
        if self.is_ignored():
            return f'{self.value_code} => IGNORED'

        return f'{self.value_code} => [' \
               f'event_target: [{",".join(map(str, self.event_targets))}], ' \
               f'value_target: [{",".join(map(str, self.value_targets))}], ' \
               f'status: {self.status}, ' \
               f'comment: {self.comment}]'
