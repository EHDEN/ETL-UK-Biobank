from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime
from ..util import add_dot_to_icdx_code


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

# TODO: Add CareSite id


def hesin_diag_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    hesin_diag_source = wrapper.source_data.get_source_file('hesin_diag.csv')
    hesin_diag = hesin_diag_source.get_csv_as_df(apply_dtypes=False)
    hesin_source = wrapper.source_data.get_source_file('hesin.csv')
    hesin = hesin_source.get_csv_as_df(apply_dtypes=False)
    hesin = hesin.drop_duplicates(subset=['eid', 'ins_index'])  # fix for synthetic data

    # Merge HES diag with HES on EID and INS_INDEX to get ADMIDATE and drop duplicates.
    df = hesin_diag.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))

    # Generate code mapping for ICD10 and ICD9, remove dot to get correct concept codes.
    df['diag_icd9_dot'] = df['diag_icd9'].apply(add_dot_to_icdx_code)
    df['diag_icd10_dot'] = df['diag_icd10'].apply(add_dot_to_icdx_code)
    icd9 = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD9CM', restrict_to_codes=list(df['diag_icd9_dot']))
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD10', restrict_to_codes=list(df['diag_icd10_dot']))

    # Use Condition type concept file to map if primary condition or secondary condition.
    with open('./resources/mapping_tables/condition_type_concepts.csv') as f_in:
        condition_type = csv.DictReader(f_in, delimiter=',')
        condition_type_concept = {}

        for row in condition_type:
            condition_type_concept[row['sourceCode']] = row['conceptId']

    records = []

    for _, row in df.iterrows():
        condition_type_concept_id = condition_type_concept.get(row['level'], 0)

        condition_date = get_datetime(row['admidate'], "%d/%m/%Y")

        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        # Map icd10 if given. If not, map the icd9 code.
        # If ICD code is filled, but no concept is found, then the lookup will return one target to 0
        # It is possible that multiple concepts are found for one ICD code,
        # loop through the lookup to retrieve all of them and save concept ID and source concept ID.
        if row['diag_icd10'] != '' and not pd.isna(row['diag_icd10']):
            source_value = row['diag_icd10']
            diag_targets = icd10.lookup(row['diag_icd10_dot'])
        elif row['diag_icd9'] != '' and not pd.isna(row['diag_icd9']):
            source_value = row['diag_icd9']
            diag_targets = icd9.lookup(row['diag_icd9_dot'])
        else:
            # No code given
            continue

        # Visit
        visit_occurrence_id = wrapper.lookup_visit_occurrence_id(
            person_id=person_id,
            record_source_value=f'HES-{row["spell_index"]}'
        )

        visit_detail_id = wrapper.lookup_visit_detail_id(
            person_id=person_id,
            record_source_value=f'HES-{row["ins_index"]}'
        )

        for target in diag_targets:
            r = wrapper.cdm.ConditionOccurrence(
                person_id=person_id,
                condition_concept_id=target.target_concept_id,
                condition_start_date=condition_date,
                condition_start_datetime=condition_date,
                condition_type_concept_id=condition_type_concept_id,
                condition_source_value=source_value,
                condition_source_concept_id=target.source_concept_id,
                visit_occurrence_id=visit_occurrence_id,
                visit_detail_id=visit_detail_id,
                data_source=f'HES-{row["dsource"]}'
            )
            records.append(r)
    return records
