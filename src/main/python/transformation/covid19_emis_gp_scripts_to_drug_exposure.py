from __future__ import annotations

from typing import List, TYPE_CHECKING
from delphyne.model.mapping.code_mapper import CodeMapping

from src.main.python.util import create_gp_emis_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_emis_gp_scripts_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:
    source = wrapper.source_data.get_source_file('covid19_emis_gp_scripts.csv')
    rows = source.get_csv_as_generator_of_dicts()

    dmd_mapper = wrapper.code_mapper.generate_code_mapping_dictionary('dm+d')
    emis_script_mapper = wrapper.mapping_tables_lookup('./resources/mapping_tables/gp_emis_script.csv', first_only=False)

    for row in rows:
        if row['code_type'] == '6':
            mappings = dmd_mapper.lookup(row['code'], first_only=False)
        elif row['code_type'] == '3':
            # Emis codes
            mappings = []
            for target_concept_id in emis_script_mapper.get(row['code'], [0]):
                mapping = CodeMapping()
                mapping.source_concept_code = row['code']
                mapping.target_concept_id = target_concept_id
                mapping.source_concept_id = 0
                mappings.append(mapping)
        else:
            continue

        date_start = wrapper.get_gp_datetime(row['issue_date'],
                                             person_source_value=row['eid'],
                                             format="%d/%m/%Y",
                                             default_date=None)

        if not date_start:
            continue

        visit_id = create_gp_emis_visit_occurrence_id(row['eid'], date_start)

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
                data_source='covid19 gp_emis',
                visit_occurrence_id=visit_id,
            )
