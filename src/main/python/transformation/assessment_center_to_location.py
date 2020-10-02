from __future__ import annotations

from typing import List, TYPE_CHECKING


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def assessment_center_to_location(wrapper: Wrapper) -> List[Wrapper.cdm.Person]:

    source = wrapper.get_source_data('encodings/10_assessment_center.tsv',
                                                  custom_delimiter='\t')

    records = []
    for row in source:
        # TODO: check if ok to capture info like this (for example, location_id could be
        #  auto-generated, location_source_value could capture the original id, and city the
        #  original name including the part in parenthesis)
        r = wrapper.cdm.Location(
            location_id=row['coding'],
            location_source_value=row['meaning'],
            city=row['meaning'].split()[0]
        )
        records.append(r)

    return records
