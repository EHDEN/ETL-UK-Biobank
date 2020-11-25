import re
from typing import Union
from src.main.python.util import is_null

# base patterns
whole_nr = '(\d+(\.0+)?)'        # e.g. 20 or 20.0 (any nr of zeroes after .)
separator = '(\s+|(\s+(-|x)\s+))'   # e.g. space(s) or space(s) + -|x + space(s)
additions = '(?:dispersible\s+)?'   # e.g. dispersible tablets
# compiled patterns
re_tab = re.compile(whole_nr + separator + additions + '[tT][aA][bB]')
re_cap = re.compile(whole_nr + separator + '[cC][aA][pP]')  # cap(sules)
re_dos = re.compile(whole_nr + separator + '[dD][oO][sS]')  # dos(es)
re_str = re.compile(whole_nr + separator + '[sS][tT][rR]')  # str(ips)
re_sac = re.compile(whole_nr + separator + '[sS][aA][cC]')  # sac(hets)
re_unit = re.compile(whole_nr + separator + '[uU][nN][iI][tT]')  # unit(s)
re_whole = re.compile('^\s*' + whole_nr + '\s*$')  # whole number without unit
re_any = re.compile('\d+(\.\d+)?')  # e.g. 20 or 20.5 (any nr of cyphers after .)

valid_quantity_patterns = [re_tab, re_cap, re_dos, re_str, re_sac, re_unit, re_whole]

def valid_quantity_for_days_estimate(raw_quantity: str) -> Union[str, None]:
    if not is_null(raw_quantity):
        for pattern in valid_quantity_patterns:
            match = pattern.search(raw_quantity)
            if match:
                return match.group()
    return None

def extract_numeric_quantity(raw_quantity: str) -> Union[float, None]:
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

    test_cases = [None, '', 'abc', '10', '10.25', '10..25', '10.', '0.5', '00.00', 'a=10,b=25']
    print('# extract numeric quantity')
    print('result\t| original')
    for raw_quantity in test_cases:
        print(extract_numeric_quantity(raw_quantity), '\t|', raw_quantity )

    test_cases = [None, '', 'abc', '20mg', '20 grams', '2 tablets', ' 20 TABS', '20.15 caps',
                  '20.000', '20.150']
    print('# return valid match for number of days')
    print('result\t| original')
    for raw_quantity in test_cases:
        print(valid_quantity_for_end_date_estimate(raw_quantity), '\t|', raw_quantity)

