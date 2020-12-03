from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import get_datetime
from ..gp_mapper import extend_read_code, is_null, GpClinicalValueMapper


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.get_dataframe('gp_clinical.csv')

    # Note: if we add restricting to codes, we might miss some added from the phenotype_logic
    read2_mapper = wrapper.code_mapper.generate_code_mapping_dictionary('Read')
    read3_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/ctv3.csv', approved_only=False)
    value_mapper = GpClinicalValueMapper()

    unit_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/gp_clinical_units.csv')

    records = []
    for _, row in source.iterrows():
        # at least one code should be present for the mapping to be meaningful
        if is_null(row['read_2']) and is_null(row['read_3']):
            continue

        # read_2 and read_3 should be mutually exclusive
        # TODO: observed multiple mappings for vaccinces to SNOMED and CVX, which is better?
        read_col = 'read_2'
        if is_null(row['read_2']):
            read_col = 'read_3'

        person_id = wrapper.lookup_person_id(person_source_value=row['eid'])
        if not person_id:
            continue

        event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        data_source = 'GP-' + row['data_provider'] if not pd.isnull(row['data_provider']) else None

        # Look up visit_id in VisitOccurrence table
        visit_id = wrapper.lookup_visit_occurrence_id(
            person_id=person_id,
            visit_start_date=event_date,
            data_source=data_source
        )

        unit_source_value, unit_concept_id, operator = None, None, None
        if not is_null(row['value3']):
            if row['value3'].startswith('OPR'):
                operator = row['value3'][3:]
            else:
                unit_source_value = row['value3']
                unit_concept_id = unit_lookup.get(row['value3'], 0)

        read_with_value = value_mapper.lookup(row, read_col)

        for read_code, value_as_number in read_with_value:
            read_code_extended = extend_read_code(read_code)
            target_concept_id = 0
            source_concept_id = 0
            if read_col == 'read_2':
                read_mapping = read2_mapper.lookup(read_code_extended, first_only=True)
                target_concept_id = read_mapping.target_concept_id
                source_concept_id = read_mapping.source_concept_id
            elif read_col == 'read_3':
                target_concept_id = read3_lookup.get(read_code, 0)
                # If read_3 code not found in v3 mapper, use v2 mapper
                if target_concept_id == 0:
                    read_mapping = read2_mapper.lookup(read_code_extended, first_only=True)
                    target_concept_id = read_mapping.target_concept_id
                    source_concept_id = read_mapping.source_concept_id

            r = wrapper.cdm.StemTable(
                person_id=person_id,
                domain_id='Measurement',  # this always overrides concept.domain_id, also if the concept is legitimately a condition
                type_concept_id=32817,
                start_date=event_date,
                start_datetime=event_date,
                visit_occurrence_id=visit_id,
                concept_id=target_concept_id,
                source_concept_id=source_concept_id,
                source_value=read_code,  # original before adding cyphers after dots
                operator_concept_id=operator,
                unit_concept_id=unit_concept_id,
                unit_source_value=unit_source_value,
                # value_as_concept_id=value_as_concept_id,
                value_as_number=value_as_number,
                data_source=data_source
            )
            records.append(r)

    return records
