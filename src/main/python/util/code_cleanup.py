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

import pandas as pd
from numpy import nan
from typing import Union


def check_if_valid_code(code: str):
    if pd.isnull(code) or not code:  # '0' string is a valid code, won't be filtered by this
        return False
    else:
        return True

def extend_read_code(read_code: str):
    if read_code[-1] == '.':
        return read_code + '00'
    else:
        return read_code
