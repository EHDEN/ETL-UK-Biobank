from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import refactor_icdx_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

type_lookup = {  # TODO: any other flavours?
    '1':  32815,  # Death Certificate
    '2':  32815,
    '7':  32815,
    '19': 32815,
    '52': 32815,
    '54': 32815,
    '55': 32815
}


def death_to_death(wrapper: Wrapper) -> List[Wrapper.cdm.Death]:
    death_source = wrapper.source_data.get_source_file('death.csv')
    death = death_source.get_csv_as_df(apply_dtypes=False)
    death['date_of_death'] = pd.to_datetime(death['date_of_death'], dayfirst=True)
    death = death.sort_values(by=['eid', 'date_of_death'])
    death = death.drop_duplicates(subset='eid', keep='first')  # Only keep first date of death

    death_cause_source = wrapper.source_data.get_source_file('death_cause.csv')
    death_cause = death_cause_source.get_csv_as_df(apply_dtypes=False)
    death_cause = death_cause[death_cause['arr_index'] == '0']
    death_cause = death_cause.drop_duplicates(subset='eid', keep='first')  # In case multiple have arr_index 0, choose one

    df = death.merge(death_cause, on='eid', how='left', suffixes=('', 'y_'))

    df['cause_icd10_dot'] = df['cause_icd10'].apply(refactor_icdx_code)

    mapper = wrapper.code_mapper.generate_code_mapping_dictionary(
        'ICD10', restrict_to_codes=list(df['cause_icd10_dot']))

    records = []
    for _, row in df.iterrows():
        if pd.isna(row['date_of_death']):
            continue

        person_id = row['eid']

        target = mapper.lookup(row['cause_icd10_dot'], first_only=True)
        yield wrapper.cdm.Death(
            person_id=person_id,
            death_date=row['date_of_death'],
            death_datetime=row['date_of_death'],
            death_type_concept_id=type_lookup.get(row['source'], 0),
            cause_concept_id=target.target_concept_id,
            cause_source_concept_id=target.source_concept_id,
            cause_source_value=row['cause_icd10']
            # TODO: record source in separate field
        )
