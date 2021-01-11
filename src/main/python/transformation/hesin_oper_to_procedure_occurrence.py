from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd
from delphyne.model.mapping.code_mapper import CodeMapping

from ..util import get_datetime
from ..util import add_dot_to_opcsx_code


if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_oper_to_procedure_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ProcedureOccurrence]:
    hesin_oper_source = wrapper.source_data.get_source_file('hesin_oper.csv')
    hesin_oper = hesin_oper_source.get_csv_as_df(apply_dtypes=False)
    hesin_source = wrapper.source_data.get_source_file('hesin.csv')
    hesin = hesin_source.get_csv_as_df(apply_dtypes=False)
    hesin = hesin.drop_duplicates(subset=['eid', 'ins_index'])  # fix for synthetic data

    df = hesin_oper.merge(hesin, on=['eid', 'ins_index'], how='left', suffixes=('', '_x'))
    df['oper4_dot'] = df['oper4'].apply(add_dot_to_opcsx_code)

    oper4 = wrapper.code_mapper.generate_code_mapping_dictionary('OPCS4')
    oper3 = wrapper.mapping_tables_lookup('./resources/mapping_tables/opcs3.csv', first_only=False)

    records = []

    for _, row in df.iterrows():
        person_id = wrapper.lookup_person_id(row['eid'])
        if not person_id:
            # Person not found
            continue

        procedure_date = get_datetime(row['opdate'], "%d/%m/%Y")

        if not pd.isnull(row['oper4']):
            source_value = row['oper4']
            procedure_targets = oper4.lookup(row['oper4_dot'])
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
        visit_occurrence_id = wrapper.lookup_visit_occurrence_id(
            person_id=person_id,
            record_source_value=f'HES-{row["spell_index"]}'
        )

        visit_detail_id = wrapper.lookup_visit_detail_id(
            person_id=person_id,
            record_source_value=f'HES-{row["ins_index"]}'
        )

        for target in procedure_targets:
            r = wrapper.cdm.ProcedureOccurrence(
                person_id=person_id,
                procedure_concept_id=target.target_concept_id,
                procedure_date=procedure_date,
                procedure_datetime=procedure_date,
                procedure_type_concept_id=32817,  # EHR
                procedure_source_value=source_value,
                procedure_source_concept_id=target.source_concept_id,
                visit_occurrence_id=visit_occurrence_id,
                visit_detail_id=visit_detail_id,
                data_source=f'HES-{row["dsource"]}'
            )
            records.append(r)
    return records
