from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..core.model import CareSite

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_care_site(wrapper: Wrapper) -> List[CareSite]:
    source = wrapper.get_dataframe('covid.csv', use_columns=['laboratory'])
    source = source.drop_duplicates(subset=['laboratory'])

    records = []
    for _, row in source.iterrows():
        r = CareSite(
            care_site_id=row['laboratory'],
            care_site_source_value=row['laboratory']
        )
        records.append(r)
    return records
