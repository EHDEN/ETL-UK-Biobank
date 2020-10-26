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
import csv
from pathlib import Path
from typing import Dict, Optional
import logging

from src.main.python.field_mapper.model.MappingTarget import MappingTarget
from src.main.python.field_mapper.model.UsagiModel import UsagiRow
from src.main.python.field_mapper.model.MappingModel import FieldMapping

logger = logging.getLogger(__name__)


class FieldConceptMapper:
    VERBOSE_SILENT = 0
    VERBOSE_FILE = 1
    VERBOSE_CODE = 2

    def __init__(self, in_directory: Path, verbose_level: int = 0):
        self.field_mappings: Dict[str, FieldMapping] = {}
        self.verbose_level = verbose_level
        self.load(in_directory)

    def __call__(self, field_id: str, value: str) -> MappingTarget:
        # Convenience method
        return self.lookup(field_id, value)

    def load(self, directory: Path):
        if not directory.exists():
            raise FileNotFoundError(f"No such directory: '{directory}'")

        for usagi_path in directory.glob('*.csv'):
            if self.verbose_level >= FieldConceptMapper.VERBOSE_FILE:
                print(f"Loading {usagi_path.name}...")
            self._load_usagi(usagi_path)

    @staticmethod
    def _load_map(file_path: Path):
        with file_path.open(encoding='ISO-8859-2') as f_in:
            for row in csv.DictReader(f_in):
                yield row

    def _load_usagi(self, file_path: Path):
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row)
            if self.verbose_level >= FieldConceptMapper.VERBOSE_CODE:
                print(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")

            code_mapping = self.field_mappings.setdefault(
                usagi_mapping.field_id,
                FieldMapping(usagi_mapping.field_id)
            )
            code_mapping.add(usagi_mapping, file_path.name)

    def has_mapping_for_field(self, field_id: str):
        return field_id in self.field_mappings

    def get_mapping(self, field_id: str) -> Optional[FieldMapping]:
        if field_id in self.field_mappings:
            return self.field_mappings[field_id]
        return None

    def lookup(self, field_id: str, value: str) -> Optional[MappingTarget]:
        """
        For given variable/value pair, looks up the target concept_id, value_as_concept_id, value_as_number and unit_concept_id.
        The mapping can be one of three types:
        1. Only concept. Variable and value together map to one concept_id.
        2. Categorical. Variable maps to a concept_id, value maps to a value_as_concept_id.
        3. Numeric. If no mapping for value found, the value is assumed to be numeric. Variable maps to concept_id and unit_concept_id.
                    Value is converted to float.
        :param field_id: integer
        :param value: string
        :return: MappingTarget
        """
        target = MappingTarget()
        target.value_source_value = value

        if not self.has_mapping_for_field(field_id):
            print(f'Field "{field_id}" is unknown')
            target.concept_id = 0
            target.source_value = field_id
            return target

        field_mapping = self.get_mapping(field_id)

        if field_mapping.is_ignored():
            return None

        if field_mapping.has_unit():
            # Create numeric target
            target.concept_id = field_mapping.event_target.concept_id
            target.value_as_number = float(value)
            target.unit_concept_id = field_mapping.unit_target.concept_id
            target.source_value = field_id
            target.value_source_value = value
            return target

        if field_mapping.has_values():
            # Create categorical target
            value_mapping = field_mapping.values.get(value)

            if value_mapping.is_ignored():
                return None

            if not value_mapping:
                print(f'Value "{value}" for field_id "{field_id}" is unknown')
                target.concept_id = 0
                target.source_value = field_id
                return target

            if not value_mapping.event_target:
                target.concept_id = 0
                print(f'Warning "{field_id}-{value}" does not have an event_concept_id associated')
            else:
                target.concept_id = value_mapping.event_target.concept_id

            if value_mapping.value_target:
                target.value_as_concept_id = value_mapping.value_target.concept_id
            target.source_value = field_id + "|" + value
            target.value_source_value = value
            return target

        raise Warning('This should not happen, mapping is either has unit or value mapping.')


if __name__ == '__main__':
    mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), FieldConceptMapper.VERBOSE_FILE)

    # Some simple tests
    print(mapper.lookup('41256', '0552'))  # unknown field and value
    print(mapper.lookup('30785', '8'))
    print(mapper.lookup('2443', '0'))
    print(mapper.lookup('2443', '1'))
    print(mapper.lookup('4041', '-3'))

    # get the mapping of a field
    # print(mapper.get_mapping('2335'))
    print(mapper.get_mapping('4041'))
