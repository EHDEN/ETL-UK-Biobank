from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
import logging
import re

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
    source = wrapper.source_data.get_source_file('baseline.csv')

    # To reduce memory, identify which columsn from the baseline table should be used
    # The topography columns are used to restrict the number of ICD10 codes that need to be looked up.
    columns_to_use = []
    topography_columns = []
    columns_available = next(source.get_csv_as_generator_of_dicts()).keys()
    pattern = re.compile(r'eid|40005|40006|40011|40012')  # only these five field_ids are needed
    pattern_topography = re.compile(r'40006')
    for column_name in columns_available:
        if pattern.match(column_name):
            columns_to_use.append(column_name)
        if pattern_topography.match(column_name):
            topography_columns.append(column_name)

    df = source.get_csv_as_df(apply_dtypes=False, usecols=columns_to_use)

    df[topography_columns] = df[topography_columns].applymap(add_dot_to_icdx_code)

    icdo3 = wrapper.code_mapper.generate_code_mapping_dictionary('ICDO3')
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', restrict_to_codes=df[topography_columns].stack().tolist())

    records = []
    for _, row in df.iterrows():
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

            # TODO: For the topography if ICD10 code is missing check if ICD9 code is present to use instead

            # Skip if topography empty and histology and behaviour not both given (000, 100, 010)
            # Case 100 is covered in baseline_to_stem script.
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
            if target_concept.source_concept_id == 0:  # If no ICDO3 code found, try to lookup by just ICD10 topography
                target_concept = icd10.lookup(topography, first_only=True)

            datetime = get_datetime(row[f'40005-{instance}.0'])
            if datetime == DEFAULT_DATETIME:
                logger.warning(f'Date field 40005-{instance}.0 was not found in the cancer registry of baseline data')

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
