from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util.date_functions import get_datetime

from ..core.model import Observation

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_observation(wrapper: Wrapper) -> List[Observation]:
    source = wrapper.get_dataframe('covid.csv')

    type_vocab = wrapper.mapping_tables_lookup('./resources/mapping_tables/covid_spectype.csv')

    records = []
    for _, row in source.iterrows():

        date = get_datetime(row['specdate'], "%d/%m/%Y")

        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        visit_occurrence_id = wrapper.lookup_visit_occurrence_id(
            person_id=person_id,
            visit_start_date=date,
            record_source_value='covid'
        )

        result = {
            '1': 45884084,  # Positive
            '0': 45878583  # Negative
        }

        r = Observation(
            person_id=person_id,
            observation_concept_id=type_vocab.get(row['spectype'], 0),
            observation_date=date.date(),
            observation_datetime=date,
            value_as_concept_id=result.get(row['result'], None),
            observation_type_concept_id=38000279,  # Lab observation concept code result
            visit_occurrence_id=visit_occurrence_id,
            observation_source_value=row['spectype'],
            data_source='covid'
        )
        records.append(r)
    return records
