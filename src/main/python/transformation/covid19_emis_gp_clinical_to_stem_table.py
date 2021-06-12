from __future__ import annotations

from typing import List, TYPE_CHECKING
from ..util import create_gp_emis_visit_occurrence_id
import re
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_emis_gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.source_data.get_source_file('covid19_emis_gp_clinical.csv')
    rows = source.get_csv_as_generator_of_dicts()
    mapping_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/gp_clinical_covid.csv')
    unit_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/covid19_emis_units.csv')
    value_mapping_lookup = wrapper.mapping_tables_lookup("resources/mapping_tables/covid_value_mapping.csv")

    snomed_mapper = wrapper.code_mapper.generate_code_mapping_dictionary('SNOMED')

    for row in rows:
        event_date = wrapper.get_gp_datetime(row['event_dt'],
                                             person_source_value=row['eid'],
                                             format="%d/%m/%Y",
                                             default_date=None)

        if not event_date:
            continue

        # Ignore rows were "value" = -9000004, -9000003, -9000002, -9000001, -9999999, -9000099
        if re.match(r'^-\d', str(row['value'])):
            continue

        if row['code'] in ['-99', '-1', '-4']:
            continue

        # SNOMED codes
        if row['code_type'] == '2':
            mapping = snomed_mapper.lookup(row['code'], first_only=True)
            target_concept_id = mapping.target_concept_id
            source_concept_id = mapping.source_concept_id
        # Local EMIS code
        elif row['code_type'] == '3':
            target_concept_id = mapping_lookup.get(row['code'], 0)
            source_concept_id = 0
        else:
            continue

        # Add value, only if numeric
        try:
            value_as_number = float(row['value'])
        except ValueError:
            value_as_number = None

        visit_id = create_gp_emis_visit_occurrence_id(row['eid'], event_date)

        if pd.isna(row['unit']) or re.match(r'^(-[\d])', row['unit']):
            unit_concept_id, unit_source_value = None, None
        else:
            unit_concept_id = unit_lookup.get(row['unit'], 0)
            unit_source_value = row['unit']

        value_as_concept_id = value_mapping_lookup.get(row['code'], None)

        yield wrapper.cdm.StemTable(
            person_id=row['eid'],
            domain_id='Measurement',
            type_concept_id=32817,
            start_date=event_date,
            start_datetime=event_date,
            visit_occurrence_id=visit_id,
            concept_id=target_concept_id,
            source_concept_id=source_concept_id,
            source_value=row['code'],
            unit_concept_id=unit_concept_id,
            unit_source_value=unit_source_value,
            value_as_concept_id=value_as_concept_id,
            value_as_number=value_as_number,
            data_source='covid19 gp_emis'
        )
