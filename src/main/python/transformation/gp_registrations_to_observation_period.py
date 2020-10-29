from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..core.model import ObservationPeriod
from ..util.date_functions import get_datetime, get_end_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_registrations_to_observation_period(wrapper: Wrapper) -> List[ObservationPeriod]:
    source = pd.DataFrame(wrapper.get_source_data('gp_registrations.csv'))

    records = []
    for _, row in source.iterrows():

        start_date = get_datetime(row['reg_date'], "%Y/%m/%d")
        end_date = get_end_datetime(row['deduct_date'], "%Y/%m/%d", '2099/7/1')

        r = ObservationPeriod(
            person_id= row['eid'],
            observation_period_start_date=start_date,
            observation_period_end_date=end_date,
            period_type_concept_id= 32817 #EHR
        )
        records.append(r)
    return records
