from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util.date_functions import get_datetime, get_end_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_registrations_to_observation_period(wrapper: Wrapper) -> List[Wrapper.cdm.ObservationPeriod]:
    source = wrapper.source_data.get_source_file('gp_registrations.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    records = []
    for _, row in df.iterrows():

        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        start_date = get_datetime(row['reg_date'], "%d/%m/%Y")
        end_date = get_end_datetime(row['deduct_date'], "%d/%m/%Y")

        r = wrapper.cdm.ObservationPeriod(
            person_id=person_id,
            observation_period_start_date=start_date.date(),
            observation_period_end_date=end_date.date(),
            period_type_concept_id=32817  # EHR
        )
        records.append(r)
    return records
