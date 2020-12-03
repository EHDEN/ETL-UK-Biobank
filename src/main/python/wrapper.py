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

from pathlib import Path
from typing import Optional
import logging
import pandas as pd

from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from src.main.python.core import EtlWrapper
from src.main.python.transformation import *
import csv

logger = logging.getLogger(__name__)


class Wrapper(EtlWrapper):

    def __init__(self, database, config):
        super().__init__(database, config)
        # Load config settings
        self.source_folder = Path(config['run_options']['source_data_folder'])
        self.path_mapping_tables = Path('./resources/mapping_tables')
        self.path_sql_transformations = Path('./src/main/sql')

        # NOTE: replace the following with project-specific source table names!
        self.source_file_delimiter = ','

        # One session for all lookups done in the wrapper. Note: read_only
        self._session_for_lookups = self.db.get_new_session()

    def run(self):
        self.start_timing()

        logger.info('{:-^100}'.format(' SETUP '))

        self.drop_cdm()
        self.create_cdm()

        # TRANSFORMATIONS

        logger.info('{:-^100}'.format(' ETL '))

        # NOTE: replace the following with project-specific transformations from python/transformations/ or sql/ folder!
        # (make sure execution follows order of table dependencies)

        # python transformation:
        self.execute_transformation(covid_to_care_site)
        self.execute_transformation(assessment_center_to_care_site)
        self.execute_transformation(baseline_to_person)
        self.execute_transformation(death_to_death)
        self.execute_transformation(death_to_condition_occurrence)
        self.execute_transformation(gp_clinical_prescriptions_to_visit_occurrence)
        self.execute_transformation(covid_to_visit_occurrence)
        self.execute_transformation(baseline_to_visit_occurrence)
        self.execute_transformation(hesin_to_visit_occurrence)
        self.execute_transformation(hesin_diag_to_condition_occurrence)
        self.execute_transformation(gp_registrations_to_observation_period)
        self.execute_transformation(covid_to_observation)
        self.execute_transformation(baseline_to_stem)
        self.execute_transformation(hesin_oper_to_procedure_occurrence)
        self.execute_transformation(hesin_to_visit_detail)

        # Stem table to domains
        self.load_from_stem_table()

        logger.info('{:-^100}'.format(' Summary stats '))

        self.log_summary()
        self.log_runtime()

        self._session_for_lookups.close()

    def load_from_stem_table(self):
        # TODO: check whether any values cannot be mapped to corresponding domain (e.g. value_as_string to measurement)
        target_schema = 'omopcdm'  # TODO: target_schema from variable
        # Note: the stem_table.id is not used, we use the auto-increment of the domain tables itself.
        self.execute_sql_file('src/main/sql/stem_table_to_observation.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_measurement.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_condition_occurrence.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_procedure_occurrence.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_drug_exposure.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_device_exposure.sql', target_schema=target_schema)
        self.execute_sql_file('src/main/sql/stem_table_to_specimen.sql', target_schema=target_schema)

    def get_dataframe(self, source_file, use_columns: Optional[list] = None):
        df = pd.read_csv(self.source_folder / source_file, usecols=use_columns, dtype=object)
        return df

    def mapping_tables_lookup(self, mapping_file: str, add_info: Optional[str] = None, first_only: bool = True):
        """
        Create a dictionary to lookup target concept_id by source code from a mapping file.
        If mapping is not APPROVED, it is not included.
        :param mapping_file: path to the csv file with the mapping
        :param add_info: for some records we needed to find the standard concept by combine two source fields.
                         If this parameter is filled the dictionary keys will be a combination of the two fields.
        :param first_only: if True, return the first available match only (default True). If False, all targets are lists of concept ids.
        :return: the dictionary. values are either strings (first_only = True) or lists (first_only = False)
        """
        result = {}
        with open(mapping_file) as f_in:
            table_mapping = csv.DictReader(f_in, delimiter=',')

            for row in table_mapping:
                if row['mappingStatus'] != 'APPROVED':
                    continue

                if not add_info:
                    key = row['sourceCode']
                else:
                    key = (row['sourceCode'], row[add_info])

                target = row['conceptId']

                if first_only:
                    # value is string
                    if key in result:
                        # Skip if already exists
                        logger.warning(f'Source code "{key}" in {mapping_file} occurs twice. Only first is taken.')
                        continue
                    else:
                        result[key] = target
                else:
                    # value is list
                    if key in result:
                        result[key].append(target)
                    else:
                        result[key] = [target]
        return result

    def lookup_visit_occurrence_id(self, **kwargs) -> Optional[int]:
        return self.lookup_id(self.cdm.VisitOccurrence, 'visit_occurrence_id', **kwargs)

    def lookup_visit_detail_id(self, **kwargs) -> Optional[int]:
        return self.lookup_id(self.cdm.VisitDetail, 'visit_detail_id', **kwargs)

    def lookup_person_id(self, person_source_value) -> Optional[int]:
        return self.lookup_id(self.cdm.Person, 'person_id', person_source_value=person_source_value)

    def lookup_id(self, model, id_to_lookup, **kwargs) -> Optional[int]:
        query = self._session_for_lookups.query(model).filter_by(**kwargs)
        try:
            visit_record = query.one()
        except NoResultFound:
            return None
        except MultipleResultsFound:
            logger.warning(f'Multiple {id_to_lookup}\'s found for {kwargs}, returning first only')
            visit_record = query.first()
        return getattr(visit_record, id_to_lookup)
