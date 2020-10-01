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
import logging
from src.main.python.core import EtlWrapper
from src.main.python.core.source_data import SourceData
import src.main.python.core.model as cdm
from src.main.python.transformation import *


logger = logging.getLogger(__name__)

class Wrapper(EtlWrapper):

    def __init__(self, database, config):
        super().__init__(database, config)
        # Load config settings
        self.source_folder = Path(config['run_options']['source_data_folder'])
        self.path_mapping_tables = Path('./resources/mapping_tables')
        self.path_sql_transformations = Path('./src/main/sql')
        self.cdm = cdm
        # NOTE: replace the following with project-specific source table names!
        self.baseline_to_person = None

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
        self.execute_transformation(baseline_to_person)

        # sql transformation:
        # self.execute_sql_file(self.path_sql_transformations / 'sample_script.sql')

        self.log_summary()
        self.log_runtime()

    # NOTE: replace the following with project-specific functions to load source tables!
    def get_baseline_to_person(self):
        if not self.baseline_to_person:
            self.baseline_to_person = SourceData(self.source_folder / 'baseline_to_person.csv',
                                                 delimiter=',')
        return self.baseline_to_person
