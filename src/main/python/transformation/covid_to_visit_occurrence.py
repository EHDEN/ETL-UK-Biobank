from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False, usecols=['eid', 'specdate', 'laboratory'])

    records = []

    for _, row in df.iterrows():
        visit_date = get_datetime(row['specdate'], "%d/%m/%Y")

        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        r = wrapper.cdm.VisitOccurrence(
            person_id=person_id,
            visit_concept_id=32693,  # Health examination
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=44818518,  # Visit derived from EHR record
            care_site_id=row['laboratory'],
            record_source_value='covid',
            data_source='covid'
        )
        records.append(r)
    return records
