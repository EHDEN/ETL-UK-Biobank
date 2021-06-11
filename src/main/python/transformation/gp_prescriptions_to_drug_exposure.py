from __future__ import annotations

from typing import List, TYPE_CHECKING
from datetime import timedelta
from delphyne.model.mapping.code_mapper import CodeMapping

from src.main.python.util import get_datetime, extract_numeric_quantity, valid_quantity_for_days_estimate, \
    create_gp_visit_occurrence_id, is_null, extend_read_code

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper
    

def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = wrapper.source_data.get_source_file('gp_prescriptions.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    df['read_2_extended'] = df['read_2'].apply(extend_read_code)

    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary(
            'dm+d', restrict_to_codes=list(df['dmd_code']))
    read2_mapper = \
        wrapper.mapping_tables_lookup(
            './resources/mapping_tables/gp_prescriptions_drugs_Read2.csv',
            first_only=True, approved_only=False)
    drug_mapper = \
        wrapper.mapping_tables_lookup(
            './resources/mapping_tables/gp_prescriptions_drugs_freetext.csv',
            first_only=True, approved_only=False)

    records = []
    for _, row in df.iterrows():
        if not is_null(row['dmd_code']):
            mapping = dmd_mapper.lookup(row['dmd_code'], first_only=True)
        elif not is_null(row['read_2']):
            mapping = CodeMapping()
            mapping.source_concept_code = row['read_2']
            mapping.source_concept_id = 0
            mapping.target_concept_id = read2_mapper.get(row['read_2_extended'], 0)
        elif not is_null(row['drug_name']):
            mapping = CodeMapping()
            mapping.source_concept_code = row['drug_name']
            mapping.source_concept_id = 0
            mapping.target_concept_id = drug_mapper.get(row['drug_name'], 0)
        else:
            continue

        person_id = row['eid']

        data_source = 'GP-' + row['data_provider'] if not is_null(row['data_provider']) else None
        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')

        if is_null(row['issue_date']):
            visit_id = None
        else:
            visit_id = create_gp_visit_occurrence_id(row['eid'], date_start)

        raw_quantity = row['quantity'] if not is_null(row['quantity']) else None
        unit = row['quantity'][:50] if not is_null(row['quantity']) else None

        valid_quantity = valid_quantity_for_days_estimate(raw_quantity)
        if valid_quantity:
            num_quantity = extract_numeric_quantity(valid_quantity)
            # assume 1 unit per day, starting on start day
            date_end = date_start + timedelta(days=num_quantity-1)
        else:
            num_quantity = extract_numeric_quantity(raw_quantity)
            date_end = date_start

        yield wrapper.cdm.DrugExposure(
            person_id=person_id,
            drug_exposure_start_date=date_start,
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end,
            drug_exposure_end_datetime=date_end,
            drug_concept_id=mapping.target_concept_id,
            drug_source_concept_id=mapping.source_concept_id,
            drug_source_value=mapping.source_concept_code[:50],
            drug_type_concept_id=32838,  # 'EHR prescription'
            quantity=num_quantity,
            dose_unit_source_value=unit,
            data_source=data_source,
            visit_occurrence_id=visit_id,
        )
