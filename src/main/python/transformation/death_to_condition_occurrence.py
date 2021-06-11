from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import refactor_icdx_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def death_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    death_source = wrapper.source_data.get_source_file('death.csv')
    death = death_source.get_csv_as_df(apply_dtypes=False)
    death['date_of_death'] = pd.to_datetime(death['date_of_death'], dayfirst=True)
    death = death.sort_values(by=['eid', 'date_of_death'])

    death_cause_source = wrapper.source_data.get_source_file('death_cause.csv')
    death_cause = death_cause_source.get_csv_as_df(apply_dtypes=False)
    death_cause = death_cause[death_cause['arr_index'] != '0']

    df = death.merge(death_cause, on='eid', how='left', suffixes=('', 'y_'))

    df['cause_icd10_dot'] = df['cause_icd10'].apply(refactor_icdx_code)

    mapper = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD10', restrict_to_codes=list(df['cause_icd10_dot']))

    for _, row in df.iterrows():
        if pd.isna(row['date_of_death']):
            continue
        if pd.isna(row['cause_icd10']):
            continue

        person_id = row['eid']

        target = mapper.lookup(row['cause_icd10_dot'], first_only=True)

        yield wrapper.cdm.ConditionOccurrence(
            person_id=person_id,
            condition_concept_id=target.target_concept_id,
            condition_start_date=row['date_of_death'],
            condition_start_datetime=row['date_of_death'],
            condition_type_concept_id=32815,  # Death Certificate
            condition_source_value=row['cause_icd10'],
            condition_source_concept_id=target.source_concept_id,
            data_source=f'death-{row["dsource"]}'
        )
