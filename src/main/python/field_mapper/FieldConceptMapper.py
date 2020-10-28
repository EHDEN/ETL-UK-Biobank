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
from src.main.python.field_mapper.model.Validator import validator

logger = logging.getLogger(__name__)


class FieldConceptMapper:

    def __init__(self, in_directory: Path):
        self.field_mappings: Dict[str, FieldMapping] = {}
        self.load(in_directory)

    def __call__(self, field_id: str, value: str) -> MappingTarget:
        # Convenience method to allow field_mapper(field_id, value)
        return self._lookup(field_id, value)

    def load(self, directory: Path):
        if not directory.exists():
            raise FileNotFoundError(f"No such directory: '{directory}'")

        for usagi_path in directory.glob('*.csv'):
            logger.info(f"Loading {usagi_path.name}...")
            self._load_usagi(usagi_path)

    @staticmethod
    def _load_map(file_path: Path):
        with file_path.open(encoding='ISO-8859-2') as f_in:
            for row in csv.DictReader(f_in):
                yield row

    def _load_usagi(self, file_path: Path):
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row, file_path.name)
            logger.debug(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")

            # TODO: handle mapping file with fixed event mappings (e.g. cancer codes or operations)

            code_mapping = self.field_mappings.setdefault(
                usagi_mapping.field_id,
                FieldMapping(usagi_mapping.field_id)
            )
            code_mapping.add(usagi_mapping)

    def get_mapping(self, field_id: str) -> Optional[FieldMapping]:
        if field_id in self.field_mappings:
            return self.field_mappings[field_id]
        return None

    def _lookup(self, field_id: str, value: str) -> Optional[MappingTarget]:
        """
        For given field_id/value pair, looks up the target concept_id, value_as_concept_id, value_as_number and unit_concept_id.
        The mapping can be one of two types:
        1. Has a unit. If no mapping for value found, the value is assumed to be numeric (float). Variable maps to concept_id and unit_concept_id.
        2. Has a value. The field_id/value pair maps to a concept_id and (optionally) a value_as_concept_id.
        :param field_id: string
        :param value: string
        :return: MappingTarget
        """
        target = MappingTarget()
        target.value_source_value = value

        field_mapping = self.get_mapping(field_id)

        if not field_mapping:
            logger.warning(f'Field "{field_id}" is unknown')
            target.concept_id = 0
            target.source_value = field_id
            return target

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

            if not value_mapping:
                logger.warning(f'Value "{value}" for field_id "{field_id}" is unknown')
                target.concept_id = 0
                target.source_value = field_id
                return target

            if value_mapping.is_ignored():
                return None

            if not value_mapping.event_target:
                target.concept_id = 0
                logger.warning(f'"{field_id}-{value}" does not have an event_concept_id associated')
            else:
                target.concept_id = value_mapping.event_target.concept_id

            if value_mapping.value_target:
                target.value_as_concept_id = value_mapping.value_target.concept_id
            target.source_value = field_id + "|" + value
            target.value_source_value = value
            return target

        raise Warning('"{field_id}-{value}" This should not happen, mapping has to be either a unit or value mapping.')


if __name__ == '__main__':
    logger.setLevel('INFO')
    mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'))

    # Some simple tests
    print(mapper('50', '180'))  # numeric
    print(mapper('30785', '8'))
    print(mapper('2443', '0'))
    print(mapper('2443', '1'))
    print(mapper('4041', '-3'))  # Ignored
    print(mapper('41256', '0552'))  # unknown field
    print(mapper('4041', '123'))  # unknown value for categorical field

    # get the mapping of a field
    # print(mapper.get_mapping('2335'))
    print(mapper.get_mapping('4041'))

    validator.print_summary()
    # validator.print_all()
