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

# !/usr/bin/env python3

class MappingTarget:

    def __init__(self):
        self.concept_id = None
        self.value_as_concept_id = None
        self.value_as_number = None
        self.unit_concept_id = None
        self.source_value = None
        self.value_source_value = None

        self.variable_comment = None
        self.value_comment = None

    def __str__(self):
        return f'{self.source_value}-{self.value_source_value} => ' \
               f'concept_id: {self.concept_id}, ' \
               f'value_as_concept_id: {self.value_as_concept_id}, ' \
               f'value_as_number: {self.value_as_number}, ' \
               f'unit_concept_id: {self.unit_concept_id}, ' \
               f'source_value: {self.source_value}, ' \
               f'value_source_value: {self.value_source_value}, ' \
               f'variable_comment: {self.variable_comment}, ' \
               f'value_comment: {self.value_comment}'

