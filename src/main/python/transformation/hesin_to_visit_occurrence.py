from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from ..core.model import VisitOccurrence, Person
from ..util.date_functions import get_datetime, get_end_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_to_visit_occurrence(wrapper: Wrapper) -> List[VisitOccurrence]:
    source = pd.DataFrame(wrapper.get_source_data('hesin.csv'))
    source = source.drop_duplicates(subset=['eid', 'ins_index', 'dsource'], keep='first')

    records = []
    with wrapper.db.session_scope() as session:
        for _, row in source.iterrows():

            query = session.query(Person) \
                .filter(Person.person_id == row['eid'])

            try:
                person_record = query.one()
                person_id = person_record.person_id
            except NoResultFound or MultipleResultsFound:
                continue

            start_date = get_datetime(row['admidate'], "%d/%m/%Y")

            end_date = get_end_datetime(row['disdate'], "%d/%m/%Y")

            r = VisitOccurrence(
                person_id=person_id,
                visit_concept_id=,
                visit_start_date=start_date.date(),
                visit_start_datetime=start_date,
                visit_end_date=end_date.date(),
                visit_end_datetime=end_date,
                visit_type_concept_id=,
                visit_source_value=row['admimeth'],
                admitting_source_concept_id=,
                admitting_source_value=row['admisorc'],
                discharge_to_concept_id=,
                discharge_to_source_value=row['disdest']
            )
            records.append(r)
        return records