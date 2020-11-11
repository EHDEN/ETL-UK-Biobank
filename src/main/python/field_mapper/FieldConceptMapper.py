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
import yaml
import logging

from src.main.python.field_mapper.model.MappingTarget import MappingTarget
from src.main.python.field_mapper.model.UsagiModel import UsagiRow, MappingStatus, TargetMapping
from src.main.python.field_mapper.model.MappingModel import FieldMapping
from src.main.python.field_mapper.model.Validator import validator

logger = logging.getLogger(__name__)


class FieldConceptMapper:
    """
    TODO: configuration file to load the baseline_field_mappings, to cover:
     - handle field_ids using same value mapping (opcs codes from 41256;41258;42908)
     - handle value as string (e.g. device_id)
     - handle multiple (event) target concepts for one field/value combination (see opcs)
     - continuous fields with few categorical values (-1, -3)
    """

    CONFIG_FILE_NAME = 'field_mapping_config.yaml'

    def __init__(self, in_directory: Path = None, log_level: str = 'INFO'):
        logger.setLevel(log_level)
        self.field_mappings: Dict[str, FieldMapping] = {}
        self.date_field_mapping: Dict[str, str] = {}
        self.default_date_field: Optional[str] = None

        if in_directory:
            self.load(in_directory)

    def __call__(self, field_id: str, value: str) -> MappingTarget:
        # Convenience method to allow field_mapper(field_id, value)
        return self.lookup(field_id, value)

    def load(self, directory: Path):
        if not directory.exists():
            raise FileNotFoundError(f"No such directory: '{directory}'")

        with (directory / self.CONFIG_FILE_NAME).open() as config_file:
            config = yaml.load(config_file)

        for mapping_config in config['mappings']:
            mapping_filename = mapping_config['filename']
            if mapping_config['mappingApproach']['name'] == 'date':
                self.load_date_mapping(directory / mapping_filename)
                self.default_date_field = mapping_config['default_date_field']
            elif mapping_config['mappingApproach']['name'] == 'value_only':
                target_event_concept_id = int(mapping_config['event_concept_id'])
                self.load_usagi(directory / mapping_filename, target_event_concept_id)
            else:  # TODO: handle value as numeric and value as text
                self.load_usagi(directory / mapping_filename)

    def load_date_mapping(self, date_mapping_file: Path):
        with date_mapping_file.open() as f_in:
            for row in csv.DictReader(f_in):
                self.date_field_mapping[row['field']] = row['date_field']

    def load_usagi(self, file_path: Path, fixed_event_concept_id: Optional[int] = None):
        logger.info(f"Loading {file_path.name}...")
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row, file_path.name)
            logger.debug(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")

            field_mapping = self.field_mappings.setdefault(
                usagi_mapping.field_id,
                FieldMapping(usagi_mapping.field_id)
            )
            field_mapping.add(usagi_mapping)

            if fixed_event_concept_id:
                # assume given usagi mapping is only the value mapping of the field
                event_target = TargetMapping({
                    'conceptId': fixed_event_concept_id,
                    'createdBy': '<config>',
                    'createdOn': '0',
                    'mappingType': 'EVENT',
                    'statusSetBy': '<config>',
                    'statusSetOn': '0'
                })
                field_mapping.add_target_for_value(usagi_mapping.value_code, event_target)

    @staticmethod
    def _load_map(file_path: Path):
        with file_path.open(encoding='ISO-8859-2') as f_in:
            for row in csv.DictReader(f_in):
                yield row

    def get_mapping(self, field_id: str) -> Optional[FieldMapping]:
        if field_id in self.field_mappings:
            return self.field_mappings[field_id]
        return None

    def get_flagged_mappings(self):
        for mapping in self.field_mappings.values():
            if mapping.status == MappingStatus.FLAGGED:
                yield mapping

    def get_random_mappings(self, n=20):
        import random
        if n > len(self.field_mappings):
            n = len(self.field_mappings)
        return random.sample(list(self.field_mappings.values()), n)

    def lookup(self, field_id: str, value: str) -> Optional[MappingTarget]:
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

        field_mapping = self.get_mapping(field_id)

        if not field_mapping:
            logger.debug(f'Field "{field_id}" is unknown')
            # Do not map fields not in the mapping tables. These are by default ignored.
            return None

        if field_mapping.is_ignored():
            return None

        if field_mapping.has_unit():
            if not field_mapping.is_approved():
                logger.warning(f'Field_id "{field_id}" is not approved')
                target.concept_id = 0
                target.source_value = field_id + "|" + value
                return target
            # Create numeric target
            target.concept_id = field_mapping.event_target.concept_id
            target.value_as_number = float(value)
            target.unit_concept_id = field_mapping.unit_target.concept_id
            target.source_value = field_id
            return target

        if field_mapping.has_values():
            # Create categorical target
            value_mapping = field_mapping.values.get(value)

            if not value_mapping:
                logger.warning(f'Value "{value}" for field_id "{field_id}" is unknown')
                target.concept_id = 0
                target.source_value = field_id + "|" + value
                return target

            if value_mapping.is_ignored():
                return None

            if not value_mapping.is_approved():
                logger.warning(f'Value "{value}" for field_id "{field_id}" is not approved')
                target.concept_id = 0
                target.source_value = field_id + "|" + value
                return target

            if not value_mapping.event_target:
                target.concept_id = 0
                logger.warning(f'"{field_id}-{value}" does not have an event_concept_id associated')
            else:
                target.concept_id = value_mapping.event_target.concept_id

            if value_mapping.value_target:
                target.value_as_concept_id = value_mapping.value_target.concept_id
            target.source_value = field_id + "|" + value
            return target

        raise Warning('"{field_id}-{value}" This should not happen, mapping has to be either a unit or value mapping.')

    def lookup_date_field(self, field_id: str) -> str:
        return self.date_field_mapping.get(field_id, self.default_date_field)


if __name__ == '__main__':
    mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'INFO')

    # Some simple tests
    print(mapper('50', '180'))  # numeric
    print(mapper('30785', '8'))
    print(mapper('2443', '0'))
    print(mapper('2443', '1'))
    print(mapper('4041', '-3'))  # Ignored
    print(mapper('41256', '0552'))  # unknown field
    print(mapper('4041', '123'))  # unknown value for categorical field
    # field mapping
    print(mapper('20001', '1064'))  # unknown value for categorical field

    # get the mapping of a field
    # print(mapper.get_mapping('2335'))
    print(mapper.get_mapping('4041'))

    print('Date field lookup')
    print(mapper.lookup_date_field('46'))  # default
    print(mapper.lookup_date_field('30110')) # custom

    print(f'{len(mapper.field_mappings):>6} field mappings loaded')
    print(f'{sum([len(x.get_values()) for x in mapper.field_mappings.values()]):>6,} value mappings loaded')

    validator.print_summary()
    # validator.print_all()
