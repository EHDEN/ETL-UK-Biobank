# IDs 1800-1899

declareTest(1800, 'One spell two episodes - emergency admission HES/2D')
add_baseline(eid = 1800)
add_hesin(eid = 1800, dsource = 'HES', ins_index = 0, spell_index = 1,
          epistart = '13/01/1997', epiend = '30/03/1997', admidate = '13/01/1997', disdate = '05/04/1997',
          admimeth = '2D', admisorc = '', disdest = '')
add_hesin(eid = 1800, dsource = 'HES', ins_index = 1, spell_index = 1,
          epistart = '19/01/1997', epiend = '05/04/1997', admidate = '13/01/1997', disdate = '05/04/1997',
          admimeth = '2D', admisorc = '', disdest = '')
expect_count_visit_occurrence(1, person_id = 1800, visit_start_date = '1997/01/13', visit_end_date = '1997/04/')
expect_visit_detail(person_id = 1800, visit_detail_start_date = '1997/01/13', visit_detail_end_date = '1997/03/30',
                    visit_detail_concept_id = 9203, visit_detail_source_value = 'record origin:HES/admission method:2D',
                    visit_detail_type_concept_id = 32827, discharge_to_concept_id = 0,
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1800, visit_start_date = '1997/01/13'))
expect_visit_detail(person_id = 1800, visit_detail_start_date = '1997/01/19', visit_detail_end_date = '1997/04/05',
                    visit_detail_concept_id = 9203, visit_detail_source_value = 'record origin:HES/admission method:2D',
                    visit_detail_type_concept_id = 32827, discharge_to_concept_id = 0,
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1800, visit_start_date = '1997/01/13'))

declareTest(1801, 'admission date missing')
add_baseline(eid = 1801)
add_hesin(eid = 1801, dsource = 'HES', epistart = '', admidate = '12/11/2010', ins_index = 1, spell_index = 6, admimeth = '11', admisorc = '39',
          disdate = '06/12/1991', disdest = '87')
expect_visit_occurrence(person_id = 1801, visit_start_date = '2010/11/12', visit_end_date = '1991/12/06')
expect_visit_detail(person_id = 1801, visit_detail_start_date = '1970/01/01', visit_detail_end_date = '1991/12/06',
                    visit_detail_concept_id = 9201, admitting_source_concept_id = 38003619, discharge_to_concept_id = 38004515,
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1801, visit_start_date = '2010/11/12'))

declareTest(1802, 'discharge date missing')
add_baseline(eid = 1802)
add_hesin(eid = 1802, dsource = 'HES', epistart = '09/12/2017', admidate = '09/12/2017', ins_index = 1, spell_index = 6, admimeth = '11', admisorc = '39',
          epiend = '', disdest = '87')
expect_visit_occurrence(person_id = 1802, visit_start_date = '2017/12/09', visit_end_date = '2017/12/09')
expect_visit_detail(person_id = 1802, visit_detail_start_date = '2017/12/09', visit_detail_end_date = '2017/12/09',
                    visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1802, visit_start_date = '2017/12/09'))
