from datetime import datetime
from calendar import monthrange
import pandas as pd

# make values available for import in other scripts without having to execute function
default_date = '1970-01-01'
default_datetime = datetime.strptime(default_date, '%Y-%m-%d')


def get_datetime(date: str = '', sep='-', default_date=default_date) -> datetime:
    """
    Expects a date in the format **YYYY<sep>MM<sep>DD**,
    where the default separator <sep> == "-".
    If the date uses a different separator, you should specify it with the "sep" argument.

    If the date is incomplete, returns:
     - 1st of the month (if day missing)
     - 1st of January (if month missing)

    If the date is missing, returns a default date.

    :param date: string
    :param sep: date separator, default "-"
    :param default_date: default start date ("1970-01-01")
    """
    if pd.isnull(date) or not date.strip() or date[:4] == '9999' or date[:4] == '8888' or date == 'nan':
        # None, NaN + empty string ('', ' '), invalid dates (9999-01-01, 8888-01-01)
        date = default_date
    if sep != '-':
        date = date.replace(sep, '-')
    try:
        return datetime.strptime(date, '%Y-%m-%d')
    except ValueError:
        pass
    try:
        return datetime.strptime(date, '%Y-%m')  # returns 1st of the month by default
    except ValueError:
        pass
    try:
        return datetime.strptime(date, '%Y')  # returns 1st of January by default
    except ValueError:
        raise ValueError(f'unrecognized date value {date}')


def get_end_datetime(date: str, sep='-', default_date=default_date) -> datetime:
    """
    Expects a date in the format **YYYY<sep>MM<sep>DD**,
    where the default separator <sep> == "-".
    If the date uses a different separator, you should specify it with the "sep" argument.

    If the date is incomplete, returns:
     - last of the month (if day missing)
     - 31st of December (if month missing)

    If the date is missing, returns a default date.

    :param date: string
    :param sep: date separator, default "-"
    :param default_date: default end date ("1970-01-01)
    """
    end_date = get_datetime(date, sep, default_date)
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
    print(get_datetime('2020/02/18', sep='/'))
    print(get_datetime('2020-02'))
    print(get_datetime('2020'))
    print(get_datetime(''))
    print(get_datetime(None))
    print(get_datetime(np.nan))
    print(get_datetime('9999-99-98'))
    print(get_datetime('9999-99-99'))
    print(get_datetime('9999-01-01'))
    print(get_datetime('8888-01-01'))

    print(get_end_datetime('2020-02-18'))
    print(get_end_datetime('2020/02/18', sep='/'))
    print(get_end_datetime('2020-02'))
    print(get_end_datetime('2020'))
    print(get_end_datetime(''))
    print(get_end_datetime(None))
    print(get_end_datetime(np.nan))
