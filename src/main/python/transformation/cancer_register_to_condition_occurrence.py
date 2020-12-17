from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime, DEFAULT_DATETIME

from ..util.code_cleanup import add_dot_to_icdx_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def return_string(value):
    if pd.isnull(value):
        return 'NULL'
    else:
        return str(value)


def cancer_register_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    source = wrapper.get_dataframe('baseline.csv')

    icdo3 = wrapper.code_mapper.generate_code_mapping_dictionary('ICDO3')
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10')

    records = []
    for _, row in source.iterrows():
        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        for instance in range(32):

            if not f'40011-{instance}.0' in row:
                continue

            histology = return_string(row[f'40011-{instance}.0'])
            behaviour = return_string(row[f'40012-{instance}.0'])

            topography = return_string(row[f'40006-{instance}.0'])
            if topography != 'NULL':
                topography = add_dot_to_icdx_code(topography)
            # TODO: For the topography if ICD10 code is missing check if ICD9 code is present to use instead

            if histology != 'NULL' and behaviour != 'NULL':
                source_code = f'{histology}/{behaviour}-{topography}'
            elif histology != 'NULL' and behaviour == 'NULL':
                source_code = f'{histology}/1-{topography}'
            elif histology == 'NULL' and behaviour == 'NULL' and topography != 'NULL':
                source_code = f'NULL-{topography}'
            elif histology == 'NULL' and behaviour == 'NULL' and topography == 'NULL':
                continue

            target_concept = icdo3.lookup(source_code, first_only=True)
            if pd.isnull(target_concept):
                target_concept = icd10.lookup(source_code, first_only=True)

            date_column = f'40005-{instance}.0'
            if date_column != '':
                datetime = get_datetime(row[date_column])
            else:
                datetime = DEFAULT_DATETIME
                print(f'Warning: date was not found in the cancer registry date field of baseline data')

            r = wrapper.cdm.ConditionOccurrence(
                person_id=person_id,
                condition_concept_id=target_concept.target_concept_id,
                condition_start_date=datetime.date(),
                condition_start_datetime=datetime,
                condition_type_concept_id=32883,  # Survey
                condition_source_value=source_code,
                data_source='baseline'
            )
            records.append(r)
    return records
