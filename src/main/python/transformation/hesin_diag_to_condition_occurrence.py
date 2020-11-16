from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

# TODO: Add CareSite id
# TODO: Add Visit Occurrence id


def hesin_diag_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    hesin_diag = pd.DataFrame(wrapper.get_source_data('hesin_diag.csv'))
    hesin = pd.DataFrame(wrapper.get_source_data('hesin.csv'))

    # Merge HES diag with HES on EID and INS_INDEX to get ADMIDATE and drop duplicates.
    source = hesin_diag.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))
    source = source.drop_duplicates(subset=['eid', 'admidate', 'diag_icd10', 'diag_icd9'])

    # Generate code mapping for ICD10 and ICD9, remove dot to get correct concept codes.
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', remove_dot=True)
    icd9 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD9CM', remove_dot=True)

    # Use Condition type concept file to map if primary condition or secondary condition.
    with open('./resources/mapping_tables/condition_type_concepts.csv') as f_in:
        condition_type = csv.DictReader(f_in, delimiter=',')
        condition_type_concept = {}

        for row in condition_type:
            condition_type_concept[row['sourceCode']] = row['conceptId']

    records = []

    for _, row in source.iterrows():
        condition_type_concept_id = condition_type_concept.get(row['level'])

        condition_date = get_datetime(row['admidate'], "%d/%m/%Y")

        if row['diag_icd10'] != '':
            # If ICD10 code is filled, but no concept is found, add concept ID 0.
            if not icd10.lookup(row['diag_icd10'], full_mapping=True):
                target_concept_id = 0
                condition_source_concept_id = 0
                r = wrapper.cdm.ConditionOccurrence(
                    person_id=row['eid'],
                    condition_concept_id=target_concept_id,
                    condition_start_date=condition_date,
                    condition_start_datetime=condition_date,
                    condition_type_concept_id=condition_type_concept_id,
                    condition_source_value=row['diag_icd10'],
                    condition_source_concept_id=condition_source_concept_id,
                    # visit_occurrence_id=row['spell_index']
                )
                records.append(r)
            else:
                # It is possible that multiple concepts are found for one ICD code,
                # loop through the lookup to retrieve all of them and save concept ID and source concept ID.
                for x in range(len(icd10.lookup(row['diag_icd10'], full_mapping=True))):
                    target_concept_id = icd10.lookup(row['diag_icd10'], full_mapping=True)[x].target_concept_id
                    condition_source_concept_id = icd10.lookup(row['diag_icd10'], full_mapping=True)[x].source_concept_id

                    r = wrapper.cdm.ConditionOccurrence(
                        person_id=row['eid'],
                        condition_concept_id=target_concept_id,
                        condition_start_date=condition_date,
                        condition_start_datetime=condition_date,
                        condition_type_concept_id=condition_type_concept_id,
                        condition_source_value=row['diag_icd10'],
                        condition_source_concept_id=condition_source_concept_id,
                        # visit_occurrence_id=row['spell_index']
                    )
                    records.append(r)

        if row['diag_icd9'] != '':
            # If ICD9 code is filled, but no concept is found, add concept ID 0.
            if not icd9.lookup(row['diag_icd9'], full_mapping=True):
                target_concept_id = 0
                condition_source_concept_id = 0
                r = wrapper.cdm.ConditionOccurrence(
                    person_id=row['eid'],
                    condition_concept_id=target_concept_id,
                    condition_start_date=condition_date,
                    condition_start_datetime=condition_date,
                    condition_type_concept_id=condition_type_concept_id,
                    condition_source_value=row['diag_icd9'],
                    condition_source_concept_id=condition_source_concept_id,
                    # visit_occurrence_id=row['spell_index']
                )
                records.append(r)
            else:
                # It is possible that multiple concepts are found for one ICD code,
                # loop through the lookup to retrieve all of them and save concept ID and source concept ID.
                for x in range(len(icd9.lookup(row['diag_icd9'], full_mapping=True))):
                    target_concept_id = icd9.lookup(row['diag_icd9'], full_mapping=True)[x].target_concept_id
                    condition_source_concept_id = icd9.lookup(row['diag_icd9'], full_mapping=True)[x].source_concept_id

                    r = wrapper.cdm.ConditionOccurrence(
                        person_id=row['eid'],
                        condition_concept_id=target_concept_id,
                        condition_start_date=condition_date,
                        condition_start_datetime=condition_date,
                        condition_type_concept_id=condition_type_concept_id,
                        condition_source_value=row['diag_icd9'],
                        condition_source_concept_id=condition_source_concept_id,
                        # visit_occurrence_id=row['spell_index']
                    )
                    records.append(r)
    return records
