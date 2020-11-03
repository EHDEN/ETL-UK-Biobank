from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from ..util.date_functions import get_datetime

from ..core.model import Observation, VisitOccurrence

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_observation(wrapper: Wrapper) -> List[Observation]:
    source = pd.DataFrame(wrapper.get_source_data('covid.csv'))

    records = []
    with wrapper.db.session_scope() as session:
        for _, row in source.iterrows():

            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == row['eid'] and VisitOccurrence.visit_start_date == row['specdate'])

            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound or MultipleResultsFound:
                visit_id = None

            date = get_datetime(row['specdate'], "%d/%m/%Y")

            r = Observation(
                person_id=row['eid'],
                observation_concept_id=row['spectype'],
                observation_date=date.date(),
                observation_datetime=date,
                value_as_concept_id=row['result'],
                observation_type_concept_id=38000279, # Lab observation concept code result
                visit_occurrence_id =visit_id,
                observation_source_value= row['spectype']
            )
            records.append(r)
        return records