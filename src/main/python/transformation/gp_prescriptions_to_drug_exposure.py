from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from datetime import timedelta

from src.main.python.util.date_functions import get_datetime


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = pd.DataFrame(wrapper.get_source_data('gp_prescriptions.csv'))

    records = []
    for _, row in source.iterrows():

        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')
        # TODO: placeholder, replace with proper end date estimate
        date_end = date_start + timedelta(days=1)

        r = wrapper.cdm.DrugExposure(
            person_id=row['eid'],
            drug_exposure_start_date=date_start.date(),
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end.date(),
            drug_exposure_end_datetime=date_end,
            drug_concept_id=1112807, # TODO: placeholder! (aspirin)
            drug_type_concept_id=38000177, #Prescription written
            quantity=None,
            drug_source_value=None,
            drug_source_concept_id=None,
            provider_id=row['data_provider'],
            # TODO: see if any of the following needed
            route_concept_id=None,
            route_source_value=None,
            dose_unit_source_value=None,
            visit_occurrence_id=None
        )
        records.append(r)

    return records
