from __future__ import annotations

from typing import List, TYPE_CHECKING
from delphyne.model.mapping.code_mapper import CodeMapping

from src.main.python.util import get_datetime, create_gp_emis_visit_occurrence_id, is_null

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def covid19_emis_gp_scripts_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = wrapper.source_data.get_source_file('covid19_emis_gp_scripts.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary(
            'dm+d', restrict_to_codes=list(df['code']))

    emis_script_mapper = wrapper.mapping_tables_lookup('./resources/mapping_tables/gp_emis_script.csv')

    for _, row in df.iterrows():
        if row['code_type'] == '6':
            # dm+d codes have one to one mappings to standard concepts: first_only parameter doesn't change the outcome
            mapping = dmd_mapper.lookup(row['code'], first_only=True)
        elif row['code_type'] == '3':
            # Emis codes
            mapping = CodeMapping()
            mapping.source_concept_code = row['code']
            mapping.target_concept_id = emis_script_mapper.get(row['code'], 0)
            mapping.source_concept_id = 0
        else:
            continue

        date_start = wrapper.get_gp_datetime(row['issue_date'],
                                             person_source_value=row['eid'],
                                             format="%d/%m/%Y",
                                             default_date=None)

        if not date_start:
            continue

        visit_id = create_gp_emis_visit_occurrence_id(row['eid'], date_start)

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
