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

import csv
import logging
from pathlib import Path
from typing import Dict, Optional, Iterable

from delphyne import Wrapper as BaseWrapper
from delphyne.config.models import MainConfig
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound
import src.main.python.util.date_functions as date_util
import datetime

from src.main.python.transformation import *
from src.main.python import cdm

logger = logging.getLogger(__name__)


class Wrapper(BaseWrapper):
    cdm = cdm

    def __init__(self, config: MainConfig, load_gp_regular: bool, load_gp_covid19: bool, load_death_from_baseline: bool):
        super().__init__(config, cdm)

        # Load config settings
        self.path_mapping_tables = Path('./resources/mapping_tables')
        self.load_gp_regular = load_gp_regular
        self.load_gp_covid19 = load_gp_covid19
        self.load_death_from_baseline = load_death_from_baseline

    def run(self):

        # Prepare source
        self.create_schemas()
        self.drop_cdm()
        self.create_cdm()
        self.execute_sql_file('add_vocabulary_views.sql')

        # Load (custom) vocabularies and source_to_concept_map tables
        try:
            self.vocab_manager.standard_vocabularies.load()
        except ValueError as e:
            logger.warning(f'Standard vocabulary loading failed: {e.message}')

        try:
            self.vocab_manager.load_custom_vocab_and_stcm_tables()
        except Exception as e:
            logger.warning(f'Custom vocabulary and STCM loading failed: {e.message}')

        # Remove constraints and indexes to improve performance
        self.db.constraint_manager.drop_cdm_constraints()

        # Load source data
        self.transform()

        # Add constraints and indexes
        self.db.constraint_manager.add_cdm_constraints(errors='ignore')

        # Log/write overview of transformations and sources
        logger.info('{:-^100}'.format(' Summary stats '))
        self.summarize()

    def transform(self):
        self.execute_batch_transformation(covid_to_care_site, bulk=True, batch_size=100000)
        self.execute_batch_transformation(assessment_center_to_care_site, bulk=True, batch_size=100000)

        # Person
        self.execute_batch_transformation(baseline_to_person, bulk=True, batch_size=100000)

        # Death
        if self.load_death_from_baseline:
            self.execute_batch_transformation(baseline_to_death, bulk=True, batch_size=100000)
            self.execute_batch_transformation(baseline_to_condition_occurrence, bulk=True, batch_size=100000)
        else:  # from death tables
            self.execute_batch_transformation(death_to_death, bulk=True, batch_size=100000)
            self.execute_batch_transformation(death_to_condition_occurrence, bulk=True, batch_size=100000)

        # Baseline
        self.execute_batch_transformation(baseline_to_visit_occurrence, bulk=True, batch_size=100000)
        self.execute_batch_transformation(baseline_to_stem, bulk=True, batch_size=100000)
        self.execute_batch_transformation(cancer_register_to_condition_occurrence, bulk=True, batch_size=100000)

        # Covid tests
        self.execute_batch_transformation(covid_to_visit_occurrence, bulk=True, batch_size=100000)
        self.execute_batch_transformation(covid_to_observation, bulk=True, batch_size=100000)
        self.execute_batch_transformation(covid_to_measurement, bulk=True, batch_size=100000)

        # GP
        if self.load_gp_regular:
            self.execute_batch_transformation(gp_clinical_prescriptions_to_visit_occurrence, bulk=True, batch_size=100000)
            self.execute_batch_transformation(gp_clinical_to_stem_table, bulk=True, batch_size=100000)
            self.execute_batch_transformation(gp_prescriptions_to_drug_exposure, bulk=True, batch_size=100000)

        # HES
        self.execute_batch_transformation(hesin_to_visit_occurrence, bulk=True, batch_size=100000)
        self.execute_batch_transformation(hesin_to_visit_detail, bulk=True, batch_size=100000)
        self.execute_batch_transformation(hesin_diag_to_condition_occurrence, bulk=True, batch_size=100000)
        self.execute_batch_transformation(hesin_oper_to_procedure_occurrence, bulk=True, batch_size=100000)

        # COVID-19 GP tables
        if self.load_gp_covid19:
            self.execute_batch_transformation(covid19_emis_gp_clinical_scripts_to_visit_occurrence, bulk=True, batch_size=100000)
            self.execute_batch_transformation(covid19_tpp_gp_clinical_scripts_to_visit_occurrence, bulk=True, batch_size=100000)
            self.execute_batch_transformation(covid19_emis_gp_clinical_to_stem_table, bulk=True, batch_size=100000)
            self.execute_batch_transformation(covid19_emis_gp_scripts_to_drug_exposure, bulk=True, batch_size=100000)
            self.execute_batch_transformation(covid19_tpp_gp_scripts_to_drug_exposure, bulk=True, batch_size=100000)
            self.execute_batch_transformation(covid19_tpp_gp_clinical_to_stem_table, bulk=True, batch_size=100000)

        # CDM Source
        self.execute_transformation(cdm_source, bulk=True)

        # Stem table to domains
        self.load_from_stem_table()

        # Post process
        logger.info('Observation Period...')
        self.execute_sql_file('observation_period.sql')
        logger.info('Creating eras...')
        self.execute_sql_file('drug_era.sql')
        self.execute_sql_file('condition_era.sql')

    def load_from_stem_table(self):
        # TODO: check whether any values cannot be mapped to corresponding domain (e.g. value_as_string to measurement)
        # Note: the stem_table.id is not used, we use the auto-increment of the domain tables itself.
        self.execute_sql_file('stem_table_to_observation.sql')
        self.execute_sql_file('stem_table_to_measurement.sql')
        self.execute_sql_file('stem_table_to_condition_occurrence.sql')
        self.execute_sql_file('stem_table_to_procedure_occurrence.sql')
        self.execute_sql_file('stem_table_to_drug_exposure.sql')
        self.execute_sql_file('stem_table_to_device_exposure.sql')
        self.execute_sql_file('stem_table_to_specimen.sql')

    def mapping_tables_lookup(self, mapping_file: str, add_info: Optional[str] = None, first_only: bool = True, approved_only: bool = True):
        """
        Create a dictionary to lookup target concept_id by source code from a mapping file.
        If mapping is not APPROVED, it is not included.
        :param mapping_file: path to the csv file with the mapping
        :param add_info: for some records we needed to find the standard concept by combining two source fields.
                         If this parameter is filled the dictionary keys will be a combination of the two fields.
        :param first_only: if True, return the first available match only (default True). If False, all targets are lists of concept ids.
        :param approved_only: if True, return only approved mappings (mappingStatus=approved)
        :return: the dictionary. values are either strings (first_only = True) or lists (first_only = False)
        """
        result = {}
        with open(mapping_file) as f_in:
            table_mapping = csv.DictReader(f_in, delimiter=',')

            for row in table_mapping:
                if approved_only and row['mappingStatus'] != 'APPROVED':
                    continue

                if not add_info:
                    key = row['sourceCode']
                else:
                    key = (row['sourceCode'], row[add_info])

                target = int(row['conceptId'])

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
        return self.lookup_field_from_model(self.cdm.VisitOccurrence, 'visit_occurrence_id', **kwargs)

    def lookup_visit_detail_id(self, **kwargs) -> Optional[int]:
        return self.lookup_field_from_model(self.cdm.VisitDetail, 'visit_detail_id', **kwargs)

    def lookup_person_id(self, person_source_value) -> Optional[int]:
        return self.lookup_field_from_model(self.cdm.Person, 'person_id',
                                            person_source_value=person_source_value)

    def lookup_person_yob(self, person_source_value) -> Optional[int]:
        return self.lookup_field_from_model(self.cdm.Person, 'year_of_birth',
                                            person_source_value=person_source_value)

    def lookup_ukb_vocab(self, source_code) -> Optional[int]:
        return self.lookup_field_from_model(self.cdm.Concept, 'concept_id',
                                            concept_code=source_code, vocabulary_id='UK Biobank')

    def lookup_field_from_model(self, model, id_to_lookup, **kwargs) -> Optional[int]:
        with self.db.session_scope() as session:
            query = session.query(model).filter_by(**kwargs)
            try:
                visit_record = query.one()
            except NoResultFound:
                return None
            except MultipleResultsFound:
                logger.warning(f'Multiple {id_to_lookup}\'s found for {kwargs}, returning first only')
                visit_record = query.first()
            return getattr(visit_record, id_to_lookup)

    def generate_code_to_concept_id_dict(self, vocabulary_codes: Iterable[str], vocabulary_id: str) \
            -> Dict[str, int]:

        vocabulary_codes = list(set(vocabulary_codes))  # remove redundant codes

        with self.db.session_scope() as session:
            records = session.query(
                self.cdm.Concept.concept_id,
                self.cdm.Concept.concept_code) \
                .filter(self.cdm.Concept.vocabulary_id == vocabulary_id) \
                .filter(self.cdm.Concept.concept_code.in_(vocabulary_codes)) \
                .all()

        mapping_dict = {}
        for record in records:
            mapping_dict[record.concept_code] = record.concept_id

        not_found = set(vocabulary_codes) - set(mapping_dict.keys())
        if not_found:
            logger.warning(f'No mapping to concept_id could be generated for '
                           f'{len(not_found)}/{len(vocabulary_codes)} vocabulary codes:'
                           f' {not_found}')
        return mapping_dict

    def get_gp_datetime(self, date: str, person_source_value: str, format='%Y-%m-%d', default_date=None) \
            -> Optional[datetime.datetime]:
        """
        Resolves placeholder dates in GP data
        """
        gp_datetime = date_util.get_datetime(date, format, default_date)

        if not gp_datetime:
            return default_date

        # 1902-02-02 and 1903-03-03 are placeholder dates for events happening around birth
        if gp_datetime == datetime.datetime(1902, 2, 2) or gp_datetime == datetime.datetime(1903, 3, 3):
            year_of_birth = self.lookup_person_yob(person_source_value)
            return datetime.datetime(year_of_birth, 7, 1)

        # Dates in year 2037 are placeholder for unknown date
        if gp_datetime.year == 2037:
            return default_date

        return gp_datetime
