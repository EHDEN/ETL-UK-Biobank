from __future__ import annotations

import csv
from typing import List, TYPE_CHECKING

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def assessment_center_to_care_site(wrapper: Wrapper) -> List[Wrapper.cdm.CareSite, Wrapper.cdm.Location]:
    records = []
    with open('./resources/encodings/10_assessment_center.tsv') as f_in:
        assessment_centers = csv.DictReader(f_in, delimiter='\t')
        for row in assessment_centers:
            yield wrapper.cdm.CareSite(
                care_site_id=row['coding'],
                care_site_name=row['meaning'],
                care_site_source_value=row['coding']
            )
