from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

from ..util.date_functions import get_datetime

from ..core.model import Observation, VisitOccurrence, Person

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_observation(wrapper: Wrapper) -> List[Observation]:
    source = pd.DataFrame(wrapper.get_source_data('covid.csv'))

    type_vocab = pd.read_csv('./resources/baseline_field_mapping/covid_spectype.csv')
    type_lookup = {str(x['sourceCode']): int(x['conceptId']) for _, x in type_vocab.iterrows()}

    records = []
    with wrapper.db.session_scope() as session:
        for _, row in source.iterrows():

            date = get_datetime(row['specdate'], "%d/%m/%Y")

            query_1 = session.query(Person) \
                .filter(Person.person_id == row['eid'])
            try:
                person_record = query_1.one()
                person_id = person_record.person_id
            except NoResultFound or MultipleResultsFound:
                continue

            query_2 = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == date)
            try:
                visit_record = query_2.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound or MultipleResultsFound:
                visit_id = None

            concept_id = type_lookup.get(row['spectype'], 0)

            result = {
                '1': 45884084,  # Positive
                '0': 45878583  # Negative
            }

            r = Observation(
                person_id=person_id,
                observation_concept_id=int(concept_id),
                observation_date=date.date(),
                observation_datetime=date,
                value_as_concept_id=result.get(row['result'], None),
                observation_type_concept_id=38000279,  # Lab observation concept code result
                visit_occurrence_id=visit_id,
                observation_source_value=row['spectype']
            )
            records.append(r)
        return records