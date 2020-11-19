from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..core.model import CareSite

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_care_site(wrapper: Wrapper) -> List[CareSite]:
    source = wrapper.get_dataframe('gp_clinical.csv', use_columns=['data_provider'])
    source = source.drop_duplicates(subset=['data_provider'])

    records = []
    for _, row in source.iterrows():
        r = CareSite(
            care_site_id=row['data_provider'],
            care_site_source_value=row['data_provider']
        )
        records.append(r)
    return records
