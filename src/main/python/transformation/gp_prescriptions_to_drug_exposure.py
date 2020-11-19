from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from datetime import timedelta
import re
from sqlalchemy.orm.exc import NoResultFound
from src.main.python.util import get_datetime, filter_nulls, extend_read_code
from src.main.python.core.model import VisitOccurrence
from src.main.python.core.code_mapper import CodeMapping


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

def gp_prescriptions_to_drug_exposure(wrapper: Wrapper) -> List[Wrapper.cdm.DrugExposure]:

    source = pd.DataFrame(wrapper.get_source_data('gp_prescriptions.csv'))

    dmd_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('dm+d', restrict_to_codes=list(source['dmd_code']))
    # TODO: Read v2 codes not available in Athena & NHS, find other mapping source if possible
    read2_codes = list(extend_read_code(code) for code in filter(filter_nulls,source['read_2']))
    read2_mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary('Read', restrict_to_codes=read2_codes)

    records = []
    for _, row in source.iterrows():

        # TODO: in theory read v2 > drug name, implement Read v2 mapping and invert check order
        if filter_nulls(row['dmd_code']):
            mapping = dmd_mapper.lookup(row['dmd_code'], first_only=True)
        elif filter_nulls(row['drug_name']):
            mapping = CodeMapping()
            mapping.source_concept_code = row['drug_name']
            mapping.source_concept_id = 0
            mapping.target_concept_id = 0 # TODO: placeholder, get from mapping tables
        elif filter_nulls(row['read_2']):
            mapping = read2_mapper.lookup(extend_read_code(row['read_2']), first_only=True)
        else:
            continue

        person_id = row['eid']
        data_source = 'GP-' + row['data_provider'] if row['data_provider'] else None
        date_start = get_datetime(row['issue_date'], format='%d/%m/%Y')

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

        raw_quantity = row['quantity'] if filter_nulls(row['quantity']) else None
        unit = row['quantity'] if filter_nulls(row['quantity']) else None

        num_quantity, multiply = None, False
        whole_nr  = '(\d+|\d+\.0+)'  # e.g. 20 or 20.0 (any nr of zeroes after .)
        any_nr    = '(\d+|\d+\.d+)'  # e.g. 20 or 20.5 (any nr of cyphers after .)
        separator = '(\s+|\s+(-|x)\s+)'  # e.g. space(s) or space(s) + -|x + space(s)
        if raw_quantity:
            for pattern, is_valid_unit in [
                (whole_nr + separator + '[tT][aA][bB]', 'tab'),  # tab(lets)
                (whole_nr + separator + '[cC][aA][pP]', 'cap'),  # cap(sules)
                (whole_nr + separator + '[dD][oO][sS]', 'dos'),  # dos(es)
                (whole_nr + separator + '[sS][tT][rR]', 'str'),  # str(ips)
                (whole_nr + separator + '[sS][aA][cC]', 'sac'),  # sac(hets)
                (whole_nr + separator + '[pP][aA][cC]', 'pac'),  # pac(kets)
                (any_nr + '\s+[mM]*[gG]', 'weight'),             # N (m)g(rams)
                (any_nr + '\s+[mM][iI]*[lL]', 'volume'),         # N ml / mil(lliliters)
                ('^' + whole_nr + '$', 'whole_nr'),              # whole number without unit
                ('(\d+|\d+\.d+)', None)                          # any number
            ]:
                match = re.search(pattern,raw_quantity)
                if match:
                    match_string = match.group()
                    try:
                        regex = re.compile(whole_nr)  # extract only numeric part
                        num_quantity = int(regex.match(match_string).group())
                        print(raw_quantity,'|',num_quantity,unit)
                        multiply = unit in ['tab','cap','dos','str','sac','whole_nr']
                        break
                    except:
                        continue

        if num_quantity and multiply:
            date_end = date_start + timedelta(days=num_quantity*multiply)
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
