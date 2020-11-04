from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = pd.DataFrame(wrapper.get_source_data('baseline.csv'))

    records = []

    for _, row in source.iterrows():
        # Date of initial assessment visit
        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=44818519,  # Clinical Study Visit
            visit_start_date=get_datetime(row['53-0.0']),
            visit_start_datetime=get_datetime(row['53-0.0']),
            visit_end_date=get_datetime(row['53-0.0']),
            visit_end_datetime=get_datetime(row['53-0.0']),
            visit_type_concept_id=44818519,  # Clinical Study Visit
            care_site_id=row['54-0.0']
        )
        records.append(r)

        # Date of repeat assessment visit
        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=44818519,  # Clinical Study Visit
            visit_start_date=get_datetime(row['53-1.0']),
            visit_start_datetime=get_datetime(row['53-1.0']),
            visit_end_date=get_datetime(row['53-1.0']),
            visit_end_datetime=get_datetime(row['53-1.0']),
            visit_type_concept_id=44818519,  # Clinical Study Visit
            care_site_id=row['54-0.0']
        )
        records.append(r)

        # Date of first imaging visit
        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=44818519,  # Clinical Study Visit
            visit_start_date=get_datetime(row['53-2.0']),
            visit_start_datetime=get_datetime(row['53-2.0']),
            visit_end_date=get_datetime(row['53-2.0']),
            visit_end_datetime=get_datetime(row['53-2.0']),
            visit_type_concept_id=44818519,  # Clinical Study Visit
            care_site_id=row['54-0.0']
        )
        records.append(r)

        # Date of second imaging visit
        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=44818519,  # Clinical Study Visit
            visit_start_date=get_datetime(row['53-3.0']),
            visit_start_datetime=get_datetime(row['53-3.0']),
            visit_end_date=get_datetime(row['53-3.0']),
            visit_end_datetime=get_datetime(row['53-3.0']),
            visit_type_concept_id=44818519,  # Clinical Study Visit
            care_site_id=row['54-0.0']
        )
        records.append(r)

    return records
