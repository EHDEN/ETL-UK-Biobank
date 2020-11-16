# test IDs 1000-1100

# Test ICD10 code
declareTest(1000, 'Test ICD10 code')
add_baseline(eid = 1000)
add_hesin(eid = 1000, ins_index = 0, admidate = '01/04/2016')
add_hesin_diag(eid = 1000, ins_index = 0, diag_icd10 = 'J459', level = 1)
expect_condition_occurrence(person_id = 1000, condition_concept_id = 317009, condition_start_date = '2016-04-01', 
                            condition_type_concept_id = 44786627, condition_source_concept_id = 45562456)


# Test ICD9 code
declareTest(1001, 'Test ICD9 code')
add_baseline(eid = 1001)
add_hesin(eid = 1001, ins_index = 1, admidate = '19/04/2018')
add_hesin_diag(eid = 1001, ins_index = 1, diag_icd9 = '070', diag_icd10 = '', level = 1)
expect_condition_occurrence(person_id = 1001, condition_concept_id = 4291005, condition_start_date = '2018-04-19', 
                            condition_type_concept_id = 44786627, condition_source_concept_id = 44829748)


# Test ICD9 and ICD10 code
declareTest(1002, 'Test ICD9 and ICD10 code; map ICD10')
add_baseline(eid = 1002)
add_hesin(eid = 1002, ins_index = 2, admidate = '30/12/2019')
add_hesin_diag(eid = 1002, ins_index = 2, diag_icd9 = '540', diag_icd10 = 'M866', level = 2)
expect_condition_occurrence(person_id = 1002, condition_concept_id = 134735, condition_start_date = '2019-12-30',
                            condition_type_concept_id = 44786629, condition_source_concept_id = 45596781)

# Test No concept found
declareTest(1003, 'No concept found')
add_baseline(eid = 1003)
add_hesin(eid = 1003, ins_index = 3, admidate = '01/05/2014')
add_hesin_diag(eid = 1003, ins_index = 3, diag_icd10 = 'ABCD', level = 3)
expect_condition_occurrence(person_id = 1003, condition_concept_id = 0, condition_start_date = '2014-05-01', 
                            condition_type_concept_id = 44786629, condition_source_concept_id = 0)

# Test Source id but no target ID
declareTest(1004, 'Test Source id but no target ID')
add_baseline(eid = 1004)
add_hesin(eid = 1004, ins_index = 4, admidate = '09/03/2012')
add_hesin_diag(eid = 1004, ins_index = 4, diag_icd10 = '45532996', level = 1)
expect_condition_occurrence(person_id = 1004, condition_concept_id = 0, condition_start_date = '2012-03-09', 
                            condition_type_concept_id = 44786627, condition_source_concept_id = 0)


# Test if code has more > 1 code
declareTest(1005, 'Test if code has more > 1 code')
add_baseline(eid = 1005)
add_hesin(eid = 1005, ins_index = 5, admidate = '25/08/2017')
add_hesin_diag(eid = 1005, ins_index = 5, diag_icd10 = 'Y831', level = 1)
expect_condition_occurrence(person_id = 1005, condition_concept_id = 4320824, condition_start_date = '2017-08-25',
                            condition_type_concept_id = 44786627, condition_source_concept_id = 45547251)
expect_condition_occurrence(person_id = 1005, condition_concept_id = 434547, condition_start_date = '2017-08-25',
                            condition_type_concept_id = 44786627, condition_source_concept_id = 45547251)

