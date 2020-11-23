# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

from datetime import datetime
from calendar import monthrange
import pandas as pd

DEFAULT_DATETIME = datetime.strptime('1970-01-01', '%Y-%m-%d')


def get_datetime(date: str = '', format='%Y-%m-%d', default_date=DEFAULT_DATETIME) -> datetime:
    """
    If the date is incomplete, returns:
     - 1st of the month (if day missing)
     - 1st of January (if month missing)
    If the date is missing, returns given default date.
    :param date: string
    :param format: date format
    :param default_date: default start date ("1970-01-01")
    """
    if pd.isnull(date) or not date.strip():
        return default_date
    try:
        return datetime.strptime(date, format)
    except ValueError:
        pass
    format_year_month = format.replace('%d', '').strip('-/')
    try:
        return datetime.strptime(date, format_year_month)  # returns 1st of the month by default
    except ValueError:
        pass
    try:
        return datetime.strptime(date, '%Y')  # returns 1st of January by default
    except ValueError:
        raise ValueError(f'unrecognized date value {date}')


def get_end_datetime(date: str, format='%Y-%m-%d', default_date=DEFAULT_DATETIME) -> datetime:
    """
    If the date is incomplete, returns:
     - last of the month (if day missing)
     - 31st of December (if month missing)
    If the date is missing, returns a default date.
    :param date: string
    :param format: date format
    :param default_date: default end date ("1970-01-01)
    """
    end_date = get_datetime(date, format, default_date)
    if pd.notnull(date):
        if len(date) == 4:  # only year
            end_date = end_date.replace(month=12, day=31)
        elif len(date) == 7:  # year + month, assuming a single character separator
            days_in_month = monthrange(end_date.year, end_date.month)[1]
            end_date = end_date.replace(day=days_in_month)
    return end_date


if __name__ == '__main__':
    import numpy as np
    print(get_datetime('2020-02-18'))
    print(get_datetime('2020/02/18', format='%Y/%m/%d'))
    print(get_datetime('2020-02'))
    print(get_datetime('2020'))
    print(get_datetime(''))
    print(get_datetime(None))
    print(get_datetime(np.nan))
    print(get_end_datetime('2020-02-18'))
    print(get_end_datetime('2020/02/18', format='%Y/%m/%d'))
    print(get_end_datetime('2020-02'))
    print(get_end_datetime('2020'))
    print(get_end_datetime(''))
    print(get_end_datetime(None))
    print(get_end_datetime(np.nan))

    print(get_datetime('5/12/2020', format='%d/%m/%Y'))
    print(get_datetime('12/2020', format='%d/%m/%Y'))
    print(get_datetime('2020', format='%d/%m/%Y'))
