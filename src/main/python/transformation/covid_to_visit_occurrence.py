from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = pd.DataFrame(wrapper.get_source_data('covid.csv'))

    records = []

    for _, row in source.iterrows():
        visit_date = get_datetime(row['specdate'], "%d/%m/%Y")

        r = wrapper.cdm.VisitOccurrence(
            person_id=row['eid'],
            visit_concept_id=0,  # 32693 Health examination, not known in vocabulary
            visit_start_date=visit_date.date(),
            visit_start_datetime=visit_date,
            visit_end_date=visit_date.date(),
            visit_end_datetime=visit_date,
            visit_type_concept_id=4063579,  # TODO: Screening procedure, correct type used?
            care_site_id=row['laboratory']
        )
        records.append(r)
    return records
