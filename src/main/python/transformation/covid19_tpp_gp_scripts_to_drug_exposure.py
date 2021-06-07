from __future__ import annotations

from typing import List, TYPE_CHECKING

from src.main.python.util import get_datetime, create_gp_tpp_visit_occurrence_id, is_null

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_tpp_gp_scripts_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = wrapper.source_data.get_source_file('covid19_tpp_gp_scripts.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary(
            'dm+d', restrict_to_codes=list(df['dmd_code']))

    records = []
    for _, row in df.iterrows():
        if row['dmd_code'] == '-1':  # -1: No dm+d code
            continue
        elif not is_null(row['dmd_code']):
            mapping = dmd_mapper.lookup(row['dmd_code'], first_only=True)
        else:
            continue

        person_id = row['eid']

        data_source = 'covid19 gp_tpp'
        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')

        if is_null(row['issue_date']):
            visit_id = None
        else:
            visit_id = create_gp_tpp_visit_occurrence_id(row['eid'], date_start)

        r = wrapper.cdm.DrugExposure(
            person_id=person_id,
            drug_exposure_start_date=date_start,
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_start,
            drug_exposure_end_datetime=date_start,
            drug_concept_id=mapping.target_concept_id,
            drug_source_concept_id=mapping.source_concept_id,
            drug_source_value=mapping.source_concept_code,
            drug_type_concept_id=32838,  # 'EHR prescription'
            data_source=data_source,
            visit_occurrence_id=visit_id
        )
        yield r
