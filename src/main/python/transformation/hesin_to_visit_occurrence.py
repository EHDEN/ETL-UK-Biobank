from __future__ import annotations

from typing import List, TYPE_CHECKING
import pandas as pd

from ..util.date_functions import DEFAULT_DATETIME
from ..util import create_hes_visit_occurrence_id, is_null

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def hesin_to_visit_occurrence(wrapper: Wrapper) -> List[Wrapper.cdm.VisitOccurrence]:
    source = wrapper.source_data.get_source_file('hesin.csv')
    df = source.get_csv_as_df(apply_dtypes=False)
    df['admidate'] = pd.to_datetime(df['admidate'], dayfirst=True)
    df['disdate'] = pd.to_datetime(df['disdate'], dayfirst=True)
    df['epistart'] = pd.to_datetime(df['epistart'], dayfirst=True)
    df = df.sort_values(['eid', 'spell_index'])
    df = df.groupby(by=['eid', 'dsource', 'spell_index']).agg(
        {'admidate': 'min',
         'disdate': 'max',
         'admimeth': 'first',
         'admisorc': 'first',
         'disdest': 'last',
         'epistart': 'min'
         }
    ).reset_index()

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

        if not is_null(row['admidate']):
            start_date = row['admidate']
        elif not is_null(row['epistart']):
            start_date = row['epistart']
        else:
            start_date = DEFAULT_DATETIME

        if is_null(row['disdate']):
            end_date = start_date
        else:
            end_date = row['disdate']

        data_source = row['dsource']

        # The dsource contains strings of 3-4 characters and admimeth, admisorc, disdest contrains integers of length 2.
        # Thus the 50character cut off it is not an issue for losing data, currently.
        method_source = "record origin:"+data_source+"/admission method:"+str(row['admimeth'])
        admit_source = "record origin:"+data_source+"/admission source:"+str(row['admisorc'])
        dis_source = "record origin:"+data_source+"/discharge destination:"+str(row['disdest'])

        r = wrapper.cdm.VisitOccurrence(
            visit_occurrence_id=create_hes_visit_occurrence_id(row['eid'], row['spell_index']),
            person_id=person_id,
            visit_concept_id=visit_reason.get((row['admimeth'], row['dsource']), 0),
            visit_start_date=start_date.date(),
            visit_start_datetime=start_date,
            visit_end_date=end_date.date(),
            visit_end_datetime=end_date,
            visit_type_concept_id=32827,  # 'EHR encounter record'
            visit_source_value=method_source,
            admitting_source_concept_id=admit_reason.get((row['admisorc'], row['dsource']), 0),
            admitting_source_value=admit_source,
            discharge_to_concept_id=dis_reason.get((row['disdest'], row['dsource']), 0),
            discharge_to_source_value=dis_source,
            data_source=f'HES-{data_source}'
        )
        records.append(r)
    return records
