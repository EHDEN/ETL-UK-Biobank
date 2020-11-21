from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

# TODO: Add CareSite id


def hesin_diag_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    hesin_diag = wrapper.get_dataframe('hesin_diag.csv')
    hesin = wrapper.get_dataframe('hesin.csv')
    hesin = hesin.drop_duplicates(subset=['eid', 'ins_index'])  # fix for synthetic data

    # Merge HES diag with HES on EID and INS_INDEX to get ADMIDATE and drop duplicates.
    source = hesin_diag.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))

    # Generate code mapping for ICD10 and ICD9, remove dot to get correct concept codes.
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', remove_dot_from_codes=True)
    icd9 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD9CM', remove_dot_from_codes=True)  # TODO: should be 'regular' ICD9

    # Use Condition type concept file to map if primary condition or secondary condition.
    with open('./resources/mapping_tables/condition_type_concepts.csv') as f_in:
        condition_type = csv.DictReader(f_in, delimiter=',')
        condition_type_concept = {}

        for row in condition_type:
            condition_type_concept[row['sourceCode']] = row['conceptId']

    records = []

    for _, row in source.iterrows():
        condition_type_concept_id = condition_type_concept.get(row['level'], 0)

        condition_date = get_datetime(row['admidate'], "%d/%m/%Y")

        # Map icd10 if given. If not, map the icd9 code.
        # If ICD code is filled, but no concept is found, then the lookup will return one target to 0
        # It is possible that multiple concepts are found for one ICD code,
        # loop through the lookup to retrieve all of them and save concept ID and source concept ID.
        if row['diag_icd10'] != '':
            diag_targets = icd10.lookup(row['diag_icd10'])
        elif row['diag_icd9'] != '':
            diag_targets = icd9.lookup(row['diag_icd9'])
        else:
            # No code given
            continue

        # Visit
        visit_occurrence_id = wrapper.lookup_visit(row['eid'], 'HES-' + str(row['spell_index']))

        for target in diag_targets:
            r = wrapper.cdm.ConditionOccurrence(
                person_id=row['eid'],
                condition_concept_id=target.target_concept_id,
                condition_start_date=condition_date,
                condition_start_datetime=condition_date,
                condition_type_concept_id=condition_type_concept_id,
                condition_source_value=row['diag_icd10'] or row['diag_icd9'],
                condition_source_concept_id=target.source_concept_id,
                visit_occurrence_id=visit_occurrence_id,
                data_source=f'HES-{row["dsource"]}'
            )
            records.append(r)
    return records
