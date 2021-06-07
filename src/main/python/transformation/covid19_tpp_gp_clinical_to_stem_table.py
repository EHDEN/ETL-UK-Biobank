from __future__ import annotations

from typing import List, TYPE_CHECKING

from src.main.python.util import get_datetime, create_gp_tpp_visit_occurrence_id, is_null


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_tpp_gp_clinical_to_stem_table(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.source_data.get_source_file('covid19_tpp_gp_clinical.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    # Load the vocabulary mapping tables
    ctv3_lookup = wrapper.mapping_tables_lookup('resources/mapping_tables/ctv3.csv', approved_only=False)
    local_tpp_lookup = wrapper.mapping_tables_lookup("resources/mapping_tables/gp_clinical_covid.csv", approved_only=False)
    value_mapping_lookup = wrapper.mapping_tables_lookup("resources/mapping_tables/covid_value_mapping.csv")

    # For each record...
    records = []
    for _, row in df.iterrows():
 
        if is_null(row['code']):
            continue

        if is_null(row['event_dt']):
            continue

        # If 'code_type' = '0'   use CTV3 lookup. 
        # If 'code_type’ = '1'   use Local TPP lookup. 
        # If 'code_type' = '-1', '-2' or other, discard record from the table 
        if row["code_type"] == '0':
            target_concept_id = ctv3_lookup.get(row['code'], 0)
        elif row["code_type"] == '1':
            target_concept_id = local_tpp_lookup.get(row['code'], 0)
        else:
            continue

        # Add value, only if numeric
        try:
            value_as_number = float(row['value'])
        except:
            value_as_number = None

        # Add the direct codes
        person_id = row['eid']
        source_code = row['code']

        # Date and visit id
        event_date = get_datetime(row['event_dt'], "%d/%m/%Y")
        visit_id = create_gp_tpp_visit_occurrence_id(row['eid'], event_date)

        value_as_concept_id = value_mapping_lookup.get(row['code'], None)

        # Insert terms in stem_table
        r = wrapper.cdm.StemTable(
            person_id=person_id,
            concept_id=target_concept_id,
            source_value=source_code,  
            source_concept_id=0,
            start_date=event_date,
            start_datetime=event_date,
            value_as_number=value_as_number,
            visit_occurrence_id=visit_id,
            value_as_concept_id=value_as_concept_id,
            domain_id='Measurement',  # this always overrides concept.domain_id, also if the concept is legitimately a condition
            type_concept_id=32817,     # 32817: EHR
            data_source='covid19 gp_tpp'
        )
        yield r
