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
from typing import Dict, Optional
from src.main.python.field_mapper.model.UsagiModel import UsagiRow, TargetMapping, MappingType, MappingStatus


class FieldMapping:

    def __init__(self, field_id: str):
        self.field_id: str = field_id

        # Initialize
        self.event_target: Optional[TargetMapping] = None
        self.unit_target: Optional[TargetMapping] = None
        self.values: Dict[str, FieldMapping.ValueMapping] = {}
        self.comment: Optional[str] = None
        self.status: Optional[MappingStatus] = None
        self.source_file_name: Optional[str] = None
        self.is_ignored: bool = False

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
        # Although each Usagi row has a comment and status, these are given on field-value level
        self.comment = usagi_row.comment
        self.status = usagi_row.status

        if self.status == MappingStatus.IGNORED:
            self.is_ignored = True
            if self.event_target or self.unit_target:
                print(f'Warning: {self.field_id} is ignored so the concept mapping will not be used.')
            # There should not be any other mapping information in this row
            return

        if self.is_ignored:
            print(f'Warning: {self.field_id} is ignored so the concept mapping will not be used.')

        if usagi_row.target.type == MappingType.EVENT:
            if self.event_target:
                print(f'Warning: {self.field_id} already has a event_concept_id assigned and will be overwritten.')
                return
            self.event_target = usagi_row.target
        elif usagi_row.target.type == MappingType.UNIT:
            if self.unit_target:
                print(f'Warning: {self.field_id} already has a unit_concept_id assigned and will be overwritten.')
                return
            self.unit_target = usagi_row.target
        elif usagi_row.target.type == MappingType.VALUE:
            # TODO: why can't a field have a target event and a target value concept?
            if usagi_row.value_code:
                print(f'Warning: please use the method "self._add_value_mapping" for adding value mappings {usagi_row}')
            else:
                print(f'Warning: no value code given in the usagi input row for field usagi_row {usagi_row}')
            print(f'Warning: mapping is not added {usagi_row}')
            return
        else:
            print(f'Warning: unknown MappingType "{usagi_row.target.type}"')

    def _add_value_mapping(self, usagi_row: UsagiRow):
        """
        Mapping of field/value combination to an event and (optionally) a value concept.
        :param usagi_row:
        :return:
        """
        # Create new if does not exist, otherwise retrieve mapping for value
        value_mapping = self.values.setdefault(usagi_row.value_code, FieldMapping.ValueMapping(usagi_row.value_code))

        # Although each Usagi row has a comment and status, these are given on field-value level in the tool.
        value_mapping.comment = usagi_row.comment
        value_mapping.status = usagi_row.status

        if value_mapping.status == MappingStatus.IGNORED:
            value_mapping.is_ignored = True
            if value_mapping.event_target or value_mapping.value_target:
                print(f'Warning: {self.field_id}-{value_mapping.value_code} is ignored so the concept mapping will not be used.')
            # There should not be any other mapping information in this row
            return

        if value_mapping.is_ignored:
            print(f'Warning: {self.field_id}-{value_mapping.value_code} is ignored so the concept mapping will not be used.')

        if self.event_target:
            print(f'Warning: {self.field_id} already has an event_concept_id assigned and we are trying to add a value. ?')
        if self.unit_target:
            print(f'Warning: {self.field_id} already has an unit_concept_id assigned and we are trying to add a value. ?')

        if usagi_row.target.type == MappingType.EVENT:
            if value_mapping.event_target:
                print(f'Warning: {self.field_id}-{value_mapping.value_code} already has a event_concept_id assigned and will be overwritten.')
                return
            value_mapping.event_target = usagi_row.target
        elif usagi_row.target.type == MappingType.UNIT:
            print(f'Warning: if value given as code, we expect no unit {usagi_row}.')
            return
        elif usagi_row.target.type == MappingType.VALUE:
            if value_mapping.value_target:
                print(f'Warning: {self.field_id}-{value_mapping.value_code} already has a value_concept_id assigned.')
                return
            value_mapping.value_target = usagi_row.target
        else:
            print(f'Warning: unknown MappingType "{usagi_row.target.type}"')

    def __str__(self):
        if self.is_ignored:
            return f'{self.field_id} => IGNORED'

        values = ', '.join([str(v) for k, v in self.values.items()])
        return f'{self.field_id} => ' \
               f'event_target: [{self.event_target}], ' \
               f'unit_target: [{self.unit_target}], ' \
               f'{len(self.values)}values: [{values}], ' \
               f'comment: {self.comment}'

    class ValueMapping:

        def __init__(self, value_code: str):
            self.value_code: str = value_code
            self.comment: Optional[str] = None
            self.status: Optional[MappingStatus] = None

            # Initialize
            self.is_ignored: bool = False
            self.event_target: Optional[TargetMapping] = None
            self.value_target: Optional[TargetMapping] = None

        def __str__(self):
            if self.is_ignored:
                return f'{self.value_code} => IGNORED'

            return f'{self.value_code} => [' \
                   f'event_target: [{self.event_target}], ' \
                   f'value_target: [{self.value_target}], ' \
                   f'status: {self.status}, ' \
                   f'comment: {self.comment}]'
