# IDs 1800-1899

declareTest(1800, 'Episode startdate')
add_baseline(eid = 1800)
add_hesin(eid = 1800, epistart = '12/11/2010', ins_index = 1)
expect_visit_detail(person_id = 1800, visit_detail_start_date = '2010/11/12')

declareTest(1801, 'Missing episode startdate')
add_baseline(eid = 1801)
add_hesin(eid = 1801, epistart = '', ins_index = 2)
expect_visit_detail(person_id = 1801, visit_detail_start_date = '1970/01/01')

declareTest(1802, 'Episode start/end date')
add_baseline(eid = 1802)
add_hesin(eid = 1802, epistart = '09/12/2017', epiend = '19/12/2017', ins_index = 3)
expect_visit_detail(person_id = 1802, visit_detail_start_date = '2017/12/09',
                    visit_detail_end_date = '2017/12/19')

declareTest(1803, 'Missing episode enddate')
add_baseline(eid = 1803)
add_hesin(eid = 1803, epistart = '09/12/2017', epiend = '', ins_index = 1)
expect_visit_detail(person_id = 1803, visit_detail_start_date = '2017/12/09',
                    visit_detail_end_date = '2017/12/09')

declareTest(1804, 'Create two episodes for one person (only start dates)')
add_baseline(eid = 1804)
add_hesin(eid = 1804, epistart = '13/01/1997', ins_index = 0)
add_hesin(eid = 1804, epistart = '19/01/1997', ins_index = 1)
expect_count_visit_detail(2, person_id = 1804)
expect_visit_detail(person_id = 1804, visit_detail_start_date = '1997/01/13')
expect_visit_detail(person_id = 1804, visit_detail_start_date = '1997/01/19')

declareTest(1805, 'Create two episodes in one spell for a person (only start dates)')
add_baseline(eid = 1805)
add_hesin(eid = 1805, epistart = '22/08/1999', admidate = '21/08/1999', ins_index = 0, spell_index = 1)
add_hesin(eid = 1805, epistart = '23/08/1999', admidate = '21/08/1999', ins_index = 1, spell_index = 1)
expect_count_visit_occurrence(1, person_id = 1805, visit_start_date = '1999/08/21')
expect_count_visit_detail(2, person_id = 1805)
expect_visit_detail(person_id = 1805, visit_detail_start_date = '1999/08/22',
                    visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1805, visit_start_date = '1999/08/21'))
expect_visit_detail(person_id = 1805, visit_detail_start_date = '1999/08/23',
                    visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1805, visit_start_date = '1999/08/21'))

declareTest(1806, 'Create an episode - spell missing admission date')
add_baseline(eid = 1806)
add_hesin(eid = 1806, epistart = '22/08/1999', admidate = '', ins_index = 0, spell_index = 1)
expect_count_visit_occurrence(1, person_id = 1806, visit_start_date = '1970/01/01')
expect_visit_detail(person_id = 1806, visit_detail_start_date = '1999/08/22',
                    visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1806, visit_start_date = '1970/01/01'))

declareTest(1807, 'Admition method')
add_baseline(eid = 1807)
add_hesin(eid = 1807, epistart = '22/08/1999', admimeth = '2D', dsource = 'HES')
expect_visit_detail(person_id = 1807, visit_detail_concept_id = 9203,
                    visit_detail_source_value = 'record origin:HES/admission method:2D')

declareTest(1808, 'Admition source')
add_baseline(eid = 1808)
add_hesin(eid = 1808, epistart = '22/08/1999', admisorc = '54', dsource = 'SMR')
expect_visit_detail(person_id = 1808, admitting_source_concept_id = '8650',
                    admitting_source_value = 'record origin:SMR/admission source:54')

declareTest(1809, 'Discharge destination')
add_baseline(eid = 1809)
add_hesin(eid = 1809, disdest = '49', dsource = 'PEDW')
expect_visit_detail(person_id = 1809, discharge_to_concept_id = 38004287,
                    discharge_to_source_value = 'record origin:PEDW/discharge destination:49')

declareTest(1810, 'Type concept id')
add_baseline(eid = 1810)
add_hesin(eid = 1810, epistart = '22/08/1999', admimeth = '12')
expect_visit_detail(person_id = 1810, visit_detail_concept_id = 9201,
                    visit_detail_type_concept_id = 32827)