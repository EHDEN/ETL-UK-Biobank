from __future__ import annotations

import logging
import re
from typing import List, Tuple, TYPE_CHECKING
from pathlib import Path
from ..field_mapper.FieldConceptMapper import FieldConceptMapper
from ..util.date_functions import get_datetime, DEFAULT_DATETIME
from sqlalchemy.orm.exc import NoResultFound, MultipleResultsFound

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

logger = logging.getLogger(__name__)
FIELD_PATTERN = re.compile(r'(\d+)-(\d+).(\d+)')


def parse_column_name(column_name: str) -> Tuple(str):
    match = FIELD_PATTERN.match(column_name)
    if not match:
        return None, None
    field_id, instance, _ = match.groups()  # Array index not relevant
    return field_id, instance


def baseline_to_stem(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.get_source_data('baseline.csv')
    field_mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'INFO')

    records = []
    with wrapper.db.session_scope() as session:
        for row in source:
            eid = row.pop('eid')
            for column_name, value in row.items():
                if value == '':
                    continue

                field_id, instance = parse_column_name(column_name)

                if field_id is None:
                    print(f'Warning: column "{column_name}" does not match expected field pattern. Cannot retrieve field_id and instance.')
                    continue

                # Date
                date_field_id = field_mapper.lookup_date_field(field_id)
                date_column_name = f'{date_field_id}-{instance}.0'
                if date_column_name in row:
                    datetime = get_datetime(row[date_column_name])
                else:
                    datetime = DEFAULT_DATETIME
                    print(f'Warning: date column "{date_column_name}" for "{column_name}" was not found in the baseline data')

                # Visit
                visit_lookup = session.query(wrapper.cdm.VisitOccurrence) \
                    .filter(wrapper.cdm.VisitOccurrence == 'baseline-' + instance)
                try:
                    visit_record = visit_lookup.one()
                    visit_occurrence_id = visit_record.visit_occurrence_id
                except NoResultFound:
                    visit_occurrence_id = None
                except MultipleResultsFound:
                    logger.warning(f'Multiple visits found for baseline instance {instance}')
                    visit_occurrence_id = None

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
                        type_concept_id=32883,  # Survey
                        visit_occurrence_id=visit_occurrence_id,
                        data_source='baseline'
                        )
                    )

    return records
