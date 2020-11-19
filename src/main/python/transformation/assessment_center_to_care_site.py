from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING

from ..core.model import CareSite, Location

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def assessment_center_to_care_site(wrapper: Wrapper) -> List[CareSite, Location]:
    records = []
    city = {}

    with open('./resources/encodings/10_assessment_center.tsv') as f_in:
        assessment_centers = csv.DictReader(f_in, delimiter='\t')
        for row in assessment_centers:
            city[row['coding']] = row['meaning']
            r = wrapper.cdm.Location(
                location_id=row['coding'],
                location_source_value=row['coding'],
                city=row['meaning']
            )
            records.append(r)

    source = wrapper.get_dataframe('baseline.csv', use_columns=['eid', '54-0.0'])
    source = source.drop_duplicates(subset=['54-0.0'])

    for _, row in source.iterrows():
        r = CareSite(
            care_site_id=row['54-0.0'],
            care_site_source_value=city.get(row['54-0.0']),
            location_id=row['54-0.0']
        )
        records.append(r)
    return records






