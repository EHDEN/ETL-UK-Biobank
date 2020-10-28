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
import logging
from collections import Counter
from dataclasses import dataclass
from typing import Optional, List

logger = logging.getLogger(__name__)


class Validator:
    def __init__(self):
        self.warnings: List[Validator.Warning] = []

    def add_warning(self, field_id, value, source, message):
        logger.warning(f'{source}: {field_id}{"|"+value if value else ""} => {message}')

        self.warnings.append(Validator.Warning(
            field_id=field_id,
            value=value,
            source=source,
            message=message
        ))

    def print_all(self):
        for warning in self.warnings:
            print(warning)

    def print_summary(self):
        print(f'In total {len(self.warnings)} warnings')
        for k, v in Counter([w.source for w in self.warnings]).items():
            print(f' > {k} contains {v} warnings')
            for k2, v2 in Counter([w.message for w in self.warnings if w.source == k]).items():
                print(f'    > "{k2}" - {v2} warnings')

    @dataclass
    class Warning:
        source: str
        field_id: str
        value: Optional[str]
        message: str


validator = Validator()
