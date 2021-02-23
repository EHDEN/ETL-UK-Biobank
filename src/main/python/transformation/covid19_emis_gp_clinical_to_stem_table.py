from __future__ import annotations

from typing import List, TYPE_CHECKING
from ..util import get_datetime, is_null, create_covid_visit_occurrence_id
import re
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_emis_gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.source_data.get_source_file('covid19_emis_gp_clinical.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    mapping_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/gp_clinical_covid.csv')
    code_to_concept_id = wrapper.generate_code_to_concept_id_dict(df['code'], vocabulary_id='SNOMED')
    unit_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/covid19_emis_units.csv')

    records = []

    for _, row in df.iterrows():
        person_id = row['eid']

        if not is_null(row['event_dt']):
            event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        else:
            continue

        # Ignore rows were "value" = -9000004, -9000003, -9000002, -9000001, -9999999, -9000099
        if re.match(r'^(-[\d])', row['value']):
            continue

        if row['code'] in ['-99', '-1']:
            continue
        concept_id = code_to_concept_id.get(row['code'], 0)

        # If the concept is not found in the SNOMED vocabulary, check mapping of local codes.
        if concept_id == 0:
            concept_id = mapping_lookup.get(row['code'], 0)

        visit_id = create_covid_visit_occurrence_id(row['eid'], event_date)
        if pd.notna(row['unit']) and re.match(r'^(-[\d])', row['unit']):
            unit_concept_id, unit_source_value = None, None
        else:
            unit_concept_id = unit_lookup.get(row['unit'], 0)
            unit_source_value = row['unit']

        r = wrapper.cdm.StemTable(
            person_id=person_id,
            domain_id='Measurement',
            type_concept_id=32817,
            start_date=event_date,
            start_datetime=event_date,
            visit_occurrence_id=visit_id,
            concept_id=concept_id,
            source_concept_id=0,  # problem with max value for an integer, for example source code 9350510000
            source_value=row['code'],
            unit_concept_id=unit_concept_id,
            unit_source_value=unit_source_value,
            value_as_number=row['value'],
            data_source='GP-COVID19'
        )
        records.append(r)
    return records


