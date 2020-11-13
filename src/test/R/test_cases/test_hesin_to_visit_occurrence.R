# test IDs 1100-1199

declareTest(1100, 'Test emergency admission HES/2D')
add_baseline(eid = 1100)
add_hesin(eid = 1100, dsource = 'HES',
          admidate = '13/01/1997', admimeth = '2D', admisorc = '',
          disdate = '30/03/1997', disdest = '')
expect_visit_occurrence(person_id = 1100, visit_start_date = '1997/01/13', visit_end_date = '1997/03/30',
                        visit_concept_id = 9203, visit_source_value = 'record origin:HES/admission method:2D',
                        visit_type_concept_id = 44818517, discharge_to_concept_id = 0)

declareTest(1101, 'Test admission source Hospice SMR/62')
add_baseline(eid = 1101)
add_hesin(eid = 1101, dsource = 'SMR',
          admidate = '28/02/2001', admimeth = '', admisorc = '62',
          disdate = '01/11/2001', disdest = '')
expect_visit_occurrence(person_id = 1101, visit_start_date = '2001/02/28', visit_end_date = '2001/11/01', visit_concept_id = 0, admitting_source_concept_id = 8546,
                        admitting_source_value = 'record origin:SMR/admission source:62')

declareTest(1102, 'Test discharged to special hospital PEDW/49')
add_baseline(eid = 1102)
add_hesin(eid = 1102, dsource = 'PEDW',
          admidate = '03/09/2007', admimeth = '', admisorc = '',
          disdest = '49', disdate = '08/09/2007')
expect_visit_occurrence(person_id = 1102, visit_start_date = '2007/09/03', visit_end_date = '2007/09/08',
                        visit_concept_id = 0, discharge_to_concept_id = 38004287,
                        discharge_to_source_value = 'record origin:PEDW/discharge destination:49')

declareTest(1103, 'Test admission date missing')
add_baseline(eid = 1103)
add_hesin(eid = 1103, dsource = 'HES',
          admidate = '', admimeth = '11', admisorc = '54',
          disdate = '06/12/1991', disdest = '87')
expect_visit_occurrence(person_id = 1103, visit_start_date = '1970/01/01', visit_end_date = '1991/12/06',
                        visit_concept_id = 9201, admitting_source_concept_id = 581476,
                        discharge_to_concept_id = 38004515)
