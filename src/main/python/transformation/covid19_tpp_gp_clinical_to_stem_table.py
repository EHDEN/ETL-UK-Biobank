from __future__ import annotations

from typing import List, TYPE_CHECKING
import csv

from ..util import get_datetime, is_null, extend_read_code, create_gp_visit_occurrence_id
from ..gp_mapper import GpClinicalValueMapper

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_tpp_gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.source_data.get_source_file('covid19_tpp_gp_clinical.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    # Load the vocabulary mapping tables
    ctv3_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/ctv3.csv', approved_only=False)
    local_tpp_lookup = wrapper.mapping_tables_lookup("resources/mapping_tables/gp_clinical_covid.csv", approved_only=False)

    # For each record...
    records = []
    for _, row in df.iterrows():

        # If 'code_type' = '-1', discard record from the table        
        # If 'code_type' = '0'   use CTV3 lookup. 
        # If 'code_type’ = '1'   use Local TPP lookup. 
        target_concept_id, source_concept_id = None, None
        if not is_null(row['code']):
            if row["code_type"]=='-1' or row["code_type"]=='-2':
                continue
            elif row["code_type"]=='0':
                target_concept_id = ctv3_lookup.get(row['code'], 0)
            elif row["code_type"]=='1':
                target_concept_id = local_tpp_lookup.get(row['code'], 0) # fill for TPP lookup

        # Add the direct codes
        person_id = row['eid']
        source_code = row['code']
        value_as_number = row['value']
        source_concept_id = '0'  # as in gp_clinical_to_stem_table (no code available in ATHENA)

        # Date
        if not is_null(row['event_dt']):
            event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        else:
            continue

        # Insert terms in stem_table
        r = wrapper.cdm.StemTable(
            person_id=person_id,
            concept_id=target_concept_id,
            source_value=source_code,  
            source_concept_id=source_concept_id,
            start_date=event_date,
            start_datetime=event_date,
            value_as_number=value_as_number,
            domain_id='Measurement',  # this always overrides concept.domain_id, also if the concept is legitimately a condition
            type_concept_id=32817     # 32817: EHR
        )
        records.append(r)

    return records
