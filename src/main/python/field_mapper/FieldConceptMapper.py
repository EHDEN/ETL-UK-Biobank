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
import copy
import csv
from pathlib import Path
from typing import Dict, Optional, List
import yaml
import logging

from src.main.python.field_mapper.model.MappingTarget import MappingTarget
from src.main.python.field_mapper.model.UsagiModel import UsagiRow, MappingStatus, TargetMapping, create_fake_target_mapping
from src.main.python.field_mapper.model.MappingModel import FieldMapping
from src.main.python.field_mapper.model.Validator import validator

logger = logging.getLogger(__name__)


class FieldConceptMapper:
    """
    Class to semantically map the fields from the baseline table.
    Usage:
    mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'))
    target = mapper.lookup('field_id', 'value')
    """

    CONFIG_FILE_NAME = 'field_mapping_config.yaml'

    def __init__(self, in_directory: Path = None, log_level: str = 'INFO'):
        logger.setLevel(log_level)
        self.field_mappings: Dict[str, FieldMapping] = {}
        self.date_field_mapping: Dict[str, str] = {}
        self.default_date_field: Optional[str] = None

        if in_directory:
            self.load(in_directory)

    def load(self, directory: Path):
        if not directory.exists():
            raise FileNotFoundError(f"No such directory: '{directory}'")

        with (directory / self.CONFIG_FILE_NAME).open() as config_file:
            config = yaml.full_load(config_file)

        for mapping_config in config['mappings']:
            mapping_filename = mapping_config['filename']
            mapping_path = directory / mapping_filename
            logger.info(f"Loading {mapping_path.name}...")
            if mapping_config['mappingApproach']['name'] == 'date':
                self.load_date_mapping(mapping_path)
                self.default_date_field = mapping_config['default_date_field']
            elif mapping_config['mappingApproach']['name'] == 'value_only':
                target_event_concept_id = int(mapping_config['event_concept_id'])
                self.load_file_value_only(mapping_path, target_event_concept_id)
            elif mapping_config['mappingApproach']['name'] == 'mapping_table':
                # For now this is specific for opcs3
                target_event_concept_id = int(mapping_config['event_concept_id'])
                mapping_config['field_ids'] = [str(x) for x in mapping_config['field_ids']]
                for field_id in mapping_config['field_ids']:  # TODO: to save memory, all these fields can refer to the same value mapping
                    self.load_file_mapping_table(mapping_path, field_id, target_event_concept_id)
            else:
                # Numeric or text
                self.load_usagi_file(mapping_path)

    def load_date_mapping(self, date_mapping_file: Path):
        with date_mapping_file.open() as f_in:
            for row in csv.DictReader(f_in):
                self.date_field_mapping[row['field']] = row['date_field']

    def load_usagi_file(self, file_path: Path):
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row, file_path.name)
            logger.debug(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")
            self._load(usagi_mapping)

    def load_file_value_only(self, file_path: Path, fixed_event_concept_id: int):
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row, file_path.name)
            logger.debug(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")
            fixed_event_target = create_fake_target_mapping(fixed_event_concept_id)
            self._load(usagi_mapping, fixed_event_target)

    def load_file_mapping_table(self, file_path: Path, fixed_field_id: str, fixed_event_concept_id: Optional[int] = None):
        for row in self._load_map(file_path):
            usagi_mapping = UsagiRow(row, file_path.name)
            # The value_code is in the sourceCode field, and no valueCode is given.
            usagi_mapping.value_code = usagi_mapping.field_id
            usagi_mapping.field_id = fixed_field_id
            usagi_mapping.value_description = usagi_mapping.field_description
            usagi_mapping.field_description = ''

            logger.debug(f"Loading {usagi_mapping.field_id}-{usagi_mapping.value_code}")
            fixed_event_target = create_fake_target_mapping(fixed_event_concept_id)
            self._load(usagi_mapping, fixed_event_target)

    def _load(self, usagi_mapping: UsagiRow, fixed_event_target: Optional[TargetMapping] = None):
        field_mapping = self.field_mappings.setdefault(
            usagi_mapping.field_id,
            FieldMapping(usagi_mapping.field_id)
        )
        field_mapping.add(usagi_mapping)

        if fixed_event_target:
            # assume given usagi mapping is only the value mapping of the field
            field_mapping.add_target_for_value(usagi_mapping.value_code, fixed_event_target)

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

    def lookup_one(self, field_id: str, value: str) -> Optional[MappingTarget]:
        pass

    def lookup(self, field_id: str, value: str) -> List[MappingTarget]:
        """
        For given field_id/value pair, looks up the target concept_id, value_as_concept_id, value_as_number and unit_concept_id.

        The mappings can be one of two types:
        1. Has a value mapping. The field_id/value pair maps to a concept_id and (optionally) a value_as_concept_id.
            There can be multiple event and value targets. All combinations are returned.
            However, typically there will be EITHER multiple event targets OR multiple value targets
        2. No value mapping. If no mapping for value found, the value is assumed to be numeric (float). Variable maps to concept_id and unit_concept_id.
            If mapping has a unit, values of -1 and -3 are ignored. These are considered 'not known' values.
        :param field_id: string
        :param value: string
        :return: List[MappingTarget]
        """
        field_mapping = self.get_mapping(field_id)

        if not field_mapping:
            logger.debug(f'Field "{field_id}" is unknown')
            # Do not map fields not in the mapping tables. These are by default ignored.
            return []

        if field_mapping.is_ignored():
            return []

        is_discrete = field_mapping.has_values()

        if is_discrete:
            source_value = field_id + "|" + value
            # Create categorical target(s)
            value_mapping = field_mapping.values.get(value)
            if not value_mapping:
                logger.warning(f'Value "{value}" for field_id "{field_id}" is unknown')
                return [MappingTarget(0, source_value)]

            if value_mapping.is_ignored():
                return []

            if not value_mapping.is_approved():
                logger.debug(f'Value "{value}" for field_id "{field_id}" is not approved')
                return [MappingTarget(0, source_value)]

            if not value_mapping.event_targets:
                logger.warning(f'"{field_id}-{value}" does not have an event_concept_id associated')
                target_event_concept_ids = [0]
            else:
                target_event_concept_ids = value_mapping.get_event_concept_ids()

            target_value_as_concept_ids = [None]
            if value_mapping.value_targets:
                target_value_as_concept_ids = value_mapping.get_value_concept_ids()

            # Return all combinations of event and value target
            # Typically, there will be EITER multiple event targets OR multiple value targets
            result = []
            for event_concept_id in target_event_concept_ids:
                for value_as_concept_id in target_value_as_concept_ids:
                    target = MappingTarget()
                    target.concept_id = event_concept_id
                    target.value_as_concept_id = value_as_concept_id
                    target.source_value = source_value
                    result.append(target)
            return result
        else:
            template_target = MappingTarget()
            template_target.source_value = field_id
            try:
                # Create numeric target
                template_target.value_as_number = float(value)
                is_numeric = True
            except ValueError:
                # Create text target
                template_target.value_as_string = value
                is_numeric = False

            if is_numeric and (value == '-1' or value == '-3'):
                # Ignore instances of 'Do not know' or 'Prefer not to answer'
                return []

            if not field_mapping.is_approved():
                logger.debug(f'Field_id "{field_id}" is not approved')
                template_target.concept_id = 0
                return [template_target]

            template_target.unit_concept_id = field_mapping.unit_target.concept_id if field_mapping.unit_target else 0

            if not field_mapping.event_targets:
                logger.warning(f'"{field_id}" does not have an event_concept_id associated')
                template_target.concept_id = 0
                return [template_target]

            result = []
            for event_target in field_mapping.event_targets:
                target = copy.copy(template_target)
                target.concept_id = event_target.concept_id
                result.append(target)
            return result

    def lookup_date_field(self, field_id: str) -> str:
        return self.date_field_mapping.get(field_id, self.default_date_field)


if __name__ == '__main__':
    mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'INFO')

    def _print(targets):
        if len(targets) == 0:
            print(None)
        elif len(targets) == 1:
            print(targets.pop())
        else:
            print(f'{len(targets)} targets')
            for t in targets:
                print(f'\t{str(t)}')

    # Some simple tests
    _print(mapper.lookup('50', '180'))  # numeric
    _print(mapper.lookup('46', '12.5'))  # numeric
    _print(mapper.lookup('30785', '8'))
    _print(mapper.lookup('2443', '0'))
    _print(mapper.lookup('2443', '1'))
    _print(mapper.lookup('4041', '-3'))  # Ignored
    _print(mapper.lookup('41256', '0552'))  # unknown field
    _print(mapper.lookup('4041', '123'))  # unknown value for categorical field
    # field mapping
    _print(mapper.lookup('20001', '1064'))  # unknown value for categorical field

    # opcs3
    _print(mapper.lookup('41256', '118'))
    _print(mapper.lookup('41258', '027'))  # one to many
    print(mapper.get_mapping('41258').values.get('027'))

    # get the mapping of a field
    # print(mapper.get_mapping('2335'))
    print(mapper.get_mapping('4041'))

    print('Date field lookup')
    print(mapper.lookup_date_field('46'))  # default
    print(mapper.lookup_date_field('30110'))  # custom

    print(f'{len(mapper.field_mappings):>6} field mappings loaded')
    print(f'{sum([len(x.get_values()) for x in mapper.field_mappings.values()]):>6,} value mappings loaded')

    validator.print_summary()
    # validator.print_all()
