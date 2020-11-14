from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING
import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper

type_lookup = {
    '1':  32815,  # Death Certificate
    '2':  32815,
    '7':  32815,
    '19': 32815,
    '52': 32815,
    '54': 32815,
    '55': 32815
}


def death_to_death(wrapper: Wrapper) -> List[Wrapper.cdm.Death]:
    """
    eid
    ins_index
    arr_index
    level
    cause_icd10

    eid
    ins_index
    dsource
    source
    date_of_death
    :param wrapper:
    :return:
    """

    death = pd.DataFrame(wrapper.get_source_data('death.csv'))
    death_cause = pd.DataFrame(wrapper.get_source_data('death_cause.csv'))
    # TODO: drop duplicates from death table. (keep first by date)
    # TODO: drop duplicates from death_cuase table (keep array_index = 0)
    source = death.merge(death_cause, on=('eid', 'ins_index'), how='left')

    # TODO: instantiate icd10 mapper

    records = []
    for _, row in source.iterrows():
        r = wrapper.cdm.Death(
            person_id=row['eid'],
            # TODO
            )
        # TODO: record source in separate field
        records.append(r)

    return records
