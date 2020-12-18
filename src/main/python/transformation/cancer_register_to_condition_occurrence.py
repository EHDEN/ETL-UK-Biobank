from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
import logging

from ..util.date_functions import get_datetime, DEFAULT_DATETIME

from ..util.code_cleanup import add_dot_to_icdx_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

logger = logging.getLogger(__name__)


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
            # Check that the instance exists in the data.
            # Assume that if it does not exist for histology, it does not exist at all.
            if f'40011-{instance}.0' not in row:
                continue

            histology = return_string(row.get(f'40011-{instance}.0'))
            behaviour = return_string(row.get(f'40012-{instance}.0'))
            topography = return_string(row.get(f'40006-{instance}.0'))

            if topography != 'NULL':
                topography = add_dot_to_icdx_code(topography)
            # TODO: For the topography if ICD10 code is missing check if ICD9 code is present to use instead

            # Skip if topography empty and histology and behaviour not both given (000, 100, 010)
            if topography == 'NULL' and (histology == 'NULL' or behaviour == 'NULL'):
                continue

            if histology != 'NULL' and behaviour == 'NULL':  # 101
                # no behaviour given, default to uncertain behaviour
                source_code = f'{histology}/1-{topography}'
            elif histology == 'NULL':  # 001, 011
                # without histology, the behaviour is useless
                source_code = f'NULL-{topography}'
            else:  # 111, 110
                source_code = f'{histology}/{behaviour}-{topography}'

            target_concept = icdo3.lookup(source_code, first_only=True)
            if pd.isnull(target_concept):
                target_concept = icd10.lookup(source_code, first_only=True)

            datetime = get_datetime(row[f'40005-{instance}.0'])
            if datetime == DEFAULT_DATETIME:
                logger.warning('Date was not found in the cancer registry date field 40005 of baseline data')

            r = wrapper.cdm.ConditionOccurrence(
                person_id=person_id,
                condition_concept_id=target_concept.target_concept_id,
                condition_source_concept_id=target_concept.source_concept_id,
                condition_start_date=datetime.date(),
                condition_start_datetime=datetime,
                condition_type_concept_id=32879,  # Registry
                condition_source_value=source_code,
                data_source='baseline'
            )
            records.append(r)
    return records
