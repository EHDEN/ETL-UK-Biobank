from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:

    source = pd.DataFrame(wrapper.get_source_data('gp_clinical.csv'), )

    records = []

    # TODO: remove the following once actual gp_clinical to visit occurrence is implemented,
    # this is only to allow running of code below

    for date in ['2020-01-31', '1900-01-01']:

        person_id = '1'
        visit_occurrence_id = person_id + ''.join(date.split('-'))

        r = wrapper.cdm.VisitOccurrence(
            visit_occurrence_id=visit_occurrence_id,
            person_id= person_id,
            visit_type_concept_id=12345,  # placeholder
            visit_start_date= date,
            visit_end_date= date,
            visit_concept_id=12345
        )
        records.append(r)


    for _, row in source.iterrows():

        # TODO: no person ID available in current synthetic data,
        #  need to update with plausible values for this to work normally.
        # person_id = row['eid']
        person_id = '1'

        # TODO: no actual date available in current synthetic data,
        #  need to update with plausible values for this to work normally.
        # TODO: check if placeholder already in source, or we actually need to provide it
        #event_date = row['event_dt'] if row['event_dt'] else '1900-01-01'
        event_date = '2020-01-31' if row['event_dt'] else '1900-01-01'

        # TODO: Look up visit occurrence by unique eid+event_dt
        visit_occurrence_id = person_id + ''.join(event_date.split('-'))

        # TODO: implement correct logic.
        # TODO: map to concept code.
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
        unit_as_value = unit[3:] if unit else None


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
        try:
            value_as_concept = int(value) if value else None
        except Exception:
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
            visit_occurrence_id= visit_occurrence_id,
            concept_id= read_code,
            source_value= read_code,
            source_concept_id= read_code,  # Read concept code
            operator_concept_id = opr,
            unit_concept_id= unit_as_concept,
            unit_source_value= unit_as_value,
            value_as_concept_id= value_as_concept,
            value_as_number= value_as_number,

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