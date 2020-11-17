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

        if row['read_2']:
            read_code = row['read_2']
            read_col = 'read_2'
        elif row['read_3']:
            read_code = row['read_3']
            read_col = 'read_3'
        else:
            continue

        person_id = row['eid']
        event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        data_source = 'GP-' + row['data_provider']

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

        operator = row['value1'][3:] if row['value1'].startswith('OPR') else None

        # TODO: create mapping tables and lookup for units, including those expressed as MEAxxx
        unit = row['value3']

        value1 = row['value1']
        value2 = row['value2']

        # TODO: remove workaround, this should be coming from mappings
        try:
            value1_as_number = float(value1) if value1 else None
            value1_as_concept_id = None
        except Exception:
            value1_as_number = None
            value1_as_concept_id = 0

        try:
            value2_as_number = float(value2) if value2 else None
            value2_as_concept_id = None
        except Exception:
            value2_as_number = None
            value2_as_concept_id = 0

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
            unit_concept_id=12345,  # TODO: placeholder
            unit_source_value=unit,
            value_as_concept_id=value1_as_concept_id,
            value_as_number=value1_as_number,
            data_source=data_source
        )
        records.append(r)

    return records
