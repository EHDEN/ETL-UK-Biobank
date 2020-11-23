from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
import math
import csv
from sqlalchemy.orm.exc import NoResultFound

from ..util import get_datetime, extend_read_code, is_null
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

    # load dictionary of special Read v2 dot code mappings (i.e. alternative to adding 00)
    with open(GP_CLINICAL_MAPPING_FOLDER + 'read2_alternative_dot_code_mappings.csv') as f:
        next(f)  # Skip provenance info
        next(f)  # Skip the header
        reader = csv.reader(f)
        read2_dot_mappings = dict(row[1:] for row in reader if row) # skip 1st column

    # load dataframe for special mapping logic (e.g. blood pressure)
    mapping_logic_df = pd.read_csv(GP_CLINICAL_MAPPING_FOLDER + 'phenotype_logic.csv',
                                   skiprows=1, dtype='object')
    special_handling_codes = set(mapping_logic_df['source_read_code'])

    # Read codes in the source are either all alphanumeric, or containing trailing dots;
    # however in OMOP Read vocabulary, dots are always followed by cyphers.
    # To find a mapping for the code, you need to add cyphers after the dots (by default, "00")
    source['read_2_extended'] = source['read_2'].apply(extend_read_code, mapping_dict=read2_dot_mappings)
    source['read_3_extended'] = source['read_3'].apply(extend_read_code)

    read2_codes = list(filter(lambda x: not is_null(x), set(source['read_2_extended'])))
    read3_codes = list(filter(lambda x: not is_null(x), set(source['read_3_extended'])))

    read2_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read2_codes)
    read3_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read3_codes)

    records = []

    for _, row in source.iterrows():

        # read_2 and read_3 should be mutually exclusive
        # and at least one should be present for the mapping to be meaningful
        # TODO: observed multiple mappings for vaccinces to SNOMED and CVX, which is better?
        if not is_null(row['read_2']):
            read_code = row['read_2']
            read_mapping = read2_mapper.lookup(row['read_2_extended'], first_only=True)
            read_col = 'read_2'
        elif not is_null(row['read_3']):
            read_code = row['read_3']
            read_mapping = read3_mapper.lookup(row['read_3_extended'], first_only=True)
            read_col = 'read_3'
        else:
            continue

        person_id = row['eid']
        # TODO: decide on default date? or skip record if no date?
        #  (note that this should match VisitOccurrence date calculation)
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

        # for most rows only one of the two value fields will be provided,
        # for some though you need to process both, therefore this loop.


        for value_col in ['value1', 'value2']:
            value = row[value_col]
            if is_null(value):
                if value_col == 'value1':  # if value1 is empty, skip to value2
                    continue
                elif is_null(row['value1']): # if both value1&2 empty, create record with no value
                    value_as_number = None
                    value_as_concept_id = None
                else: # value2 is empty but value1 is not, so this row has already been processed and can be skipped
                    continue
            else:
                try:
                    value_as_number = float(value)
                    value_as_concept_id = None
                except Exception:
                    value_as_number = None
                    value_as_concept_id = 0 # TODO: placeholder, create mapping table for alphanum codes (or always ignore?)

            # apply special mapping logic to specific combinations of data provider, read code,
            # and value column (e.g. blood pressure)
            if read_mapping.source_concept_code in special_handling_codes:
                # print([read_col, value_col, row['data_provider'], read_mapping.source_concept_code])
                filter1 = mapping_logic_df['read_col'] == read_col
                filter2 = mapping_logic_df['value_col'] == value_col
                filter3 = mapping_logic_df['data_provider'] == row['data_provider']
                filter4 = mapping_logic_df['source_read_code'] == read_mapping.source_concept_code
                filtered_df = mapping_logic_df[filter1 & filter2 & filter3 & filter4]
                n_results = len(filtered_df.index)
                if n_results == 1: # either not found, or 1 result (no multiple mappings in source file)
                    new_read_code = filtered_df['map_as_read_code'].iloc[0]
                    if read_col == 'read_2':
                        read_mapping = read2_mapper.lookup(new_read_code, first_only=True)
                    else:
                        read_mapping = read3_mapper.lookup(new_read_code, first_only=True)

            r = wrapper.cdm.StemTable(
                person_id=person_id,
                type_concept_id=32020,  # TODO: add different options depending if meas/diag/obs
                start_date=event_date,
                start_datetime=event_date,
                visit_occurrence_id=visit_id,
                concept_id=read_mapping.target_concept_id,
                source_concept_id=read_mapping.source_concept_id,
                source_value=read_code,  # original before adding cyphers after dots
                operator_concept_id=operator,
                unit_concept_id=unit_concept_id,
                unit_source_value=unit,
                value_as_concept_id=value_as_concept_id,
                value_as_number=value_as_number,
                data_source=data_source
            )
            records.append(r)

    return records
