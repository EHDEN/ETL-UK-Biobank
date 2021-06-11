from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
import logging
import re

from ..util.date_functions import get_datetime, DEFAULT_DATETIME

from ..util.code_cleanup import refactor_icdx_code, icd_code_map

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

    # To reduce memory, identify which columns from the baseline table should be used
    # The topography columns are used to restrict the number of ICD10 codes that need to be looked up.
    columns_to_use = []
    topography10_columns = []
    topography9_columns = []
    columns_available = next(source.get_csv_as_generator_of_dicts()).keys()
    pattern = re.compile(r'eid|40005|40006|40011|40012|40013')  # only these five field_ids are needed
    pattern_topography10 = re.compile(r'40006')
    pattern_topography9 = re.compile(r'40013')
    for column_name in columns_available:
        if pattern.match(column_name):
            columns_to_use.append(column_name)
        if pattern_topography10.match(column_name):
            topography10_columns.append(column_name)
        if pattern_topography9.match(column_name):
            topography9_columns.append(column_name)

    df = source.get_csv_as_df(apply_dtypes=False, usecols=columns_to_use)

    df[topography10_columns] = df[topography10_columns].applymap(lambda x: x if x == 'NULL' else refactor_icdx_code(x))
    df[topography9_columns] = df[topography9_columns].applymap(lambda x: x if x == 'NULL' else refactor_icdx_code(x))

    icdo3 = wrapper.code_mapper.generate_code_mapping_dictionary('ICDO3')
    icd10 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10',
                                restrict_to_codes=df[topography10_columns].stack().tolist())
    icd9 = wrapper.code_mapper.generate_code_mapping_dictionary('ICD9CM',
                                restrict_to_codes=df[topography9_columns].stack().tolist())

    icd10_to_o3 = pd.read_csv("./resources/encodings/icd10_to_icdo3_one_to_one_mappings.csv")
    icd10_to_o3_dict = icd10_to_o3.set_index('ICDO3').T.to_dict('list')

    records = []
    for _, row in df.iterrows():
        person_id = row['eid']

        for instance in range(32):
            # Check that the instance exists in the data.
            # Assume that if it does not exist for histology, it does not exist at all.
            if f'40011-{instance}.0' not in row:
                continue

            histology = return_string(row.get(f'40011-{instance}.0'))
            behaviour = return_string(row.get(f'40012-{instance}.0'))
            topo_icd10 = return_string(row.get(f'40006-{instance}.0'))
            topo_icd9 = return_string(row.get(f'40013-{instance}.0'))

            topo_icdo3 = icd_code_map(icd10_to_o3_dict, topo_icd10)

            if histology == 'NULL' and topo_icd10 == 'NULL' and topo_icd9 == 'NULL':
                # Case 000, 010: Skip if topography empty for both ICD9 and ICD10 codes and histology not given
                continue

            if histology != 'NULL' and behaviour == 'NULL':
                # 101, 100: no behaviour given, default to uncertain behaviour
                source_code = f'{histology}/1-{topo_icdo3}'
            elif histology == 'NULL':
                # 001, 011: without histology, the behaviour is useless
                source_code = f'NULL-{topo_icdo3}'
            else:
                # 111, 110
                source_code = f'{histology}/{behaviour}-{topo_icdo3}'

            target_concept = icdo3.lookup(source_code, first_only=True)

            # If no ICDO3 code found
            if target_concept.source_concept_id == 0 and topo_icd10 != 'NULL':
                # Try to lookup by just ICD10 topography
                source_code = f'{topo_icd10}'
                target_concept = icd10.lookup(topo_icd10, first_only=True)
            elif target_concept.source_concept_id == 0 and topo_icd9 != 'NULL':
                # If no ICD10 code try look with the ICD9 code
                source_code = f'{topo_icd9}'
                target_concept = icd9.lookup(topo_icd9, first_only=True)

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
            yield r
