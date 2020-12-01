from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
import csv
from sqlalchemy.orm.exc import NoResultFound

from ..util import get_datetime
from ..gp_mapper import extend_read_code, is_null, GpClinicalValueMapper
from ..core.model import VisitOccurrence


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


GP_CLINICAL_MAPPING_FOLDER = 'resources/gp_clinical_field_mapping/'


def gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.get_dataframe('gp_clinical.csv')

    # load dictionary of valid units
    with open(GP_CLINICAL_MAPPING_FOLDER + 'unit_raw_to_clean.csv') as f:
        next(f)  # Skip provenance info
        next(f)  # Skip the header
        reader = csv.reader(f)
        valid_units = dict(reader)

    # Note: if we add restricting to codes, we might miss some added from the phenotype_logic
    read2_mapper = wrapper.code_mapper.generate_code_mapping_dictionary('Read')
    read3_mapper = read2_mapper  # TODO: separate mapping table
    value_mapper = GpClinicalValueMapper(read2_mapper, read3_mapper)

    records = []
    for _, row in source.iterrows():
        # at least one code should be present for the mapping to be meaningful
        if is_null(row['read_2']) and is_null(row['read_3']):
            continue

        # read_2 and read_3 should be mutually exclusive
        # TODO: observed multiple mappings for vaccinces to SNOMED and CVX, which is better?
        if not is_null(row['read_2']):
            code_mapper = read2_mapper
            read_col = 'read_2'
        elif not is_null(row['read_3']):
            code_mapper = read3_mapper
            read_col = 'read_3'

        person_id = row['eid']
        event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        data_source = 'GP-' + row['data_provider'] if not pd.isnull(row['data_provider']) else None

        # Look up visit_id in VisitOccurrence table
        with wrapper.db.session_scope() as session:
            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == event_date) \
                .filter(VisitOccurrence.data_source == data_source) \
                .order_by(VisitOccurrence.visit_start_date) \
                .limit(1)  # multiple records could be found
            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound:
                visit_id = None

        unit, unit_concept_id, operator = None, None, None
        if not is_null(row['value3']):
            if row['value3'].startswith('OPR'):
                operator = row['value3'][3:]
            elif unit in valid_units: # this includes MEAxxx codes
                unit = row['value3']
                if valid_units[unit]: # might still map to empty string
                    unit_concept_id=12345 # TODO: placeholder, add mapping to standard concept_id
                else:
                    unit_concept_id=0

        read_with_value = value_mapper.lookup(row, read_col)

        for read_code, value_as_number in read_with_value:
            read_code_extended = extend_read_code(read_code)
            read_mapping = code_mapper.lookup(read_code_extended, first_only=True)
            r = wrapper.cdm.StemTable(
                person_id=person_id,
                domain_id='Measurement',
                type_concept_id=32817,
                start_date=event_date,
                start_datetime=event_date,
                visit_occurrence_id=visit_id,
                concept_id=read_mapping.target_concept_id,
                source_concept_id=read_mapping.source_concept_id,
                source_value=read_code,  # original before adding cyphers after dots
                operator_concept_id=operator,
                unit_concept_id=unit_concept_id,
                unit_source_value=unit,
                # value_as_concept_id=value_as_concept_id,
                value_as_number=value_as_number,
                data_source=data_source
            )
            records.append(r)

    return records
