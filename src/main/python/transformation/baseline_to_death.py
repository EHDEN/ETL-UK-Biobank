from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..core.model import Death

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def baseline_to_death(wrapper: Wrapper) -> List[Death]:
    source = wrapper.get_dataframe('baseline.csv', use_columns=['eid', '40000-0.0', '40001-0.0'])

    codes = source['40001-0.0'].dropna().unique().tolist()
    mapper = wrapper.code_mapper.generate_code_mapping_dictionary('ICD10', restrict_to_codes=codes, remove_dot_from_codes=True)
    persons = []

    records = []
    with wrapper.db.session_scope() as session:
        # Get the existing death records and check if they are in baseline, if so they are added to the persons list.
        query_1 = session.query(Death).filter(Death.person_id.in_(source['eid'].astype(int).tolist()))
        for q in query_1:
            persons.append(q.person_id)

        for _, row in source.iterrows():
            if pd.isna(row['40000-0.0']):
                continue
            if pd.isna(row['40001-0.0']):
                continue
            # If the person is not in the existing death records, proceed.
            if int(row['eid']) not in persons:
                target = mapper.lookup(row['40001-0.0'], first_only=True)
                r = Death(
                    person_id=int(row['eid']),
                    death_date=row['40000-0.0'],
                    death_datetime=row['40000-0.0'],
                    death_type_concept_id=32815,  # Death Certificate
                    cause_concept_id=target.target_concept_id,
                    cause_source_concept_id=target.source_concept_id,
                    cause_source_value=row['40001-0.0']
                )
                records.append(r)

        return records
