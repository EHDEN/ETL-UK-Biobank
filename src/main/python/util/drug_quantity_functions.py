import re
from typing import List, Union, Optional
from src.main.python.util import is_null


# base patterns
any_nr = '(?<![.\d])\.?[0-9]+(\.[0-9]+)?(?![.\d])'
whole_nr = '(?<![\d.])[0-9]+(\.0+)?(?![\d.])' # e.g. 20 or 20.0 (any nr of zeroes after .)
separator = '\s+([-|x]\s+)?'                  # e.g. space(s) or space(s) + -|x + space(s)
additions = '(?:dispersible\s+)?'             # e.g. dispersible tablets
# compiled patterns
re_any = re.compile(any_nr)
re_tab = re.compile(whole_nr + separator + additions + '[tT][aA][bB]')
re_cap = re.compile(whole_nr + separator + '[cC][aA][pP]')  # cap(sules)
re_dos = re.compile(whole_nr + separator + '[dD][oO][sS]')  # dos(es)
re_str = re.compile(whole_nr + separator + '[sS][tT][rR]')  # str(ips)
re_sac = re.compile(whole_nr + separator + '[sS][aA][cC]')  # sac(hets)
re_unit = re.compile(whole_nr + separator + '[uU][nN][iI][tT]')  # unit(s)
re_whole = re.compile('^\s*' + whole_nr + '\s*$')  # whole number without unit

valid_quantity_patterns = [re_tab, re_cap, re_dos, re_str, re_sac, re_unit, re_whole]


def valid_quantity_for_days_estimate(raw_quantity: str,
                                     regex_list: Optional[List[re.Pattern]] = None)\
        -> Union[str, None]:
    """
    Checks if a string contains a integer numeric quantity that is suitable to calculate the
    number of days a drug was taken; the string will be matched against a list of specifically
    built regular expressions. If a match is found, returns the matching substring.
    :param raw_quantity: string.
    :param regex_list: custom list of compiled regular expressions (optional)
    :return: matching substring or None.
    """

    if not regex_list:
        regex_list = valid_quantity_patterns

    if not is_null(raw_quantity):
        for pattern in regex_list:
            match = pattern.search(raw_quantity)
            if match:
                return match.group()
    return None


def extract_numeric_quantity(raw_quantity: str) -> Union[float, None]:
    """
    Extracts the first valid numerical occurrence from the provided string.
    :param raw_quantity: string.
    :return: extracted numeric value (float) or None.
    """
    if not is_null(raw_quantity):
        match = re_any.search(raw_quantity)
        if match:
            try:
                quantity = match.group()
                return float(quantity)
            except:
                 return None
    return None

if __name__ == '__main__':

    # TEST extract numeric quantity
    test_cases_ok = ['10', '10.25', '.10' ,'0.5', '00.00', 'a=10 ,b=25',
                     '80mg x 10 doses', ' 10 caps', '10.000 caps']
    test_cases_ko = [None, '', 'abc',  '10.', '10..25', '.10.25']
    print('# extract numeric quantity')
    print('OK cases')
    print('raw_quantity\t| match')
    for raw_quantity in test_cases_ok:
        print(raw_quantity, '\t|',  extract_numeric_quantity(raw_quantity) )
    print('KO cases')
    print('raw_quantity\t| match')
    for raw_quantity in test_cases_ko:
        print(raw_quantity, '\t|', extract_numeric_quantity(raw_quantity))

    # TEST valid match for number of days
    test_cases_ok = ['2 tablets', ' 20 TABS', '20.000', '80mg x 10 doses',
                     '15 x caps', '15 - caps', '20 dispersible  tabs', '  10    units']
    test_cases_ko = [None, '', 'abc', '20mg', '20 grams', '20.15 caps', '20.150',
                     '1.20 caps', '20. caps', '.20 caps',
                     '15 ! caps', '15x caps', '15 xcaps']
    print('# return valid match for number of days')
    print('OK cases')
    print('raw_quantity\t| match')
    for raw_quantity in test_cases_ok:
        print(raw_quantity, '\t|', valid_quantity_for_days_estimate(raw_quantity))
    print('KO cases')
    print('raw_quantity\t| match')
    for raw_quantity in test_cases_ko:
        print(raw_quantity, '\t|', valid_quantity_for_days_estimate(raw_quantity))
