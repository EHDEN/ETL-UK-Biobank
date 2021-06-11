from __future__ import annotations

from typing import List, TYPE_CHECKING

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_care_site(wrapper: Wrapper) -> List[Wrapper.cdm.CareSite]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    df = df.drop_duplicates(subset=['laboratory'])

    records = []
    for _, row in df.iterrows():
        yield wrapper.cdm.CareSite(
            care_site_id=row['laboratory'],
            care_site_source_value=row['laboratory']
        )
