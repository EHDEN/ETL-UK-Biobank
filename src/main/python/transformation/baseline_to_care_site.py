from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..core.model import CareSite

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_care_site(wrapper: Wrapper) -> List[CareSite]:
    source = wrapper.get_dataframe('baseline.csv', use_columns=['eid', '54-0.0'])
    source = source.drop_duplicates(subset=['54-0.0'])

    records = []
    for _, row in source.iterrows():
        r = CareSite(
            care_site_id=row['54-0.0'],
            care_site_source_value=row['54-0.0']
        )
        records.append(r)
    return records
