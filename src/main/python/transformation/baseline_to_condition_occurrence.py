from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import refactor_icdx_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    source = wrapper.source_data.get_source_file('baseline.csv')
    df = source.get_csv_as_df(apply_dtypes=False, usecols=['eid', '40000-0.0', '40002-0.1'])

    source_death = wrapper.source_data.get_source_file('death_cause.csv')
    df_death = source_death.get_csv_as_df(apply_dtypes=False)
    secondary_death = df_death[df_death['arr_index'] != '0'][['eid', 'cause_icd10']]\
        .apply(tuple, axis=1).tolist()

    df['ICD10_dot'] = df['40002-0.1'].apply(refactor_icdx_code)

    mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary(
            'ICD10', restrict_to_codes=list(df['ICD10_dot']))

    for _, row in df.iterrows():
        if pd.isna(row['40000-0.0']):
            continue

        if pd.isna(row['40002-0.1']):
            continue

        # if the person, icd code combination is already in the death registry it has been mapped
        if (row['eid'], row['40002-0.1']) in secondary_death:
            continue

        target = mapper.lookup(row['ICD10_dot'], first_only=True)
        yield wrapper.cdm.ConditionOccurrence(
            person_id=int(row['eid']),
            condition_concept_id=target.target_concept_id,
            condition_start_date=row['40000-0.0'],
            condition_start_datetime=row['40000-0.0'],
            condition_type_concept_id=32815,  # Death Certificate
            condition_source_concept_id=target.source_concept_id,
            condition_source_value=row['40002-0.1']
        )
