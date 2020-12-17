from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime, DEFAULT_DATETIME

from .baseline_to_stem import parse_column_name

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def cancer_register_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    cancer_fields = ('40005', '40006', '40011', '40012')
    cancer_fields = ['eid']+[f'{i}-{j}.0' for i in cancer_fields for j in range(32)]
    source = wrapper.get_dataframe('baseline.csv', use_columns=cancer_fields)

    icdo3 = wrapper.code_mapper.generate_code_mapping_dictionary('ICDO3', remove_dot_from_codes=True)
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', remove_dot_from_codes=True)

    records = []
    for _, row in source.iterrows():
        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        for instance in range(32):

            histology = row[f'40011-{instance}.0']
            behaviour = row[f'40012-{instance}.0']
            topography = row[f'40006-{instance}.0']

            if not ((histology == '' or pd.isna(histology)) and (behaviour == '' or pd.isna(behaviour))):
                source_code = f'{histology}/{behaviour}-{topography}'
            elif (not (histology == '' or pd.isna(histology))) and (behaviour == '' or pd.isna(behaviour)):
                source_code = f'{histology}/1-{topography}'
            elif (histology == '' or pd.isna(histology)) and (behaviour == '' or pd.isna(behaviour)):
                source_code = f'NULL-{topography}'
            else:
                continue

            concept_id = icdo3.lookup(source_code)
            if pd.isnull(concept_id):
                concept_id = icd10.lookup(source_code)

            date_column = f'40005-{instance}.0'
            if date_column != '':
                datetime = get_datetime(row[date_column])
            else:
                datetime = DEFAULT_DATETIME
                print(f'Warning: date was not found in the cancer registry date field of baseline data')

            r = wrapper.cdm.ConditionOccurrence(
                person_id=person_id,
                condition_concept_id=concept_id,
                condition_start_date=datetime.date(),
                condition_start_datetime=datetime,
                condition_source_value=source_code,
                data_source='baseline'
                )
            records.append(r)
    return records
