from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from ..util.date_functions import get_datetime
from ..core.code_mapper import CodeMapping

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_oper_to_procedure_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ProcedureOccurrence]:
    hesin_oper = wrapper.get_dataframe('hesin_oper.csv')
    hesin = wrapper.get_dataframe('hesin.csv')
    hesin = hesin.drop_duplicates(subset=['eid', 'ins_index'])  # fix for synthetic data

    source = hesin_oper.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))

    oper4 = wrapper.code_mapper.generate_code_mapping_dictionary('OPCS4', remove_dot_from_codes=True)
    oper3 = wrapper.mapping_tables_lookup('./resources/mapping_tables/opcs3.csv', first_only=False)

    procedure_type_concept = wrapper.mapping_tables_lookup('./resources/mapping_tables/procedure_type_concepts.csv')

    records = []

    for _, row in source.iterrows():
        procedure_type_concept_id = procedure_type_concept.get(row['level'], 0)

        procedure_date = get_datetime(row['opdate'], "%d/%m/%Y")

        if not pd.isnull(row['oper4']):
            source_value = row['oper4']
            procedure_targets = oper4.lookup(row['oper4'])
        elif not pd.isnull(row['oper3']):
            source_value = row['oper3']
            procedure_targets = []
            for target_concept_id in oper3.get(row['oper3'], [0]):  # if oper3 code not found, at least create a target 0
                procedure_target = CodeMapping()
                procedure_target.source_concept_code = row['oper3']
                procedure_target.target_concept_id = target_concept_id
                procedure_target.source_concept_id = 0
                procedure_targets.append(procedure_target)
        else:
            continue

        # Visit
        visit_occurrence_id = wrapper.lookup_visit(row['eid'], 'HES-' + str(row['spell_index']))

        for target in procedure_targets:
            r = wrapper.cdm.ProcedureOccurrence(
                person_id=row['eid'],
                procedure_concept_id=target.target_concept_id,
                procedure_date=procedure_date,
                procedure_datetime=procedure_date,
                procedure_type_concept_id=procedure_type_concept_id,
                procedure_source_value=source_value,
                procedure_source_concept_id=target.source_concept_id,
                visit_occurrence_id=visit_occurrence_id,
                data_source=f'HES-{row["dsource"]}'
            )
            records.append(r)
    return records