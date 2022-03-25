from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util import refactor_icdx_code

from sqlalchemy import and_, select

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    source = wrapper.source_data.get_source_file('baseline.csv')
    df = source.get_csv_as_df(apply_dtypes=False, usecols=['eid', '40000-0.0', '40001-0.0', '40002-0.0'])

    source_death = wrapper.source_data.get_source_file('death_cause.csv')
    df_death = source_death.get_csv_as_df(apply_dtypes=False)
    secondary_death = df_death[df_death['arr_index'] != '0']['cause_icd10'].unique().tolist()

    df['ICD10_dot'] = df['40002-0.0'].apply(refactor_icdx_code)

    mapper = \
        wrapper.code_mapper.generate_code_mapping_dictionary(
            'ICD10', restrict_to_codes=list(df['ICD10_dot']))

    for _, row in df.iterrows():
        if pd.isna(row['40000-0.0']):
            continue

        # # if there is no primary cause of death in baseline there will be no death record
        # if pd.isna(row['40001-0.0']):
        #     continue

        if pd.isna(row['40002-0.0']):
            continue

        # if the icd code is already in the death registry file it has been mapped already
        if row['40002-0.0'] in secondary_death:
            continue

        # with wrapper.db.session_scope() as session:
        #     # Get the existing secondary cause of death records and check if they are in baseline,
        #     # if so they are added to the persons list.
        #     query = session.query(wrapper.cdm.ConditionOccurrence)\
        #         .filter(and_(wrapper.cdm.ConditionOccurrence.person_id == row['eid'],
        #                      wrapper.cdm.ConditionOccurrence.condition_source_value == row['40002-0.0']))
        #
        #     for q in query:
        #         if row['eid'] == q:
        #             continue

        # If the person is not in the existing death records, proceed.
        target = mapper.lookup(row['ICD10_dot'], first_only=True)
        yield wrapper.cdm.ConditionOccurrence(
            person_id=int(row['eid']),
            condition_concept_id=target.target_concept_id,
            condition_start_date=row['40000-0.0'],
            condition_start_datetime=row['40000-0.0'],
            condition_type_concept_id=32815,  # Death Certificate
            condition_source_concept_id=target.source_concept_id,
            condition_source_value=row['40002-0.0']
        )
