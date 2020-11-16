from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_person(wrapper: Wrapper) -> List[Wrapper.cdm.Person]:
    race = wrapper.mapping_tables_lookup('./resources/mapping_tables/race_mapping.csv')
    gender = wrapper.mapping_tables_lookup('./resources/mapping_tables/gender_mapping.csv')

    source = pd.DataFrame(wrapper.get_source_data('baseline.csv'))

    records = []
    for _, row in source.iterrows():
        # TODO: check correct visit number for fields with multiple visits
        r = wrapper.cdm.Person(
            person_id=row['eid'],
            person_source_value=row['eid'],
            gender_concept_id=gender.get(row['31-0.0'], 0),
            gender_source_value=row['31-0.0'],
            year_of_birth=int(row['34-0.0']),
            month_of_birth=int(row['52-0.0']),
            ethnicity_concept_id=0,
            race_concept_id=race.get(row['21000-0.0'], 0),
            race_source_value=row['21000-0.0'],
            # TODO: use this or care_site?
            location_id=row['54-0.0']
            )
        records.append(r)

    return records
