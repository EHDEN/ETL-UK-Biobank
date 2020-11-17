from __future__ import annotations
import csv
from typing import List, TYPE_CHECKING
import pandas as pd
from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_oper_to_procedure_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ProcedureOccurrence]:
    hesin_oper = pd.DataFrame(wrapper.get_source_data('hesin_oper.csv'))
    hesin = pd.DataFrame(wrapper.get_source_data('hesin.csv'))

    source = hesin_oper.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_oper'))

    oper4_codes = wrapper.code_mapper.generate_code_mapping_dictionary('OPCS4')
    records = []

    for _, row in source.iterrows():

        proc_date = get_datetime(row['opdate'], "%d/%m/%Y")

        if row['oper4'].notnull():
            procedure = row['oper4']
            procedure_concept = oper4_codes(row['oper4'])
        elif row['oper3'].notnull():
            procedure =  row['oper3']
            procedure_concept = 0
        else:
            continue


        level = {
            1: 44786630, # Primary Procedure
            2: 44786631 # Secondary Procedure
        }

        r = wrapper.cdm.ProcedureOccurrence(
            person_id=row['eid'],
            procedure_concept_id= procedure_concept,
            procedure_date=proc_date,
            procedure_datetime=proc_date,
            procedure_type_concept_id=level,
            procedure_source_value=procedure,
            procedure_source_concept_id=procedure
        )
        records.append(r)
    return records
