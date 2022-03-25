from __future__ import annotations

from typing import List, TYPE_CHECKING

from src.main.python.util import create_gp_tpp_visit_occurrence_id, is_null

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_tpp_gp_scripts_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:
    source = wrapper.source_data.get_source_file('covid19_tpp_gp_scripts.csv')
    rows = source.get_csv_as_generator_of_dicts()

    dmd_mapper = wrapper.code_mapper.generate_code_mapping_dictionary('dm+d')

    for row in rows:
        if is_null(row['dmd_code']) or row['dmd_code'] == '-1':
            continue

        mappings = dmd_mapper.lookup(row['dmd_code'], first_only=False)

        date_start = wrapper.get_gp_datetime(row['issue_date'],
                                             person_source_value=row['eid'],
                                             format="%d/%m/%Y",
                                             default_date=None)
        if not date_start:
            continue

        visit_id = create_gp_tpp_visit_occurrence_id(row['eid'], date_start)

        for mapping in mappings:
            yield wrapper.cdm.DrugExposure(
                person_id=row['eid'],
                drug_exposure_start_date=date_start,
                drug_exposure_start_datetime=date_start,
                drug_exposure_end_date=date_start,
                drug_exposure_end_datetime=date_start,
                drug_concept_id=mapping.target_concept_id,
                drug_source_concept_id=mapping.source_concept_id,
                drug_source_value=mapping.source_concept_code,
                drug_type_concept_id=32838,  # 'EHR prescription'
                data_source='covid19 gp_tpp',
                visit_occurrence_id=visit_id
            )
