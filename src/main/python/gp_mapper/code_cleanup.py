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
import pandas as pd

GP_CLINICAL_MAPPING_FOLDER = 'resources/gp_clinical_field_mapping/'

# load dictionary of special Read v2 dot code mappings (i.e. alternative to adding 00)
with open(GP_CLINICAL_MAPPING_FOLDER + 'read2_alternative_dot_code_mappings.csv') as f:
    next(f)  # Skip provenance info
    next(f)  # Skip the header
    reader = csv.reader(f)
    mapping_dict = dict(row[1:] for row in reader if row)  # skip 1st column


def is_null(value) -> bool:
    if pd.isnull(value) or not value:  # '0' string is a valid code, won't be filtered by this
        return True
    else:
        return False


def extend_read_code(read_code: str) -> str:
    if not is_null(read_code) and read_code[-1] == '.':
        if mapping_dict:
            return mapping_dict.get(read_code, read_code + '00')
        else:
            return read_code + '00'
    else:
        return read_code


if __name__ == '__main__':
    import numpy as np
    print('# is_null() tests')
    print(is_null(None))
    print(is_null(np.nan))
    print(is_null(''))
    print(is_null(0))
    print(is_null(0.0))
    print(is_null('Hello'))
    print('# extend_read_code() tests')
    mapping_dict = {'ABC.' : 'ABC.123'}
    print(extend_read_code(None))
    print(extend_read_code('ABC'))
    print(extend_read_code('ABC.'))
