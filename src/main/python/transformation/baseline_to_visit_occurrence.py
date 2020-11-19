from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = wrapper.get_dataframe('baseline.csv', use_columns=['eid', '54-0.0', '54-1.0', '54-2.0', '54-3.0',
                                                                '53-0.0', '53-1.0', '53-2.0', '53-3.0'])
    records = []
    for _, row in source.iterrows():
        # One-day visits for instances 0 to 3
        for instance in range(4):
            # Field_id 53 contains the date of the visit
            date_column = f'53-{instance}.0'
            if row[date_column] == '' or pd.isna(row[date_column]):
                continue

            date = get_datetime(row[date_column])

            # Field_id 54 contains the assessment centre
            assessment_center = row.get(f'54-{instance}.0', None)

            r = wrapper.cdm.VisitOccurrence(
                person_id=row['eid'],
                visit_concept_id=44818519,  # Clinical Study Visit
                visit_start_date=date.date(),
                visit_start_datetime=date,
                visit_end_date=date.date(),
                visit_end_datetime=date,
                visit_type_concept_id=32883,  # Survey
                care_site_id=None if pd.isna(assessment_center) else assessment_center,
                record_source_value=f'baseline-{instance}',
                data_source='baseline'
            )
            records.append(r)

    return records
