from __future__ import annotations

from typing import List, TYPE_CHECKING
from datetime import timedelta
import re
from sqlalchemy.orm.exc import NoResultFound
from src.main.python.util import get_datetime, is_null, extend_read_code
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
        elif not is_null(row['bnf_code']):  # TODO: remove or keep as last resort for source value?
            mapping = CodeMapping()
            mapping.source_concept_code = row['bnf_code']
            mapping.source_concept_id = 0
            mapping.target_concept_id = 0
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
        # TODO: ok original unit string as such (source value), or extract substring (gr,ml etc)?
        unit = row['quantity'] if not is_null(row['quantity']) else None

        num_quantity, calc_end_date = None, False
        whole_nr  = '(\d+|(\d+\.0+))'  # e.g. 20 or 20.0 (any nr of zeroes after .)
        any_nr    = '(\d+|(\d+\.d+))'  # e.g. 20 or 20.5 (any nr of cyphers after .)
        separator = '(\s+|(\s+(-|x)\s+))'  # e.g. space(s) or space(s) + -|x + space(s)
        additions = '(?:dispersible\s+)?'
        if raw_quantity:
            for pattern, calc_end_date in [
                (whole_nr + separator + additions + '[tT][aA][bB]', True),      # tab(lets)
                (whole_nr + separator + '[cC][aA][pP]', True),      # cap(sules)
                (whole_nr + separator + '[dD][oO][sS]', True),      # dos(es)
                (whole_nr + separator + '[sS][tT][rR]', True),      # str(ips)
                (whole_nr + separator + '[sS][aA][cC]', True),      # sac(hets)
                (whole_nr + separator + '[uU][nN][iI][tT]', True),  # unit(s)
                # note: packets=blisters, uncertain how many individual doses they contain
                (whole_nr + separator + '[pP][aA][cC]', False),  # pac(kets)
                (any_nr + '\s+[mM]*[gG]', False),                # (m)g(rams)
                (any_nr + '\s+[mM][iI]*[lL]', False),            # ml / mil(lliliters)
                ('^\s*' + whole_nr + '\s*$', True),              # whole number without unit
                (any_nr, False)                                  # any number
            ]:
                match = re.search(pattern,raw_quantity)
                if match:
                    num_quantity = re.search(any_nr, match.group()).group()  # extract numeric part
                    if calc_end_date:
                        num_quantity = int(num_quantity)
                    break

            # quick test for parsing result
            # print(raw_quantity, '|', num_quantity, '|', calc_end_date)

        if calc_end_date:
            date_end = date_start + timedelta(days=num_quantity) # assuming 1 tab/cap/etc. per day
        else:
            date_end = date_start  # TODO: ok or use date_start + 1? this way it's clear we don't know

        r = wrapper.cdm.DrugExposure(
            person_id=person_id,
            drug_exposure_start_date=date_start,
            drug_exposure_start_datetime=date_start,
            drug_exposure_end_date=date_end,
            drug_exposure_end_datetime=date_end,
            drug_concept_id=mapping.target_concept_id,
            drug_source_concept_id=mapping.source_concept_id,
            drug_source_value=mapping.source_concept_code,
            drug_type_concept_id=38000177,  # prescription written
            quantity=num_quantity,
            dose_unit_source_value=unit,
            data_source=data_source,
            visit_occurrence_id=visit_id,
        )
        records.append(r)

    return records
