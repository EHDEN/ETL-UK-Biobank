from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from sqlalchemy.orm.exc import NoResultFound

from ..util.date_functions import get_datetime
from ..core.model import VisitOccurrence

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:

    source = pd.DataFrame(wrapper.get_source_data('gp_clinical.csv'))

    read_codes = list(filter(None, set(source['read_2']) | set(source['read_3'])))
    # Read codes in the source are either all alphanumeric, or containing trailing dots;
    # however in OMOP Read vocabulary, dots are always followed by cyphers.
    # To find a mapping for the code, you need to add cyphers after the dots (by default, "00")
    read_codes = [code + '00' if code[-1] == '.' else code for code in read_codes]

    read_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read_codes)

    # x = read_mapper.lookup('4I16.00', full_mapping=True)
    # for match in x:
    #     print(match)
    # x = read_mapper.lookup('6781.00', full_mapping=True)
    # for match in x:
    #     print(match)

    records = []

    for _, row in source.iterrows():

        # read_2 and read_3 should be mutually exclusive.. should
        if row['read_2']:
            read_code = row['read_2']
            read_col = 'read_2'
        elif row['read_3']:
            read_code = row['read_3']
            read_col = 'read_3'
        else:
            continue

        person_id = row['eid']
        # TODO: decide on default date? or skip record if no date?
        #  (note that this should match VisitOccurrence date calculation)
        event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        data_source = 'GP-' + row['data_provider'] if not pd.isnull(row['data_provider']) else None

        # TODO: ok to take first visit (asc order)?
        # Look up visit_id in VisitOccurrence table
        with wrapper.db.session_scope() as session:
            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == event_date) \
                .filter(VisitOccurrence.data_source == data_source) \
                .order_by(VisitOccurrence.visit_start_date.asc()) \
                .limit(1)  # multiple records could be found
            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound:
                continue

        unit, unit_concept_id, operator = None, None, None
        if row['value3']:
            if row['value3'].startswith('OPR'):
                operator = row['value3'][3:]
            # TODO: how to handle MEAxxx codes?
            # elif ['value3'].startswith('MEA'):
                # do something
            else:
                unit = row['value3']
                unit_concept_id = 12345 # TODO: placeholder, create mapping table for units

        for value_col in ['value1', 'value2']:
            # for most rows only one of the two value fields will be provided,
            # for some though you need to process both, therefore this loop.
            # if value1 is empty, skip to value2;
            # if value2 is also empty, skip record creation
            # TODO: only map codes that have logic captured in phenotype repo for now,
            #   decide on how to handle the rest (especially rows missing both values)
            value = row[value_col]
            if pd.isnull(value):
                continue
            try:
                value_as_number = float(value)
                value_as_concept_id = None
            except Exception:
                value_as_number = None
                value_as_concept_id = 0

            r = wrapper.cdm.StemTable(
                person_id=person_id,
                type_concept_id=32020,  # TODO: different options depending if meas/diag/obs, see docs
                start_date=event_date,
                start_datetime=event_date,
                visit_occurrence_id=visit_id,
                concept_id=12345,  # TODO: placeholder
                source_value=read_code,
                source_concept_id=12345,  # TODO: placeholder
                operator_concept_id=operator,
                unit_concept_id=unit_concept_id,
                unit_source_value=unit,
                value_as_concept_id=value_as_concept_id,
                value_as_number=value_as_number,
                data_source=data_source
            )
            records.append(r)

    return records
