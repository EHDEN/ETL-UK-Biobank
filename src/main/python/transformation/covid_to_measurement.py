from __future__ import annotations

from typing import List, TYPE_CHECKING

from ..util import get_datetime, create_covid_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid_to_measurement(wrapper: Wrapper) -> List[Wrapper.cdm.Measurement]:
    source = wrapper.source_data.get_source_file('covid.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    for _, row in df.iterrows():

        date = get_datetime(row['specdate'], "%d/%m/%Y")

        person_id = row['eid']

        visit_occurrence_id = wrapper.lookup_visit_occurrence_id(person_id=row['eid'], visit_start_date=date)

        result = {
            '1': 45884084,  # Positive
            '0': 45878583  # Negative
        }

        yield wrapper.cdm.Measurement(
            person_id=person_id,
            measurement_concept_id=756055,  # Measurement of Severe acute respiratory syndrome coronavirus 2(SARS-CoV-2)
            measurement_date=date.date(),
            measurement_datetime=date,
            value_as_concept_id=result.get(row['result'], None),
            value_source_value=row['result'],
            measurement_type_concept_id=32856,  # Lab
            visit_occurrence_id=visit_occurrence_id,
            data_source='covid'
        )
