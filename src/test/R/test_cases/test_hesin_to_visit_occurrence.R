# IDs 1100-1199

declareTest(1100, 'emergency admission HES/2D')
add_baseline(eid = 1100)
add_hesin(eid = 1100, dsource = 'HES',
          admidate = '13/01/1997', admimeth = '2D', admisorc = '',
          disdate = '30/03/1997', disdest = '')
expect_visit_occurrence(person_id = 1100, visit_start_date = '1997/01/13', visit_end_date = '1997/03/30',
                        visit_concept_id = 9203, visit_source_value = 'record origin:HES/admission method:2D',
                        visit_type_concept_id = 44818517, discharge_to_concept_id = 0)

declareTest(1101, 'admission source Hospice SMR/62')
add_baseline(eid = 1101)
add_hesin(eid = 1101, dsource = 'SMR',
          admidate = '28/02/2001', admimeth = '', admisorc = '62',
          disdate = '01/11/2001', disdest = '')
expect_visit_occurrence(person_id = 1101, visit_start_date = '2001/02/28', visit_end_date = '2001/11/01', visit_concept_id = 0, admitting_source_concept_id = 8546,
                        admitting_source_value = 'record origin:SMR/admission source:62')

declareTest(1102, 'discharged to special hospital PEDW/49')
add_baseline(eid = 1102)
add_hesin(eid = 1102, dsource = 'PEDW',
          admidate = '03/09/2007', admimeth = '', admisorc = '',
          disdest = '49', disdate = '08/09/2007')
expect_visit_occurrence(person_id = 1102, visit_start_date = '2007/09/03', visit_end_date = '2007/09/08',
                        visit_concept_id = 0, discharge_to_concept_id = 38004287,
                        discharge_to_source_value = 'record origin:PEDW/discharge destination:49')

declareTest(1103, 'admission date missing')
add_baseline(eid = 1103)
add_hesin(eid = 1103, dsource = 'HES',
          admidate = '', admimeth = '11', admisorc = '54',
          disdate = '06/12/1991', disdest = '87')
expect_visit_occurrence(person_id = 1103, visit_start_date = '1970/01/01', visit_end_date = '1991/12/06',
                        visit_concept_id = 9201, admitting_source_concept_id = 581476,
                        discharge_to_concept_id = 38004515)

declareTest(1104, 'admission date and discharge date missing')
add_baseline(eid = 1104)
add_hesin(eid = 1104, admidate = '', disdate = '')
expect_visit_occurrence(person_id = 1104, visit_start_date = '1970/01/01', visit_end_date = '1970/01/01')

declareTest(1105, 'two episodes in one spell, min/max date')
add_baseline(eid = 1105)
add_hesin(eid = 1105, spell_index = '0', admidate = '01/01/2010', disdate = '01/02/2010')
add_hesin(eid = 1105, spell_index = '0', admidate = '01/02/2010', disdate = '01/03/2010')
expect_visit_occurrence(person_id = 1105, visit_start_date = '2010/01/01', visit_end_date = '2010/03/01')

declareTest(1106, 'two spells for one person results in two visits')
add_baseline(eid = 1106)
add_hesin(eid = 1106, spell_index = '0')
add_hesin(eid = 1106, spell_index = '1')
expect_count_visit_occurrence(2, person_id = 1106, visit_concept_id = 9201)

declareTest(1107, 'Multiple episodes in one spell, first admimeth')
add_baseline(eid = 1107)
add_hesin(eid = 1107, spell_index = '0', ins_index = '0', dsource = 'HES', admimeth = '2D')
add_hesin(eid = 1107, spell_index = '0', ins_index = '1', dsource = 'HES', admimeth = '84')
add_hesin(eid = 1107, spell_index = '0', ins_index = '2', dsource = 'HES', admimeth = '2A')
expect_visit_occurrence(person_id = 1107, visit_concept_id = 9203, visit_source_value = 'record origin:HES/admission method:2D')

declareTest(1108, 'Multiple episodes in one spell, take first admisorc')
add_baseline(eid = 1108)
add_hesin(eid = 1108, spell_index = '0', ins_index = '0', dsource = 'HES', admisorc = '85')
add_hesin(eid = 1108, spell_index = '0', ins_index = '1', dsource = 'HES', admisorc = '')
add_hesin(eid = 1108, spell_index = '0', ins_index = '2', dsource = 'HES', admisorc = '49')
expect_visit_occurrence(person_id = 1108, admitting_source_concept_id = 38004307, admitting_source_value = 'record origin:HES/admission source:85')

declareTest(1109, 'Multiple episodes in one spell, take last disdest')
add_baseline(eid = 1109)
add_hesin(eid = 1109, spell_index = '0', ins_index = '0', dsource = 'HES', disdest = '2D')
add_hesin(eid = 1109, spell_index = '0', ins_index = '1', dsource = 'HES', disdest = '9999')
add_hesin(eid = 1109, spell_index = '0', ins_index = '2', dsource = 'HES', disdest = '84')
expect_visit_occurrence(person_id = 1109, discharge_to_concept_id = 38004515, discharge_to_source_value = 'record origin:HES/discharge destination:84')

declareTest(1110, 'two episodes in one spell, min/max date 2')
add_baseline(eid = 1110)
add_hesin(eid = 1110, spell_index = '0', admidate = '30/06/2010', disdate = '30/07/2010')
add_hesin(eid = 1110, spell_index = '0', admidate = '01/08/2010', disdate = '03/08/2010')
expect_visit_occurrence(person_id = 1110, visit_start_date = '2010/06/30', visit_end_date = '2010/08/03')
