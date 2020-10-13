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
from enum import Enum
from datetime import datetime
from src.main.python.field_mapper.util.type_conversion import to_int


class MappingStatus(Enum):
    UNCHECKED = 1
    APPROVED = 2
    IGNORED = 3
    FLAGGED = 4


class MappingType(Enum):
    EVENT = 1
    VALUE = 2
    UNIT = 3


class UsagiRow:

    def __init__(self, row):
        self.field_id: str = row['sourceCode'].strip()
        self.value_code: str = row['sourceValueCode'].strip()
        self.target: TargetMapping = TargetMapping(row)
        self.status: MappingStatus = MappingStatus[row['mappingStatus']]
        self.comment: str = row['comment']


class TargetMapping:

    def __init__(self, row):
        self.concept_id: int = int(row['conceptId'])
        self.created_by: str = row['createdBy']
        self.created_on: datetime = datetime.fromtimestamp(to_int(row['createdOn'])/1000)
        self.type: MappingType = MappingType[row['mappingType']]
        self.status_set_by: str = row['statusSetBy']
        self.status_set_on: datetime = datetime.fromtimestamp(to_int(row['statusSetOn'])/1000)
