from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_prescriptions_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = pd.DataFrame(wrapper.get_source_data('gp_prescriptions.csv'))

    records = []

    for _, row in source.iterrows():
        visit_date = get_datetime(row['issue_date'], "%d/%m/%Y")

        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=38004453,  # Family practice
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=44818518,  # Visit derived from EHR record
            care_site_id=row['data_provider']
        )
        records.append(r)
    return records