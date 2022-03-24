# test IDs 1000-1100

# Test ICD10 code
declareTest(1000, 'Test ICD10 code')
add_baseline(eid = 1000)
add_hesin(eid = 1000, ins_index = 0, admidate = '01/04/2016')
add_hesin_diag(eid = 1000, ins_index = 0, diag_icd10 = 'J459', level = 1)
expect_condition_occurrence(person_id = 1000, condition_concept_id = 317009, condition_start_date = '2016-04-01', 
                            condition_type_concept_id = 32817, condition_source_concept_id = 45562456)


# Test ICD9 code
declareTest(1001, 'Test ICD9 code')
add_baseline(eid = 1001)
add_hesin(eid = 1001, ins_index = 1, admidate = '19/04/2018')
add_hesin_diag(eid = 1001, ins_index = 1, diag_icd9 = '070', diag_icd10 = '', level = 1)
expect_condition_occurrence(person_id = 1001, condition_concept_id = 4291005, condition_start_date = '2018-04-19', 
                            condition_status_concept_id = 32902, condition_source_concept_id = 44829748)


# Test ICD9 and ICD10 code
declareTest(1002, 'Test ICD9 and ICD10 code; map ICD10')
add_baseline(eid = 1002)
add_hesin(eid = 1002, ins_index = 2, admidate = '30/12/2019')
add_hesin_diag(eid = 1002, ins_index = 2, diag_icd9 = '540', diag_icd10 = 'M866', level = 2)
expect_condition_occurrence(person_id = 1002, condition_concept_id = 134735, condition_start_date = '2019-12-30',
                            condition_status_concept_id = 32908, condition_source_concept_id = 45596781)

# Test No concept found
declareTest(1003, 'No concept found')
add_baseline(eid = 1003)
add_hesin(eid = 1003, ins_index = 3, admidate = '01/05/2014')
add_hesin_diag(eid = 1003, ins_index = 3, diag_icd10 = 'ABCD', level = 3)
expect_condition_occurrence(person_id = 1003, condition_concept_id = 0, condition_start_date = '2014-05-01',
                            condition_status_concept_id = 32908, condition_source_concept_id = 0)

# Test Source id but no target ID
declareTest(1004, 'Test Source id but no target ID')
add_baseline(eid = 1004)
add_hesin(eid = 1004, ins_index = 4, admidate = '09/03/2012')
add_hesin_diag(eid = 1004, ins_index = 4, diag_icd10 = '45532996')
expect_condition_occurrence(person_id = 1004, condition_concept_id = 0, condition_start_date = '2012-03-09', 
                            condition_type_concept_id = 32817, condition_source_concept_id = 45532996)


# Test if code has more > 1 code
declareTest(1005, 'Test if code has more > 1 target concept')
add_baseline(eid = 1005)
add_hesin(eid = 1005, ins_index = 5, admidate = '25/08/2017')
add_hesin_diag(eid = 1005, ins_index = 5, diag_icd10 = 'Y831')
expect_condition_occurrence(person_id = 1005, condition_concept_id = 4320824, condition_start_date = '2017-08-25',
                            condition_type_concept_id = 32817, condition_source_concept_id = 45547251)
expect_condition_occurrence(person_id = 1005, condition_concept_id = 434547, condition_start_date = '2017-08-25',
                            condition_type_concept_id = 32817, condition_source_concept_id = 45547251)

declareTest(1006, 'HES diagnosis with visit')
add_baseline(eid = 1006)
add_hesin(eid = 1006, ins_index = 0, admidate = '18/12/2020')
add_hesin_diag(eid = 1006, ins_index = 0, diag_icd10 = 'I10')
expect_visit_occurrence(person_id = 1006, visit_start_date = '2020-12-18')
expect_condition_occurrence(person_id = 1006, condition_start_date = '2020-12-18',
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1006, visit_start_date = '2020-12-18'))

declareTest(1007, 'HES diag visit_detail_id')
add_baseline(eid = 1007)
add_hesin(eid = 1007, ins_index = 0, epistart = '19/12/2020', admidate = '19/12/2020')
add_hesin_diag(eid = 1007, ins_index = 0, diag_icd10 = 'I10')
expect_visit_detail(person_id = 1007, visit_detail_start_date = '2020-12-19')
expect_condition_occurrence(person_id = 1007, condition_start_date = '2020-12-19',
                            visit_detail_id = lookup_visit_detail('visit_detail_id', person_id = 1007, visit_detail_start_date = '2020-12-19'))

declareTest(1008, 'ICD code exceptions: ICD10 code starting with W, X, Y map to one letter and two numbers')
add_baseline(eid = 1008)
add_hesin(eid = 1008, ins_index = 1, admidate = '11/02/2021')
add_hesin_diag(eid = 1008, ins_index = 1, diag_icd10 = 'W316')
expect_condition_occurrence(person_id = 1008, condition_start_date = '2021-02-11', condition_concept_id = 4035493, condition_source_concept_id = 45756284)


declareTest(1009, 'ICD code exceptions: ICD9 4 or 5 number codes map to the 3 first numbers.')
add_baseline(eid = 1009)
add_hesin(eid = 1009, ins_index = 2, admidate = '10/02/2021')
add_hesin_diag(eid = 1009, ins_index = 2, diag_icd9 = '2179', diag_icd10 = '')
expect_condition_occurrence(person_id = 1009, condition_start_date = '2021-02-10', condition_concept_id = 72576, condition_source_concept_id = 44835731)


declareTest(1010, 'ICD code exceptions: E chapters map to format EXXX.X')
add_baseline(eid = 1010)
add_hesin(eid = 1010, ins_index = 3, admidate = '09/02/2021')
add_hesin_diag(eid = 1010, ins_index = 3, diag_icd9 = 'E8429', diag_icd10 = '')
expect_condition_occurrence(person_id = 1010, condition_start_date = '2021-02-09', condition_concept_id = 434542, condition_source_concept_id = 44820303)
expect_condition_occurrence(person_id = 1010, condition_start_date = '2021-02-09', condition_concept_id = 440931, condition_source_concept_id = 44820303)

declareTest(1011, 'ICD code exceptions: V chapters map to format VXX.X')
add_baseline(eid = 1011)
add_hesin(eid = 1011, ins_index = 4, admidate = '08/02/2021')
add_hesin_diag(eid = 1011, ins_index = 4, diag_icd9 = 'V6601', diag_icd10 = '')
expect_condition_occurrence(person_id = 1011, condition_start_date = '2021-02-08', condition_concept_id = 4083043, condition_source_concept_id = 44834330)


declareTest(1012, 'ICD code exceptions: V chapters map to format VXX.X')
add_baseline(eid = 1012)
add_hesin(eid = 1012, ins_index = 1, admidate = '07/02/2021')
add_hesin_diag(eid = 1012, ins_index = 1, diag_icd9 = '', diag_icd10 = 'E831')
expect_condition_occurrence(person_id = 1012, condition_start_date = '2021-02-07', condition_concept_id = 434614, condition_source_concept_id = 45552418)

declareTest(1013, 'ICD code exceptions: ICD10 > 3')
add_baseline(eid = 1013)
add_hesin(eid = 1013, ins_index = 1, admidate = '06/02/2021')
add_hesin_diag(eid = 1013, ins_index = 1, diag_icd9 = '', diag_icd10 = 'M7702')
expect_condition_occurrence(person_id = 1013, condition_start_date = '2021-02-06', condition_concept_id = 80187, condition_source_concept_id = 45557989)

declareTest(1014, 'ICD code exceptions: A few specific exceptions who need a refactoring to XXX.X')
add_baseline(eid = 1014)
add_hesin(eid = 1014, ins_index = 1, admidate = '05/02/2021')
add_hesin_diag(eid = 1014, ins_index = 1, diag_icd9 = '72744', diag_icd10 = '')
expect_condition_occurrence(person_id = 1014, condition_start_date = '2021-02-05', condition_concept_id = 4209224, condition_source_concept_id = 44824525)
expect_condition_occurrence(person_id = 1014, condition_start_date = '2021-02-05', condition_concept_id = 4116964, condition_source_concept_id = 44824525)

declareTest(1015, 'ICD code exceptions: A few specific exceptions who need a refactoring to XXX.X')
add_baseline(eid = 1015)
add_hesin(eid = 1015, ins_index = 1, admidate = '04/02/2021')
add_hesin_diag(eid = 1015, ins_index = 1, diag_icd9 = '73346', diag_icd10 = '')
expect_condition_occurrence(person_id = 1015, condition_start_date = '2021-02-04', condition_concept_id = 77650, condition_source_concept_id = 44830364)

# Test small ICD10 code with V
declareTest(1016, 'Test ICD10 code')
add_baseline(eid = 1016)
add_hesin(eid = 1016, ins_index = 1, admidate = '03/02/2021')
add_hesin_diag(eid = 1016, ins_index = 1, diag_icd10 = 'V12')
expect_condition_occurrence(person_id = 1016, condition_start_date = '2021-02-03', condition_concept_id = 433099, condition_source_concept_id = 45756179)

declareTest(1017, 'ICD code exceptions: ICD10 codes with X instead of a decimal')
add_baseline(eid = 1017)
add_hesin(eid = 1017, ins_index = 1, admidate = '14/04/2021')
add_hesin_diag(eid = 1017, ins_index = 1, diag_icd10 = 'M45X4')
expect_condition_occurrence(person_id = 1017, condition_start_date = '2021-04-14', condition_concept_id = 437082)

declareTest(1018, 'ICD code expections: E88799 maps to E887')
add_baseline(eid = 1018)
add_hesin(eid = 1018, ins_index = 1, admidate = '22/03/2021')
add_hesin_diag(eid = 1018, ins_index = 1, diag_icd9 = 'E88799', diag_icd10 = '')
expect_condition_occurrence(person_id = 1018, condition_start_date = '2021-03-22', condition_concept_id = 75053, condition_source_concept_id = 44835350)
