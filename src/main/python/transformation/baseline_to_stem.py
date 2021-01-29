from __future__ import annotations

import csv
import logging
import re
from typing import List, Tuple, TYPE_CHECKING, Optional
from pathlib import Path
from ..field_mapper.FieldConceptMapper import FieldConceptMapper
from ..util.date_functions import get_datetime, DEFAULT_DATETIME
from ..util import create_baseline_visit_occurrence_id, is_null
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

logger = logging.getLogger(__name__)
FIELD_PATTERN = re.compile(r'(\d+)-(\d+).(\d+)')


def parse_column_name(column_name: str) -> Tuple[Optional[str], Optional[int]]:
    match = FIELD_PATTERN.match(column_name)
    if not match:
        return None, None
    field_id, instance, _ = match.groups()  # Array index not relevant
    return field_id, int(instance)


def baseline_to_stem(wrapper: Wrapper) -> List[Wrapper.cdm.StemTable]:
    source = wrapper.source_data.get_source_file('baseline.csv')
    df = source.get_csv_as_df(apply_dtypes=False)

    # check for invalid columns and drop them
    cols_to_drop = []
    column_name_to_field_id = {}
    column_name_to_instance = {}
    for col in list(df.columns)[1:]:  # skip eid
        field_id, instance = parse_column_name(col)
        column_name_to_field_id[col] = field_id
        column_name_to_instance[col] = instance
        if field_id is None:
            logger.warning(f'Column "{col}" does not match expected field pattern. '
                           f'Cannot retrieve field_id and instance, hence column will be '
                           f'dropped.')
            cols_to_drop.append(col)
    df.drop(columns=cols_to_drop, inplace=True)

    # load mappings from UKB code to standard concept_id
    field_to_concept_id_dict = wrapper.generate_code_to_concept_id_dict(
        column_name_to_field_id.values(), vocabulary_id='UK Biobank')

    field_mapper = FieldConceptMapper(Path('./resources/baseline_field_mapping'), 'INFO')

    with open('./resources/baseline_field_mapping/field_id_to_type_concept_id.csv') as f_in:
        csv_in = csv.DictReader(f_in)
        type_concept_lookup = {x['field_id']: x['type_concept_id'] for x in csv_in}

    records = []
    for _, row in df.iterrows():
        person_id = row.pop('eid')

        for column_name, value in row.items():
            if value == '' or pd.isna(value):
                continue

            field_id = column_name_to_field_id.get(column_name)
            instance = column_name_to_instance.get(column_name)

            # Lookup the mapping. If not targets defined (or ignored), skip it before calculating other things.
            targets = field_mapper.lookup(field_id, value)
            if not targets:
                continue

            # Date
            date_field_id = field_mapper.lookup_date_field(field_id)
            date_column_name = f'{date_field_id}-{instance}.0'
            fallback_column_name = f'{field_mapper.default_date_field}-{instance}.0'
            if date_column_name in row and not is_null(row[date_column_name]):
                datetime = get_datetime(row[date_column_name][:10])
            elif fallback_column_name in row and not is_null(row[fallback_column_name]):
                # If date column is not given, fall back to the default date field (53)
                datetime = get_datetime(row[fallback_column_name][:10])
            else:
                # No date could be retrieved
                datetime = DEFAULT_DATETIME
                logger.warning(f'Date column "{date_column_name}" for "{column_name}" '
                               f'was not found in the baseline data')

            # Visit
            visit_occurrence_id = create_baseline_visit_occurrence_id(person_id, instance)

            source_concept_id = field_to_concept_id_dict.get(field_id, None)
            for target in targets:
                records.append(wrapper.cdm.StemTable(
                    person_id=person_id,
                    start_date=datetime.date(),
                    start_datetime=datetime,
                    concept_id=target.concept_id,
                    source_value=target.source_value,
                    source_concept_id=source_concept_id,
                    value_as_concept_id=target.value_as_concept_id,
                    value_as_number=target.value_as_number,
                    unit_concept_id=target.unit_concept_id,
                    value_as_string=target.value_as_string,
                    type_concept_id=type_concept_lookup[field_id],  # Survey
                    visit_occurrence_id=visit_occurrence_id,
                    data_source='baseline'
                    )
                )
    return records
