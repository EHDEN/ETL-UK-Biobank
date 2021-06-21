from __future__ import annotations

from typing import List, TYPE_CHECKING
from src.main.python.util import is_null

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_person(wrapper: Wrapper) -> List[Wrapper.cdm.Person]:
    race = wrapper.mapping_tables_lookup('./resources/mapping_tables/race_mapping.csv')
    gender = wrapper.mapping_tables_lookup('./resources/mapping_tables/gender_mapping.csv')

    source = wrapper.source_data.get_source_file('baseline.csv')
    df = source.get_csv_as_df(apply_dtypes=False, usecols=['eid', '31-0.0', '34-0.0',
                                                           '52-0.0', '21000-0.0', '54-0.0'])

    for _, row in df.iterrows():
        yob_str = row['34-0.0']
        mob_str = row['52-0.0']

        if is_null(yob_str):
            # skip if no year of birth. TODO: als skip all other records of this person to prevent
            continue

        yield wrapper.cdm.Person(
            person_id=row['eid'],
            person_source_value=row['eid'],
            gender_concept_id=gender.get(row['31-0.0'], 0),
            gender_source_value=row['31-0.0'],
            year_of_birth=int(yob_str),
            month_of_birth=int(mob_str) if mob_str else None,
            ethnicity_concept_id=0,
            race_concept_id=race.get(row['21000-0.0'], 0),
            race_source_value=row['21000-0.0'],
            care_site_id=row['54-0.0']
        )
