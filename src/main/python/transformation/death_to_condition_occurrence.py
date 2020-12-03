from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def death_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    death = wrapper.get_dataframe('death.csv')
    death['date_of_death'] = pd.to_datetime(death['date_of_death'], dayfirst=True)
    death = death.sort_values(by=['eid', 'date_of_death'])

    death_cause = wrapper.get_dataframe('death_cause.csv')
    death_cause = death_cause[death_cause['arr_index'] != '0']

    source = death.merge(death_cause, on='eid', how='left', suffixes=('', 'y_'))

    codes = death_cause['cause_icd10'].unique().tolist()
    mapper = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', restrict_to_codes=codes, remove_dot_from_codes=True)

    records = []
    for _, row in source.iterrows():
        if pd.isna(row['date_of_death']):
            continue
        if pd.isna(row['cause_icd10']):
            continue

        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        target = mapper.lookup(row['cause_icd10'], first_only=True)

        r = wrapper.cdm.ConditionOccurrence(
            person_id=person_id,
            condition_concept_id=target.target_concept_id,
            condition_start_date=row['date_of_death'],
            condition_start_datetime=row['date_of_death'],
            condition_type_concept_id=32815,  # Death Certificate
            condition_source_value=row['cause_icd10'],
            condition_source_concept_id=target.source_concept_id,
            data_source=f'death-{row["dsource"]}'
        )
        records.append(r)
    return records

