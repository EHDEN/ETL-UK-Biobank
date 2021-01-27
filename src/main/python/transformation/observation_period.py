from __future__ import annotations

from typing import List, TYPE_CHECKING

import pandas as pd

if TYPE_CHECKING:
    from src.main.python.wrapper import Wrapper


def observation_period(wrapper: Wrapper) -> List[Wrapper.cdm.ObservationPeriod]:
    gp_registrations_source = wrapper.source_data.get_source_file('gp_registrations.csv')
    gp_registrations = gp_registrations_source.get_csv_as_df(apply_dtypes=False).rename(columns={'reg_date': 'start_date', 'deduct_date': 'end_date'})\
        .fillna('01/01/1970')

    hesin_source = wrapper.source_data.get_source_file('hesin.csv')
    hesin = hesin_source.get_csv_as_df(apply_dtypes=False, usecols=['eid', 'epistart', 'epiend']).\
        rename(columns={'epistart': 'start_date', 'epiend': 'end_date'}).fillna('01/01/1970')

    covid_source = wrapper.source_data.get_source_file('covid.csv')
    covid = covid_source.get_csv_as_df(apply_dtypes=False).rename(columns={'specdate': 'start_date'})
    covid['end_date'] = covid['start_date']

    baseline_source = wrapper.source_data.get_source_file('baseline.csv')
    baseline = baseline_source.get_csv_as_df(apply_dtypes=False, usecols=['eid', '53-0.0', '53-1.0', '53-2.0', '53-3.0']).\
        rename(columns={'53-0.0': 'start_date'}).fillna('01/01/1970')

    baseline['end_date'] = baseline[['start_date', '53-1.0', '53-2.0', '53-3.0']].max(axis=1)

    df = pd.concat([gp_registrations, hesin, covid, baseline])

    df['start_date'] = df['start_date'].astype('datetime64[ns]')
    df['end_date'] = df['end_date'].astype('datetime64[ns]')

    records = []

    grouped_min = df.groupby('eid')['start_date'].min().to_frame(name='start_date').reset_index()
    grouped_max = df.groupby('eid')['end_date'].max().to_frame(name='end_date').reset_index()
    df_dates = pd.merge(left=grouped_min, right=grouped_max, left_on='eid', right_on='eid')

    for _, row in df_dates.iterrows():
        r = wrapper.cdm.ObservationPeriod(
            person_id=row['eid'],
            observation_period_start_date=row['start_date'].date(),
            observation_period_end_date=row['end_date'].date(),
            period_type_concept_id=32817  # EHR
        )
        records.append(r)
    return records
