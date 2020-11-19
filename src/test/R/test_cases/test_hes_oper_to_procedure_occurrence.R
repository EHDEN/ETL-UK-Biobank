# test IDs 1500-1599

# Test ICD10 code
declareTest(1500, 'Test OPCS4 code')
add_baseline(eid = 1500)
add_hesin(eid = 1500, ins_index = 0, admidate = '01/04/2016')
add_hesin_oper(eid = 1500, ins_index = 0, oper4 = 'X998', level = 1)
expect_procedure_occurrence(person_id = 1500, condition_concept_id = 44789899, procedure_date = '2016-04-01',
                            procedure_type_concept_id = 44786630, condition_source_concept_id = 46233445)


# Test ICD9 code
declareTest(1501, 'Test OPCS3 code')
add_baseline(eid = 1501)
add_hesin(eid = 1501, ins_index = 1, admidate = '19/04/2018')
add_hesin_oper(eid = 1501, ins_index = 1, oper3 = '704', oper4 = '', level = 1)
expect_procedure_occurrence(person_id = 1501, condition_concept_id = 4074865, procedure_date = '2018-04-19',
                            procedure_type_concept_id = 44786630)


# Test ICD9 and ICD10 code
declareTest(1502, 'Test OPCS3 and OPCS4 code; map OPCS4')
add_baseline(eid = 1502)
add_hesin(eid = 1502, ins_index = 2, admidate = '30/12/2019')
add_hesin_oper(eid = 1502, ins_index = 2, oper3 = '687', oper4 = 'Z942', level = 2)
expect_procedure_occurrence(person_id = 1502, procedure_concept_id = 44517227, procedure_date = '2019-12-30',
                            procedure_type_concept_id = 44786631, procedure_source_concept_id = 44517227)

# Test No concept found
declareTest(1503, 'No concept found')
add_baseline(eid = 1503)
add_hesin(eid = 1503, ins_index = 3, admidate = '01/05/2014')
add_hesin_oper(eid = 1503, ins_index = 3, oper4 = '', level = 2)
expect_procedure_occurrence(person_id = 1503, procedure_concept_id = 0, procedure_date = '2014-05-01',
                            procedure_type_concept_id = 44786631, procedure_source_concept_id = 0)

# Test Source id but no target ID
declareTest(1504, 'Test Source id but no target ID')
add_baseline(eid = 1504)
add_hesin(eid = 1504, ins_index = 4, admidate = '09/03/2012')
add_hesin_oper(eid = 1504, ins_index = 4, oper4 = '', level = 1)
expect_procedure_occurrence(person_id = 1504, procedure_concept_id = 0, procedure_start_date = '2012-03-09',
                            procedure_type_concept_id = 44786630, procedure_source_concept_id = 0)


# Test if code has more > 1 code
declareTest(1505, 'Test if code has more > 1 target concept')
add_baseline(eid = 1505)
add_hesin(eid = 1505, ins_index = 5, admidate = '25/08/2017')
add_hesin_oper(eid = 1505, ins_index = 5, oper4 = '', level = 1)
expect_procedure_occurrence(person_id = 1505, procedure_concept_id = , procedure_date = '2017-08-25',
                            procedure_type_concept_id = 44786630, procedure_source_concept_id = )
expect_procedure_occurrence(person_id = 1505, procedure_concept_id = 434547, procedure_date = '2017-08-25',
                            procedure_type_concept_id = 44786630, procedure_source_concept_id = )

declareTest(1506, 'HES diagnosis with visit')
add_baseline(eid = 1506)
add_hesin(eid = 1506, ins_index = 0, admidate = '18/12/2020')
add_hesin_oper(eid = 1506, ins_index = 0, oper4 = '')
expect_visit_occurrence(person_id = 1506, visit_start_date = '2020-12-18')
expect_procedure_occurrence(person_id = 1506, procedure_date = '2020-12-18',
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1006, visit_start_date = '2020-12-18'))
