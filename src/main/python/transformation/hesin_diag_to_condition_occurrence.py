from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime
from ..util import create_hes_visit_occurrence_id, create_hes_visit_detail_id, refactor_icdx_code


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
    df['diag_icd9_dot'] = df['diag_icd9'].apply(refactor_icdx_code)
    df['diag_icd10_dot'] = df['diag_icd10'].apply(refactor_icdx_code)

    icd9 = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD9CM', restrict_to_codes=list(df['diag_icd9_dot']))
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD10', restrict_to_codes=list(df['diag_icd10_dot']))

    for _, row in df.iterrows():
        condition_date = get_datetime(row['admidate'], "%d/%m/%Y")

        person_id = row['eid']

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
        visit_occurrence_id = create_hes_visit_occurrence_id(row['eid'], row['spell_index'])
        visit_detail_id = create_hes_visit_detail_id(row['eid'], row['ins_index'])

        condition_status_concept_id = 32902 if row['level'] == '1' else 32908  # Primary, else Secondary diagnosis

        for target in diag_targets:
            yield wrapper.cdm.ConditionOccurrence(
                person_id=person_id,
                condition_concept_id=target.target_concept_id,
                condition_start_date=condition_date,
                condition_start_datetime=condition_date,
                condition_type_concept_id=32817,  # - 'EHR'
                condition_source_value=source_value,
                condition_source_concept_id=target.source_concept_id,
                visit_occurrence_id=visit_occurrence_id,
                visit_detail_id=visit_detail_id,
                condition_status_concept_id=condition_status_concept_id,
                condition_status_source_value=row['level'],
                data_source=f'HES-{row["dsource"]}'
            )
