# test IDs 1500-1599

# Test OPCS4 code - standard
declareTest(1500, 'Test OPCS4 code - standard')
add_baseline(eid = 1500)
add_hesin(eid = 1500, ins_index = 0)
add_hesin_oper(eid = 1500, ins_index = 0, opdate = '01/04/2016', oper4 = 'Z942', level = 1)
expect_procedure_occurrence(person_id = 1500, procedure_concept_id = 44517227, procedure_date = '2016-04-01',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 44517227)


# Test OPCS4 code - non standard
declareTest(1501, 'Test OPCS4 code - non standard')
add_baseline(eid = 1501)
add_hesin(eid = 1501, ins_index = 0)
add_hesin_oper(eid = 1501, ins_index = 0, opdate = '10/09/2018', oper4 = 'G451', level = 1)
expect_procedure_occurrence(person_id = 1501, procedure_concept_id = 4071407, procedure_date = '2018-09-10',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 44509820)


# Test OPCS3 code
declareTest(1502, 'Test OPCS3 code')
add_baseline(eid = 1502)
add_hesin(eid = 1502, ins_index = 1)
add_hesin_oper(eid = 1502, ins_index = 1, opdate = '19/04/2018', oper3 = '704', oper4 = '', level = 1)
expect_procedure_occurrence(person_id = 1502, procedure_concept_id = 4074865, procedure_date = '2018-04-19',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 0)


# Test OPCS3 and OPCS4 code
declareTest(1503, 'Test OPCS3 and OPCS4 code; map OPCS4')
add_baseline(eid = 1503)
add_hesin(eid = 1503, ins_index = 2)
add_hesin_oper(eid = 1503, ins_index = 2, opdate = '30/12/2019', oper3 = '687', oper4 = 'X403', level = 2)
expect_procedure_occurrence(person_id = 1503, procedure_concept_id = 4120120, procedure_date = '2019-12-30',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 44515557)


# Test No concept found
declareTest(1504, 'No concept found')
add_baseline(eid = 1504)
add_hesin(eid = 1504, ins_index = 3)
add_hesin_oper(eid = 1504, ins_index = 3, opdate = '01/05/2014', oper4 = 'X998', level = 2)
expect_procedure_occurrence(person_id = 1504, procedure_concept_id = 0, procedure_date = '2014-05-01',
                            procedure_type_concept_id = 32817, procedure_source_value = 'X998')


# Test if code has more > 1 code OPCS4
declareTest(1505, 'Test if OPCS4 code has more > 1 target concept')
add_baseline(eid = 1505)
add_hesin(eid = 1505, ins_index = 5)
add_hesin_oper(eid = 1505, ins_index = 5, opdate = '31/01/2013', oper4 = 'E851', level = 1)
expect_procedure_occurrence(person_id = 1505, procedure_concept_id = 19025274, procedure_date = '2013-01-31',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 44509477)
expect_procedure_occurrence(person_id = 1505, procedure_concept_id = 44790095, procedure_date = '2013-01-31',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 44509477)


# Test if code has more > 1 code OPCS3
declareTest(1506, 'Test if OPCS3 code has more > 1 target concept')
add_baseline(eid = 1506)
add_hesin(eid = 1506, ins_index = 5)
add_hesin_oper(eid = 1506, ins_index = 5, opdate = '25/08/2017', oper3 = '4011', oper4 = '', level = 1)
expect_procedure_occurrence(person_id = 1506, procedure_concept_id = 4073667, procedure_date = '2017-08-25',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 0)
expect_procedure_occurrence(person_id = 1506, procedure_concept_id = 2109458, procedure_date = '2017-08-25',
                            procedure_type_concept_id = 32817, procedure_source_concept_id = 0)

declareTest(1507, 'HES diagnosis with visit')
add_baseline(eid = 1507)
add_hesin(eid = 1507, ins_index = 0, admidate = '11/12/2020')
add_hesin_oper(eid = 1507, ins_index = 0, opdate = '18/12/2020', oper4 = 'Z857')
expect_visit_occurrence(person_id = 1507, visit_start_date = '2020-12-11')
expect_procedure_occurrence(person_id = 1507, procedure_date = '2020-12-18',
                            visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1507, visit_start_date = '2020-12-11'))

declareTest(1508, 'HES diagnosis with visit detail')
add_baseline(eid = 1508)
add_hesin(eid = 1508, ins_index = 0, admidate = '19/12/2020')
add_hesin_oper(eid = 1508, ins_index = 0, opdate = '19/12/2020', oper4 = 'Z857')
expect_visit_detail(person_id = 1508, visit_detail_start_date = '2020-12-19')
expect_procedure_occurrence(person_id = 1508, procedure_date = '2020-12-19',
                            visit_detail_id = lookup_visit_detail('visit_detail_id', person_id = 1508, visit_detail_start_date = '2020-12-19'))
