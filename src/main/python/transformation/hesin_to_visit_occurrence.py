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
    source = source.sort_values(['eid', 'spell_index'])
    source = source.groupby(by=['eid', 'dsource', 'spell_index']).agg(
        {'admidate': 'min',
         'disdate': 'max',
         'admimeth': 'first',
         'admisorc': 'first',
         'disdest': 'last',
         }
    ).reset_index()

    visit_reason = pd.read_csv('./resources/mapping_tables/hesin_admimeth.csv')
    visit_reason_lookup = visit_reason.groupby(['sourceCode', 'ADD_INFO:coding_origin'])\
        .apply(lambda x: x['conceptId'].values[0])\
        .to_dict()

    admit_reason = pd.read_csv('./resources/mapping_tables/hesin_admisorc.csv')
    admit_reason_lookup = admit_reason.groupby(['sourceCode', 'ADD_INFO:coding_origin'])\
        .apply(lambda x: x['conceptId'].values[0])\
        .to_dict()

    dis_reason = pd.read_csv('./resources/mapping_tables/hesin_disdest.csv')
    dis_reason_lookup = dis_reason.groupby(['sourceCode', 'ADD_INFO:coding_origin'])\
        .apply(lambda x: x['conceptId'].values[0])\
        .to_dict()

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

            method_source = "record origin:"+row['dsource']+"/admission method:"+row['admimeth']
            admit_source = "record origin:"+row['dsource']+"/admission source:"+row['admisorc']
            dis_source = "record origin:"+row['dsource']+"/discharge destination:"+row['disdest']

            r = VisitOccurrence(
                person_id=person_id,
                visit_concept_id=visit_reason_lookup.get((row['admimeth'], row['dsource']), 0),
                visit_start_date=start_date.date(),
                visit_start_datetime=start_date,
                visit_end_date=end_date.date(),
                visit_end_datetime=end_date,
                visit_type_concept_id=44818517, # Visit derived from encounter on claim
                visit_source_value=method_source[:50],
                admitting_source_concept_id=admit_reason_lookup.get((row['admisorc'], row['dsource']), 0),
                admitting_source_value=admit_source[:50],
                discharge_to_concept_id=dis_reason_lookup.get((row['disdest'], row['dsource']), 0),
                discharge_to_source_value=dis_source[:50]
            )
            records.append(r)
        return records