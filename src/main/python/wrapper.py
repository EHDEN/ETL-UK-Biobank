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

import logging
from pathlib import Path

from omop_etl_wrapper import Wrapper as BaseWrapper
from omop_etl_wrapper.config.models import MainConfig

from src.main.python.transformation import *
from src.main.python import cdm


logger = logging.getLogger(__name__)


class Wrapper(BaseWrapper):
    cdm = cdm

    def __init__(self, config: MainConfig):
        super().__init__(config, cdm)

        # Load config settings
        # TODO: new config loading
        self.path_mapping_tables = Path('./resources/mapping_tables')
        self.path_sql_transformations = Path('./src/main/sql')

        # One session for all lookups done in the wrapper. Note: use for read_only
        # TODO: is still valid?
        self._session_for_lookups = self.db.get_new_session()

    def run(self):

        # self.start_timing()

        logger.info('{:-^100}'.format(' Source Counts '))
        # self.log_tables_rowcounts(self.source_folder)

        logger.info('{:-^100}'.format(' Setup '))

        # Prepare source
        self.create_schemas()
        self.drop_cdm()
        self.create_cdm()
        self.load_custom_vocabularies()

        # Load source to concept mappings
        # self.truncate_stcm_table()
        # self.load_stcm()

        # Load source data

        logger.info('{:-^100}'.format(' ETL '))

        # These queries are cdm6 specific
        # self.stem_table_to_domains()

        self.transform()

        # self.etl_stats.write_summary_files()
        self.etl_stats.log_summary()

        # self.log_summary()
        # self.log_runtime()

    def transform(self):
        self.execute_transformation(covid_to_care_site)
        self.execute_transformation(assessment_center_to_care_site)

        # Person and observation period
        self.execute_transformation(baseline_to_person)
        self.execute_transformation(gp_registrations_to_observation_period)

        # # Death
        # self.execute_transformation(death_to_death)
        # self.execute_transformation(death_to_condition_occurrence)
        #
        # # Visit
        # self.execute_transformation(gp_clinical_prescriptions_to_visit_occurrence)
        # self.execute_transformation(covid_to_visit_occurrence)
        # self.execute_transformation(baseline_to_visit_occurrence)
        # self.execute_transformation(hesin_to_visit_occurrence)
        #
        # self.execute_transformation(hesin_to_visit_detail)
        #
        # # Events
        # self.execute_transformation(baseline_to_stem)
        # self.execute_transformation(covid_to_observation)
        # self.execute_transformation(gp_clinical_to_stem_table)
        # self.execute_transformation(gp_prescriptions_to_drug_exposure)
        # self.execute_transformation(hesin_diag_to_condition_occurrence)
        # self.execute_transformation(hesin_oper_to_procedure_occurrence)
        #
        # # Stem table to domains
        # self.load_from_stem_table()

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


