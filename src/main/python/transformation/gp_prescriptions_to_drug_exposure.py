from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from datetime import timedelta
from sqlalchemy.orm.exc import NoResultFound
from src.main.python.util import get_datetime, extend_read_code
from ..core.model import VisitOccurrence


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = pd.DataFrame(wrapper.get_source_data('gp_prescriptions.csv'))

    # map dm+d > read v2 > drug name
    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('dm+d', restrict_to_codes=list(source['dmd_code']))
    # TODO: Read v2 codes not available in Athena & NHS, find other mapping source if possible
    # read2_codes = list(extend_read_code(code) for code in source['read_2'])
    # read2_mapper = \
    #     wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read2_codes)

    records = []
    for _, row in source.iterrows():

        # drug mappings
        drug_concept_id, source_concept_id = '', ''
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

        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')
        # TODO: placeholder, replace with proper end date estimate
        date_end = date_start + timedelta(days=1)

        person_id = row['eid']
        data_source = 'GP-' + row['data_provider'] if row['data_provider'] else None

        # TODO: ok to take first visit (asc order)?
        # Look up visit_id in VisitOccurrence table
        with wrapper.db.session_scope() as session:
            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == date_start) \
                .filter(VisitOccurrence.data_source == data_source) \
                .order_by(VisitOccurrence.visit_start_date.asc()) \
                .limit(1)  # multiple records could be found
            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound:
                visit_id = None

        quantity = row['quantity']
        unit = row['quantity']

        r = wrapper.cdm.DrugExposure(
            person_id=person_id,
            drug_exposure_start_date=date_start,
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end,
            drug_exposure_end_datetime=date_end,
            drug_concept_id=drug_concept_id,
            drug_source_concept_id=source_concept_id,
            drug_source_value=row[drug_col],
            drug_type_concept_id=38000177,  # prescription written
            quantity=None,  # TODO: placeholder
            dose_unit_source_value=unit,
            data_source=data_source,
            visit_occurrence_id=visit_id,
        )
        records.append(r)

    return records
