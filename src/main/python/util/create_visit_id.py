# Copyright 2021 The Hyve
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

from datetime import datetime


BASELINE_PREFIX = '1'
COVID_PREFIX = '2'
HES_PREFIX = '3'
GP_PREFIX = '4'


def create_baseline_visit_occurrence_id(eid: str, instance: str):
    return create_visit_occurrence_id(BASELINE_PREFIX, eid, instance)


def create_covid_visit_occurrence_id(eid: str, date: datetime) -> str:
    return create_visit_occurrence_id(COVID_PREFIX, eid, date.strftime('%Y%m%d'))


def create_hes_visit_occurrence_id(eid: str, spell_index: str) -> str:
    return create_visit_occurrence_id(HES_PREFIX, eid, spell_index)


def create_gp_visit_occurrence_id(eid: str, date: datetime) -> str:
    return create_visit_occurrence_id(GP_PREFIX, eid, date.strftime('%Y%m%d'))


def create_visit_occurrence_id(source_prefix: str, eid: str, index: str) -> str:
    return f'{source_prefix}{eid:>07}{index:>08}'


def create_hes_visit_detail_id(eid: str, ins_index: str) -> str:
    return f'{eid:>07}{ins_index:>04}'


if __name__ == '__main__':
    print(create_baseline_visit_occurrence_id('1234567', '2'))
    print(create_covid_visit_occurrence_id('1234567'))
    print(create_hes_visit_occurrence_id('1234567', '123'))
    print(create_gp_visit_occurrence_id('1234567', datetime(2004, 1, 1)))

    print(create_hes_visit_detail_id('1234567', '1234'))

    print(create_baseline_visit_occurrence_id('123456789', '123456789'))
    print(create_gp_visit_occurrence_id(1234567, datetime(2020, 1, 31)))
