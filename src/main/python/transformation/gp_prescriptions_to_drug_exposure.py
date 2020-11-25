from __future__ import annotations

from typing import List, TYPE_CHECKING
from datetime import timedelta
from sqlalchemy.orm.exc import NoResultFound
from src.main.python.util import get_datetime, is_null, extend_read_code, \
    extract_numeric_quantity, valid_quantity_for_days_estimate
from src.main.python.core.model import VisitOccurrence
from src.main.python.core.code_mapper import CodeMapping


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper
    

def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = wrapper.get_dataframe('gp_prescriptions.csv')
    source['read_2_extended'] = source['read_2'].apply(extend_read_code)

    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('dm+d', restrict_to_codes=list(source['dmd_code']))

    # TODO: Read v2 codes for drugs not available in Athena & NHS, find other mapping source if possible
    read2_codes = [code for code in filter(lambda x: not is_null(x),
                                           set(source['read_2_extended']))]
    read2_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read2_codes)

    records = []
    for _, row in source.iterrows():

        # TODO: in theory read v2 > drug name, implement Read v2 mapping and invert check order
        if not is_null(row['dmd_code']):
            mapping = dmd_mapper.lookup(row['dmd_code'], first_only=True)
        elif not is_null(row['drug_name']):
            mapping = CodeMapping()
            mapping.source_concept_code = row['drug_name']
            mapping.source_concept_id = 0
            mapping.target_concept_id = 0  # TODO: placeholder, get from mapping tables
        elif not is_null(row['read_2']):
            mapping = read2_mapper.lookup(row['read_2_extended'], first_only=True)
        else:
            continue

        person_id = row['eid']
        data_source = 'GP-' + row['data_provider'] if row['data_provider'] else None
        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')

        # Look up visit_id in VisitOccurrence table
        with wrapper.db.session_scope() as session:
            query = session.query(VisitOccurrence) \
                .filter(VisitOccurrence.person_id == person_id) \
                .filter(VisitOccurrence.visit_start_date == date_start) \
                .filter(VisitOccurrence.data_source == data_source) \
                .order_by(VisitOccurrence.visit_start_date) \
                .limit(1)  # multiple records could be found
            try:
                visit_record = query.one()
                visit_id = visit_record.visit_occurrence_id
            except NoResultFound:
                visit_id = None

        raw_quantity = row['quantity'] if not is_null(row['quantity']) else None
        unit = row['quantity'] if not is_null(row['quantity']) else None

        valid_quantity = valid_quantity_for_days_estimate(raw_quantity)
        if valid_quantity:
            num_quantity = extract_numeric_quantity(valid_quantity)
            date_end = date_start + timedelta(days=num_quantity)  # assuming 1 tab/cap/etc. per day
        else:
            num_quantity = extract_numeric_quantity(raw_quantity)
            date_end = date_start

        r = wrapper.cdm.DrugExposure(
            person_id=person_id,
            drug_exposure_start_date=date_start,
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end,
            drug_exposure_end_datetime=date_end,
            drug_concept_id=mapping.target_concept_id,
            drug_source_concept_id=mapping.source_concept_id,
            drug_source_value=mapping.source_concept_code[:50],
            drug_type_concept_id=38000177,  # prescription written
            quantity=num_quantity,
            dose_unit_source_value=unit,
            data_source=data_source,
            visit_occurrence_id=visit_id,
        )
        records.append(r)

    return records
