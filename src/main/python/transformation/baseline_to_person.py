from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_person(wrapper: Wrapper) -> List[Wrapper.cdm.Person]:

    source = pd.DataFrame(wrapper.get_source_data('baseline/baseline_to_person.csv'))

    # The use of DataFrame objects is recommended for:
    # - data filtering
    # - joins between multiple source tables
    #
    # alternatively, you could use the dictionary returned by the wrapper method directly:
    # source = wrapper.get_sample_source_table() # Dictionary { row : { variable : value } }
    #
    # for row in source:
    #     for variable, value in row.items():
    #         r = ...

    # TODO: move following dictionaries to dedicated demographics mapping file

    sex = {
        '0' : 8532, # female
        '1' : 8507  # male
    }

    race = {
        '1' : 8527, #white
        '2' : 4212311, #mixed racial group, SNOMED
        '3' : 8515, #asian
        '4' : 38003598, #black
        '5' : 38003579 #chinese
    }

    records = []
    for _, row in source.iterrows():
        # TODO: check correct visit number for fields with multiple visits
        r = wrapper.cdm.Person(
            person_id=row['eid'][4:],
            person_source_value=row['eid'],
            gender_concept_id= sex.get(row['31-0.0'], 0),
            gender_source_value = row['31-0.0'],
            year_of_birth=int(row['34-0.0'].split('.')[0]),
            month_of_birth=int(row['52-0.0']),
            ethnicity_concept_id = 0,
            race_concept_id=race.get(row['21000-0.0'][0], 0),
            race_source_value=row['21000-0.0'],
            # TODO: implement first location mapping, otherwise missing reference!
            # location_id=row['54-0.0'] # alternatively, care_site_id
        )
        records.append(r)

    return records