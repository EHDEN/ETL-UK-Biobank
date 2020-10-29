from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:

    source = pd.DataFrame(wrapper.get_source_data('gp_clinical.csv'), )

    records = []
    for _, row in source.iterrows():

        # TODO: no person ID available in current synthetic data,
        #  need to update with plausible values for this to work normally
        person_id = row['eid'][4:]
        if not person_id:
            continue

        # TODO: check if placeholder already in source, or we actually need to provide it
        event_date = row['event_dt'] if row['event_dt'] else '1900-01-01'

        # TODO: Look up visit occurrence by unique eid+event_dt
        visit_occurrence_id = person_id + event_date

        # TODO: implement logic.
        #  Deduced field, read_2 or read_3. Read v2 is subset of Read v3
        read_code = row['read_code']

        # Value1: Some lookups, some corresponding with the one for Caliber.
        # e.g. OPR = operator. Lookups not documented For now focus on the numeric values.
        opr = row['value1'] if row['value1'].startswith('OPR') else None

        # Value3: Units only captured for one data_provider.
        # MEAxxx = unit lookup (to be provided)
        # Map to UCUM (standard OMOP unit concept)
        # TODO: is "MEA" to be looked up in value3 or elsewhere?
        unit = row['value3'] if row['value3'].startswith('MEA') else None

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

        r = wrapper.cdm.StemTable(
            person_id= person_id,
            start_date= event_date,
            start_datetime= event_date,
            visit_occurrence_id= visit_occurrence_id,
            concept_id= read_code,
            source_value= read_code,
            source_concept_id= read_code, # as Read concept
            operator_concept_id = opr,
            unit_concept_id= unit,
            unit_source_value= unit,
            value_as_concept_id= value,
            value_as_number= value,

            # TODO: check if the following should also be filled
            #  (more fields available, se StemTable definition)

            domain_id=None,
            provider_id=None,
            type_concept_id=None,
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