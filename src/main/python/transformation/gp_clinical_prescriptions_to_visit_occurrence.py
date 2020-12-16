from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_prescriptions_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    clinical_source = wrapper.source_data.get_source_file('gp_clinical.csv')
    clinical = clinical_source.get_csv_as_df(
        apply_dtypes=False,
        usecols=['eid', 'data_provider', 'event_dt']
    )
    clinical = clinical[["eid", "event_dt", "data_provider"]].rename(columns={'event_dt': 'date'})

    prescriptions_source = wrapper.source_data.get_source_file('gp_prescriptions.csv')
    prescriptions = prescriptions_source.get_csv_as_df(
        apply_dtypes=False,
        usecols=['eid', 'data_provider', 'issue_date']
    )
    prescriptions = prescriptions[["eid", "issue_date", "data_provider"]] \
        .rename(columns={'issue_date': 'date'})

    df = pd.concat([prescriptions, clinical])
    df = df.drop_duplicates(['eid', 'date'])
    records = []

    for _, row in df.iterrows():
        visit_date = get_datetime(row['date'], "%d/%m/%Y")
        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        r = wrapper.cdm.VisitOccurrence(
            person_id=person_id,
            visit_concept_id=38004453,  # Family Practice
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=44818518,  # Visit derived from EHR record
            data_source='GP' + '-' + row['data_provider']
        )
        records.append(r)
    return records
