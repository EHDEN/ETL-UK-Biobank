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


def is_null(value) -> bool:
    if pd.isnull(value) or not value:  # '0' string is a valid code, won't be filtered by this
        return True
    else:
        return False


if __name__ == '__main__':
    import numpy as np
    print('# is_null() tests')
    print(is_null(None))
    print(is_null(np.nan))
    print(is_null(''))
    print(is_null(0))
    print(is_null(0.0))
    print(is_null('Hello'))
