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

import csv
from typing import Dict, Optional

from src.main.python.util.general_functions import is_null


GP_CLINICAL_MAPPING_FOLDER = 'resources/gp_clinical_field_mapping/'

# load dictionary of special Read v2 dot code mappings (i.e. alternative to adding 00)
with open(GP_CLINICAL_MAPPING_FOLDER + 'read2_alternative_dot_code_mappings.csv') as f:
    next(f)  # Skip provenance info
    next(f)  # Skip the header
    reader = csv.reader(f)
    mapping_dict = dict(row[1:] for row in reader if row)  # skip 1st column


def extend_read_code(read_code: str, mapping_dict: Optional[Dict[str,str]] = None) -> str:
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


if __name__ == '__main__':
    print('# extend_read_code() tests')
    mapping_dict = {'ABC.' : 'ABC.123'}
    print(extend_read_code(None))
    print(extend_read_code('ABC'))
    print(extend_read_code('ABC.'))
