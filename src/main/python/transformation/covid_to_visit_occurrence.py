from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util import get_datetime, create_covid_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False, usecols=['eid', 'specdate', 'laboratory'])
    df = df.drop_duplicates(['eid', 'specdate'])

    records = []

    for _, row in df.iterrows():
        visit_date = get_datetime(row['specdate'], "%d/%m/%Y")

        person_id = row['eid']

        yield wrapper.cdm.VisitOccurrence(
            visit_occurrence_id=create_covid_visit_occurrence_id(row['eid'], visit_date),
            person_id=person_id,
            visit_concept_id=32693,  # Health examination
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=32856,  # Lab
            care_site_id=row['laboratory'],
            record_source_value='covid',
            data_source='covid'
        )
