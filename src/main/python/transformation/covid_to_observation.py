from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util import get_datetime, create_covid_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_observation(wrapper: Wrapper) -> List[Wrapper.cdm.Observation]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    type_vocab = wrapper.mapping_tables_lookup('./resources/mapping_tables/covid_spectype.csv')

    for _, row in df.iterrows():

        date = get_datetime(row['specdate'], "%d/%m/%Y")

        person_id = row['eid']

        visit_occurrence_id = create_covid_visit_occurrence_id(row['eid'], date)

        result = {
            '1': 45884084,  # Positive
            '0': 45878583  # Negative
        }

        yield wrapper.cdm.Observation(
            person_id=person_id,
            observation_concept_id=type_vocab.get(row['spectype'], 0),
            observation_date=date.date(),
            observation_datetime=date,
            value_as_concept_id=result.get(row['result'], None),
            observation_type_concept_id=32856,  # Lab
            visit_occurrence_id=visit_occurrence_id,
            observation_source_value=row['spectype'],
            data_source='covid'
        )
