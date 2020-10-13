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
        self.values: Dict[str, ValueMapping] = {}
        self.comment: Optional[str] = None
        self.status: Optional[MappingStatus] = None

    def has_unit(self) -> bool:
        # TODO: what about numeric mappings that do not have an unit assigned?
        return self.unit_target is not None

    def has_values(self) -> bool:
        # TODO: what about numeric mappings that also have a few codes (-1, -3)
        return bool(self.values)

    def add(self, usagi_row: UsagiRow):
        """
        If value_code is given, unit mapping is ignored with warning.
        If no value_code is given, value mapping is ignored with warning.
        :param usagi_row:
        :return:
        """
        # Although each Usagi row has a comment and status, these are given on field level
        self.comment = usagi_row.comment
        self.status = usagi_row.status

        if usagi_row.field_id != self.field_id:
            # TODO: log as warnings and/or raise custom warning. Collect warnings for validation
            print(f'Warning: given field_id "{usagi_row.field_id}" does not match field_id of mapping object "{self.field_id}". Row is skipped.')
            return

        is_value_mapping = bool(usagi_row.value_code)
        if is_value_mapping:
            self._add_value_mapping(usagi_row)
        else:
            self._add_regular_mapping(usagi_row)

    def _add_regular_mapping(self, usagi_row: UsagiRow):
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
            if usagi_row.value_code:
                print(f'Warning: please use the method "self._add_value_mapping" for adding value mappings {usagi_row}')
            else:
                print(f'Warning: no value code given in the usagi input row for field usagi_row {usagi_row}')
            print(f'Warning: mapping is not added {usagi_row}')
            return
        else:
            print(f'Warning: unknown MappingType "{usagi_row.target.type}"')

    def _add_value_mapping(self, usagi_row: UsagiRow):
        value_mapping = self.values.setdefault(usagi_row.value_code, ValueMapping(usagi_row.value_code))

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
        # TODO: string representation of TargetMapping class
        values = [str(v) for k,v in self.values.items()]
        return f'{self.field_id} => ' \
               f'event_target: {self.event_target}, ' \
               f'unit_target: {self.unit_target}, ' \
               f'values: {values}, ' \
               f'comment: {self.comment}'


class ValueMapping:

    def __init__(self, value_code: str):
        self.value_code: str = value_code

        # Initialize
        self.event_target: Optional[TargetMapping] = None
        self.value_target: Optional[TargetMapping] = None

    def __str__(self):
        return f'{self.value_code} => ' \
               f'event_target: {self.event_target}, ' \
               f'value_target: {self.value_target}'
