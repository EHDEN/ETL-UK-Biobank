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
from typing import Optional, List, Tuple
from ..util.general_functions import is_null
from .read_code_cleanup import extend_read_code
import logging


logger = logging.getLogger(__name__)


class GpClinicalValueMapper:

    def __init__(self, mapping_dict):
        # load dataframe for special mapping logic (e.g. blood pressure)
        self.mapping_dict = mapping_dict
        self.mapping_logic_df = pd.read_csv(
            'resources/mapping_tables/gp_clinical_phenotype_logic.csv', skiprows=1, dtype='object')
        self.special_handling_codes = set(self.mapping_logic_df['source_read_code'])

    def lookup(self, row, read_col) -> List[Tuple[Optional[str], float]]:
        # for most rows only one of the two value fields will be provided,
        # for some though you need to process both, therefore this loop.
        # determine value_as_number and possibly alternative read_code
        result = []
        map_as_read_code = row[read_col]
        for value_col in ['value1', 'value2']:
            value = row[value_col]
            if is_null(value):
                if value_col == 'value1':  # if value1 is empty, skip to value2
                    continue
                elif is_null(row['value1']):  # if both value1&2 empty, create record with no value
                    value_as_number = None
                else:  # value2 is empty but value1 is not, so this row has already been processed and can be skipped
                    continue
            else:
                try:
                    value_as_number = float(value)
                except Exception:
                    value_as_number = None

            # apply special mapping logic to specific combinations of data provider, read code,
            # and value column (e.g. blood pressure)
            source_code_extended = extend_read_code(row[read_col], mapping_dict=self.mapping_dict)
            if source_code_extended in self.special_handling_codes:
                filter1 = self.mapping_logic_df['read_col'] == read_col
                filter2 = self.mapping_logic_df['value_col'] == value_col
                filter3 = self.mapping_logic_df['data_provider'] == row['data_provider']
                filter4 = self.mapping_logic_df['source_read_code'] == source_code_extended
                filtered_df = self.mapping_logic_df[filter1 & filter2 & filter3 & filter4]
                n_results = len(filtered_df.index)
                if n_results == 1:  # either not found, or 1 result (no multiple mappings in source file)
                    map_as_read_code = filtered_df['map_as_read_code'].iloc[0]

            result.append((map_as_read_code, value_as_number))
        return result
