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
from abc import ABC
from dataclasses import dataclass
from typing import Dict, Optional
from src.main.python.field_mapper.model.UsagiModel import UsagiRow, TargetMapping, MappingType, MappingStatus


@dataclass
class _AbstractMapping(ABC):
    event_target: Optional[TargetMapping] = None
    unit_target: Optional[TargetMapping] = None
    value_target: Optional[TargetMapping] = None
    comment: Optional[str] = None
    status: Optional[MappingStatus] = None
    _key: str = None

    def is_ignored(self):
        return self.status == MappingStatus.IGNORED

    def set_status(self, status: MappingStatus):
        # Although each Usagi row has a comment and status, these are given on field-value level
        if self.status and self.status != status:
            print(f'Warning: {self._key} has two conflicting statuses "{self.status}" and "{status}", the last is used')

        if status == MappingStatus.IGNORED and (self.event_target or self.unit_target or self.value_target):
            print(f'Warning: {self._key} is ignored and has target mappings. The mappings will not be used.')

        self.status = status

    def set_target(self, target: TargetMapping):
        if target.type == MappingType.EVENT:
            if self.event_target:
                print(f'Warning: {self._key} already has a event_concept_id assigned and will be overwritten.')
            self.event_target = target
        elif target.type == MappingType.UNIT:
            if self.unit_target:
                print(f'Warning: {self._key} already has a unit_concept_id assigned and will be overwritten.')
            self.unit_target = target
        elif target.type == MappingType.VALUE:
            if self.value_target:
                print(f'Warning: {self._key} already has a value_concept_id assigned and will be overwritten.')
            self.value_target = target
        else:
            print(f'Warning: unknown MappingType "{target.type}"')


class FieldMapping(_AbstractMapping):
    def __init__(self, field_id: str):
        super()
        self.field_id: str = field_id
        self.values: Dict[str, ValueMapping] = {}
        self.source_file_name: Optional[str] = None

        self._key = self.field_id

    def has_unit(self) -> bool:
        # TODO: what about numeric mappings that do not have a unit assigned?
        return self.unit_target is not None

    def has_values(self) -> bool:
        # TODO: what about numeric mappings that also have a few codes (-1, -3)
        return bool(self.values)

    def add(self, usagi_row: UsagiRow, source_file_name: str):
        """
        If value_code is given, unit mapping is ignored with warning.
        If no value_code is given, value mapping is ignored with warning.
        :param usagi_row:
        :param source_file_name: from where the mapping is retrieved
        :return:
        """
        self.source_file_name = source_file_name

        if usagi_row.field_id != self.field_id:
            # TODO: log as warnings and/or raise custom warning. Collect warnings for validation
            print(f'Warning: given field_id "{usagi_row.field_id}" does not match field_id of mapping object "{self.field_id}". Row is skipped.')
            return

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
            print(f'Warning: {self.field_id} is ignored so the concept mapping will not be used.')
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

        # Although each Usagi row has a comment and status, these are given on field-value level in the tool.
        value_mapping.comment = usagi_row.comment
        value_mapping.set_status(usagi_row.status)

        if value_mapping.status == MappingStatus.IGNORED:
            print(f'Warning: {self.field_id}-{value_mapping.value_code} is ignored so the concept mapping will not be used.')
            return

        if self.event_target or self.unit_target or self.value_target:
            # TODO: continuous fields with few categorical values (-1, -3)
            print(f'Warning: {self.field_id} already has a mapping on field level and we are trying to add a mapping of the value.')

        value_mapping.set_target(usagi_row.target)

    def __str__(self):
        if self.is_ignored():
            return f'{self.field_id} => IGNORED'

        values = ', '.join([str(v) for k, v in self.values.items()])
        return f'{self.field_id} => ' \
               f'event_target: [{self.event_target}], ' \
               f'unit_target: [{self.unit_target}], ' \
               f'value_target: [{self.value_target}], ' \
               f'values ({len(self.values)}): [{values}], ' \
               f'comment: {self.comment}'


class ValueMapping(_AbstractMapping):

    def __init__(self, value_code: str, parent_field: FieldMapping):
        self.field: FieldMapping = parent_field
        self.value_code: str = value_code

        self._key = self.field.field_id + '-' + self.value_code

    def set_target(self, target: TargetMapping):
        super().set_target(target)

        # Value specific warning
        if target.type == MappingType.UNIT:
            print(f'Warning: {self.field.field_id}-{self.value_code} if value given as code, we expect no unit.')

    def __str__(self):
        if self.is_ignored():
            return f'{self.value_code} => IGNORED'

        return f'{self.value_code} => [' \
               f'event_target: [{self.event_target}], ' \
               f'value_target: [{self.value_target}], ' \
               f'status: {self.status}, ' \
               f'comment: {self.comment}]'
