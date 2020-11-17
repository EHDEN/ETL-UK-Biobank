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

        person_id = row['eid']
        event_date =  get_datetime(row['event_dt'], "%d/%m/%Y")

        # Look up visit_id in VisitOccurrence by patient_id + visit_start_date
        # TODO: ok to take first visit (asc order)?

        with wrapper.db.session_scope() as session:
            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == event_date) \
                .order_by(VisitOccurrence.visit_start_date.asc()) \
                .limit(1)  # multiple records could be found
            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound:
                continue

        # TODO: implement correct logic to look up concept code.
        #  NOTES from SQL: Deduced field, read_2 or read_3. Read v2 is subset of Read v3
        # read_code = row['read_code']
        read_code = 12345

        # Value1: Some lookups, some corresponding with the one for Caliber.
        # e.g. OPR = operator. Lookups not documented For now focus on the numeric values.
        opr = row['value1'][3:] if row['value1'].startswith('OPR') else None

        # Value3: Units only captured for one data_provider.
        # MEAxxx = unit lookup (to be provided)
        # Map to UCUM (standard OMOP unit concept)
        # TODO: is "MEA" to be looked up in value3 or elsewhere?
        unit = row['value3'] if row['value3'].startswith('MEA') else None

        # TODO: remove workaround, this should be coming from mappings
        unit_as_concept = 12345 if unit else None
        try:
            unit_as_number = float(unit) if unit else None
        except Exception:
            unit_as_number = 0


        # TODO: this needs to be a lot more complex, placeholder for now
        # Some lookups, some corresponding with the one for Caliber.
        # e.g. OPR = operator Lookups not documented
        # For now focus on the numeric values, ignore the lookups.
        # Meaning of value depends on the read_code and data_provider.
        # Same for value 1, 2, 3
        value = row['value1'] if row['value1']  \
            else row['value2'] if row['value2'] \
            else row['value3'] if row['value3'] \
            else None

        # TODO: remove workaround, this should be coming from mappings
        value_as_concept = 12345
        try:
            value_as_number = float(value) if value else None
        except Exception:
            value_as_number = 0

        r = wrapper.cdm.StemTable(
            person_id= person_id,
            type_concept_id=12345,  # placeholder
            start_date= event_date,
            start_datetime= event_date,
            visit_occurrence_id= visit_id,
            concept_id= read_code,
            source_value= read_code,
            source_concept_id= read_code,  # Read concept code
            operator_concept_id = opr,
            unit_concept_id= unit_as_concept,
            unit_source_value= unit_as_number,
            value_as_concept_id= value_as_concept,
            value_as_number= value_as_number,
            data_source='GP-'+row['data_provider'],

            # TODO: check if the following should also be filled
            #  (more fields available, see StemTable definition)

            domain_id=None,
            provider_id=None,
            days_supply=None,
            dose_unit_source_value=None,
            lot_number=None,
            refills=None,
            route_concept_id=None,
            route_source_value=None,
            sig=None,
            stop_reason=None,
            unique_device_id=None,
            modifier_concept_id=None,
            modifier_source_value=None,

        )
        records.append(r)

    return records
