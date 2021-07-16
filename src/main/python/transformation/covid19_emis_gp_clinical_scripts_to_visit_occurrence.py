from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import get_datetime, create_gp_emis_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_emis_gp_clinical_scripts_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = wrapper.source_data._source_dir
    clinical = pd.read_csv(source / 'covid19_emis_gp_clinical.csv', usecols=['eid', 'event_dt'],
                           dtype={'eid': 'Int32', 'event_id': 'datetime64'})
    clinical = clinical[["eid", "event_dt"]].rename(columns={'event_dt': 'date'})

    scripts = pd.read_csv(source / 'covid19_emis_gp_scripts.csv', usecols=['eid', 'issue_date'],
                          dtype={'eid': 'Int32', 'event_id': 'datetime64'})
    scripts = scripts[["eid", "issue_date"]].rename(columns={'issue_date': 'date'})

    clinical = clinical.append(scripts)
    del scripts

    clinical = clinical.drop_duplicates(['eid', 'date'])

    for _, row in clinical.iterrows():
        if row.isnull().any():
            continue
        eid = row['eid']
        eid_str = str(eid)
        date = row['date']
        visit_date = wrapper.get_gp_datetime(date,
                                             person_source_value=eid_str,
                                             format="%d/%m/%Y",
                                             default_date=None)

        # Do not create a visit without a visit date. Otherwise duplicate visits are created.
        if not visit_date:
            continue

        yield wrapper.cdm.VisitOccurrence(
            visit_occurrence_id=create_gp_emis_visit_occurrence_id(eid_str, visit_date),
            person_id=eid,
            visit_concept_id=38004453,  # Family Practice
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=32827,  # 'EHR encounter record'
            data_source='covid19 gp_emis'
        )
