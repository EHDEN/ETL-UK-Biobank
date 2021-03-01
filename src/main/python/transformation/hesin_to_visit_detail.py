from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import DEFAULT_DATETIME
from ..util import create_hes_visit_detail_id, create_hes_visit_occurrence_id

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_to_visit_detail(wrapper: Wrapper) -> List[Wrapper.cdm.VisitDetail]:
    source = wrapper.source_data.get_source_file('hesin.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    df['admidate'] = pd.to_datetime(df['admidate'], dayfirst=True)
    df['disdate'] = pd.to_datetime(df['disdate'], dayfirst=True)

    visit_reason, admit_reason, dis_reason = {}, {}, {}
    for origin in ['HES', 'PEDW', 'SMR']:
        visit_reason.update(
            wrapper.mapping_tables_lookup(
                f'./resources/mapping_tables/hesin_admimeth_{origin}.csv',
                add_info='ADD_INFO:coding_origin')
        )
        admit_reason.update(
            wrapper.mapping_tables_lookup(
                f'./resources/mapping_tables/hesin_admisorc_{origin}.csv',
                add_info='ADD_INFO:coding_origin')
        )
        dis_reason.update(
            wrapper.mapping_tables_lookup(
                f'./resources/mapping_tables/hesin_disdest_{origin}.csv',
                add_info='ADD_INFO:coding_origin')
        )

    records = []
    for _, row in df.iterrows():

        person_id = row['eid']

        if pd.isna(row['admidate']):
            start_date = DEFAULT_DATETIME
        else:
            start_date = row['admidate']

        if pd.isna(row['disdate']):
            end_date = DEFAULT_DATETIME
        else:
            end_date = row['disdate']

        data_source = row['dsource']

        # The dsource contains strings of 3-4 characters and admimeth, admisorc, disdest contrains integers of length 2.
        # Thus the 50character cut off it is not an issue for losing data, currently.
        method_source = "record origin:"+data_source+"/admission method:"+str(row['admimeth'])
        admit_source = "record origin:"+data_source+"/admission source:"+str(row['admisorc'])
        dis_source = "record origin:"+data_source+"/discharge destination:"+str(row['disdest'])

        visit_occurrence_id = create_hes_visit_occurrence_id(row['eid'], row['spell_index'])

        r = wrapper.cdm.VisitDetail(
            visit_detail_id=create_hes_visit_detail_id(row['eid'], row['ins_index']),
            person_id=person_id,
            visit_detail_concept_id=visit_reason.get((row['admimeth'], row['dsource']), 0),
            visit_detail_start_date=start_date.date(),
            visit_detail_start_datetime=start_date,
            visit_detail_end_date=end_date.date(),
            visit_detail_end_datetime=end_date,
            visit_detail_type_concept_id=32827,  # 'EHR encounter record'
            visit_detail_source_value=method_source,
            admitting_source_concept_id=admit_reason.get((row['admisorc'], row['dsource']), 0),
            admitting_source_value=admit_source,
            discharge_to_concept_id=dis_reason.get((row['disdest'], row['dsource']), 0),
            discharge_to_source_value=dis_source,
            visit_occurrence_id=visit_occurrence_id,
            data_source=f'HES-{data_source}'
        )
        records.append(r)
    return records
