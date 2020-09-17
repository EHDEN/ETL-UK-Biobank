
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


class SourceData(object):
    """ Base object for reading source data file """

    def __init__(self, source_file_path, delimiter='\t'):
        self.delimiter = delimiter
        self.data_dicts = []  # list of dictionaries

        self.load(source_file_path)

    def __iter__(self):
        yield from self.data_dicts

    def load(self, source_file_path):
        with open(source_file_path) as f_in:
            self.data_dicts = [CaseInsensitiveDict(x) for x in csv.DictReader(f_in, delimiter=self.delimiter)]


class CaseInsensitiveDict(dict):
    """ Keys are all converted to lowercase.
    Note: assumes all given keys in lowercase are unique. Data will be lost otherwise. """

    def __init__(self, d=None):
        super().__init__()

        if d is None:
            return

        for key, value in d.items():
            self.__setitem__(key.lower(), value)

    def __getitem__(self, key):
        # if key not in self:  # Note: bit tricky; no warning if variable does not exist...
        #     return None
        return super().__getitem__(key.lower())

    def __setitem__(self, key, value):
        return super().__setitem__(key.lower(), value)

    def __contains__(self, key):
        return super().__contains__(key.lower())
