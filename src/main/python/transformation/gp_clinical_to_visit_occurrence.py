from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from datetime import datetime

from ..util.date_handling import get_datetime

from ..core.model import VisitOccurrence

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_visit_occurrence(wrapper: Wrapper) -> List[VisitOccurrence]:
    source = pd.DataFrame(wrapper.get_source_data('gp_clinical.csv'))

    records = []

    for _, row in source.iterrows():
        visit_date = get_datetime(datetime.strftime(datetime.strptime(row['event_dt'], "%d/%m/%Y"), '%Y-%m-%d'))

        r = VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=38004453,  # Family Practice
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=44818518,  # Visit derived from EHR record
            # care_site_id=row['data_provider']
        )
        records.append(r)
    return records
