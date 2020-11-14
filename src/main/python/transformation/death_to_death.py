from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

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
    death = pd.DataFrame(wrapper.get_source_data('death.csv'))
    death['date_of_death'] = pd.to_datetime(death['date_of_death'], dayfirst=True)
    death = death.sort_values(by=['eid', 'date_of_death'])
    death = death.drop_duplicates(subset='eid', keep='first')  # Only keep first date of death

    death_cause = pd.DataFrame(wrapper.get_source_data('death_cause.csv'))
    death_cause = death_cause[death_cause['arr_index'] == '0']
    death_cause = death_cause.drop_duplicates(subset='eid', keep='first')  # In case multiple have arr_index 0, choose one

    source = death.merge(death_cause, on='eid', how='left', suffixes=('', 'y_'))

    # TODO: instantiate icd10 mapper

    records = []
    for _, row in source.iterrows():
        if pd.isna(row['date_of_death']):
            continue

        r = wrapper.cdm.Death(
            person_id=row['eid'],
            death_date=row['date_of_death'],
            death_datetime=row['date_of_death'],
            death_type_concept_id=type_lookup.get(row['source'], 0),
            cause_concept_id=0,  # TODO
            cause_source_concept_id=0,  # TODO
            cause_source_value=row['cause_icd10']
            # TODO: record source in separate field
        )
        records.append(r)

    return records
