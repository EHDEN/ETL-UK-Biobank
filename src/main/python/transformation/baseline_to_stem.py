from __future__ import annotations

import re
from typing import List, TYPE_CHECKING
from pathlib import Path
from ..field_mapper.FieldConceptMapper import FieldConceptMapper
from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

FIELD_PATTERN = re.compile(r'(\d+)-(\d+).(\d+)')


def baseline_to_stem(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.get_source_data('baseline.csv')
    field_mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'INFO')

    records = []
    for row in source:
        eid = row.pop('eid')
        for column_name, value in row.items():
            if value == '':
                continue

            match = FIELD_PATTERN.match(column_name)
            if not match:
                print(f'Warning: column "{column_name}" does not match expected field pattern. Cannot retrieve field_id and instance.')
                continue
            field_id, instance, _ = match.groups()  # Array index not relevant?

            # Date
            date_field_id = field_mapper.lookup_date_field(field_id)
            date_column_name = f'{date_field_id}-{instance}.0'
            datetime = get_datetime(row[date_column_name])

            target = field_mapper.lookup(field_id, value)
            if target:
                records.append(wrapper.cdm.StemTable(
                    person_id=eid,
                    start_date=datetime.date(),
                    start_datetime=datetime,
                    concept_id=target.concept_id,
                    source_value=target.source_value,
                    value_as_concept_id=target.value_as_concept_id,
                    value_as_number=target.value_as_number,
                    unit_concept_id=target.unit_concept_id,
                    value_as_string=target.value_as_string,
                    type_concept_id=32883  # Survey
                    )
                )

    return records
