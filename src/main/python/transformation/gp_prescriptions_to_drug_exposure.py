from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from datetime import timedelta

from src.main.python.util.date_functions import get_datetime


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = pd.DataFrame(wrapper.get_source_data('gp_prescriptions.csv'))

    # map dm+d > read v2 > drug name
    dmd_codes = list(filter(None, set(source['dmd_code'])))
    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('dm+d', restrict_to_codes=dmd_codes)
    # Read v2 drug codes not available in Athena!
    # read2_codes = list(filter(None, set(source['read_2'])))
    # read2_mapper = \
    #     wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read2_codes)

    records = []
    for _, row in source.iterrows():

        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')
        # TODO: placeholder, replace with proper end date estimate
        date_end = date_start + timedelta(days=1)

        # drug mappings
        drug_concept_id = ''
        if row['dmd_code']:
            mapping = dmd_mapper.lookup(row['dmd_code'], first_only=True)
            if mapping:
                drug_concept_id = mapping.target_concept_id
                source_concept_id = mapping.source_concept_id
                drug_col = 'dmd_code'
        # TODO: implement mappings for read2 column
        # if not drug_concept_id and row['read_2']:
        #     mapping = read2_mapper.lookup(row['read_2'], first_only=True, full_mapping=True)
        #     if mapping:
        #         drug_concept_id = mapping.target_concept_id
        #         source_concept_id = mapping.source_concept_id
        #         drug_col = 'read_2'
        # TODO: implement mappings for drug_name column
        # if not drug_concept_id and row['drug_name']:
        #     mapping = # TODO: implement mapper
        #     if mapping:
        #         drug_concept_id = # TODO: get concept_id from mapping
        #         source_concept_id = None
        #         drug_col = 'drug_name'
        if not drug_concept_id:
            continue

        r = wrapper.cdm.DrugExposure(
            person_id=row['eid'],
            drug_exposure_start_date=date_start.date(),
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end.date(),
            drug_exposure_end_datetime=date_end,
            drug_concept_id=drug_concept_id,
            drug_type_concept_id=38000177, #Prescription written
            quantity=None,
            drug_source_value=row[drug_col],
            drug_source_concept_id=source_concept_id,
            # TODO: see if any of the following needed
            # provider_id=row['data_provider'],
            route_concept_id=None,
            route_source_value=None,
            dose_unit_source_value=None,
            visit_occurrence_id=None
        )
        records.append(r)

    return records
