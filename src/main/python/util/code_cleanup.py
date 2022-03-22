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
import re
from typing import Dict, Optional

from src.main.python.util.general_functions import is_null


def add_dot_to_opcsx_code(opcs_code: str) -> str:
    if not is_null(opcs_code) and len(opcs_code) > 3 and not '.' in opcs_code:
        return opcs_code[:3] + '.' + opcs_code[3:]
    return opcs_code


def refactor_icdx_code(icd_code: str) -> str:
    # Skip empty values
    if not is_null(icd_code):
        # If code has 3 or less characters, return directly
        if len(icd_code) <= 3:
            return icd_code
        # E chapters map to format EXXX
        elif icd_code in ['E88799', 'E8879', 'E9669', 'E9569', 'E91899', 'E9189', 'E88299', 'E8829', 'E9159',
                          'E9699', 'E9169', 'E91699']:
            return icd_code[:4]
        # A few specific exceptions who need a refactoring to XXX.X
        elif icd_code in ['2331', 'Y831', '72744', '72747', '75250', '72894', '73346', '75761', '75768',
                          '49399', '25009', '59979', '38019', '62609', '72959', '79993', '71409']:
            return icd_code[:3] + '.' + icd_code[3:4]
        # Keep only the first three characters for ICD10 codes starting with W, X or Y.
        # ICD9CM 4 or 5 number codes map to the 3 first numbers.
        elif icd_code[0] in ['W', 'X', 'Y'] or (re.match(r'^([\d]+)$', icd_code) and len(icd_code) < 6):
            return icd_code[:3]
        # E chapters map to format EXXX.X
        elif icd_code[0] == 'E' and len(icd_code) > 4:
            return icd_code[:4] + '.' + icd_code[4]
        # V chapters map to format VXX.X
        elif icd_code[0] == 'V':
            return icd_code[:3] + '.' + icd_code[3]
        # Keep only the first three characters for ICD10 codes with X instead of a decimal
        elif icd_code[3] == 'X':
            return icd_code[:3]
        # Specific exceptions who need refactoring to XXX
        elif icd_code in ['G475', 'E856', 'M064', 'Z916', 'Z917', 'S524', 'S522']:
            return icd_code[:3]
        # General rule for remaining ICD codes is map to format XXX.X
        elif (not '.' in icd_code) and icd_code != '45532996':
            return icd_code[:3] + '.' + icd_code[3:4]
        else:
            return icd_code


def extend_read_code(read_code: str, mapping_dict: Optional[Dict[str, str]] = None) -> str:
    """
    Given a Read code, if the code ends with a dot, try extending it
    using the provided (optional) mapping dictionary, otherwise append
     "00" to it.
    :param read_code: Read v2 code
    :param mapping_dict: an (optional) dictionary specifying the
    preferred extension for codes ending with a dot (e.g. alternative
    to the default "00")
    :return: the (extended) Read v2 code
    """
    if not is_null(read_code) and read_code[-1] == '.':
        if mapping_dict:
            return mapping_dict.get(read_code, read_code + '00')
        else:
            return read_code + '00'
    else:
        return read_code


def icd_code_map(dict_name: dict, val: str):
    out = 'NULL'
    for key, value in dict_name.items():
        if val in value:
            out = key
    return out


if __name__ == '__main__':
    print('# extend_read_code() tests')
    mapping_dict = {'ABC.' : 'ABC.123'}
    print(extend_read_code(None))
    print(extend_read_code('ABC'))
    print(extend_read_code('ABC.'))
    print(extend_read_code('ABC.'), mapping_dict)
    print('# add_dot_to_icdx_code() tests')
