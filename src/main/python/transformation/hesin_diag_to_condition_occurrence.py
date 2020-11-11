from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_diag_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    hesin_diag = pd.DataFrame(wrapper.get_source_data('hesin_diag.csv'))
    hesin = pd.DataFrame(wrapper.get_source_data('hesin.csv'))

    source = hesin_diag.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))
    source = source.drop_duplicates(subset=['eid', 'admidate', 'diag_icd10'])

    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10')

    records = []

    for _, row in source.iterrows():
        # TODO: Add some documentation
        # TODO: Add ICD9 codes
        if row['diag_icd10'] == '' or row['diag_icd10'] in ['W019', 'S7200']:
            continue
        elif row['diag_icd10'] in ['S5250', 'M4796', 'M2333', 'S2240', 'M8695']:
            target_concept_id = icd10.lookup(insert_dot(row['diag_icd10'], '.', -2), first_only=True, full_mapping=True).target_concept_id
        elif not icd10.lookup(row['diag_icd10']):
            target_concept_id = icd10.lookup(insert_dot(row['diag_icd10'], '.', -1), first_only=True, full_mapping=True).target_concept_id
        else:
            target_concept_id = icd10.lookup(row['diag_icd10'], first_only=True, full_mapping=True).target_concept_id

        condition_date = get_datetime(row['admidate'], "%d/%m/%Y")
        r = wrapper.cdm.ConditionOccurrence(
            person_id=row['eid'],
            condition_concept_id=target_concept_id,
            condition_start_date=condition_date,
            condition_start_datetime=condition_date,
            condition_type_concept_id=0,  # TODO
            condition_source_value=row['diag_icd10'],
            condition_source_concept_id=0  # TODO
        )
        records.append(r)
    return records


def insert_dot(string, dot, index):
    return string[:index] + dot + string[index:]
