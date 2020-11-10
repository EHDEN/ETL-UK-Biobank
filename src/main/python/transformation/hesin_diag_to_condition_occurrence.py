from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import get_datetime

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_diag_to_condition_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.ConditionOccurrence]:
    hesin_diag = pd.DataFrame(wrapper.get_source_data('hesin_diag.csv'))
    hesin = pd.DataFrame(wrapper.get_source_data('hesin.csv'))

    records = []

    for _, row in hesin.iterrows():
        print(row['eid'])
