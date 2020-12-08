from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..core.model import CareSite

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_care_site(wrapper: Wrapper) -> List[CareSite]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    df = df.drop_duplicates(subset=['laboratory'])

    records = []
    for _, row in df.iterrows():
        r = CareSite(
            care_site_id=row['laboratory'],
            care_site_source_value=row['laboratory']
        )
        records.append(r)
    return records
