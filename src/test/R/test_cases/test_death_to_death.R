declareTest(1400, 'Death date')
add_baseline(eid = '1400')
add_death(eid = '1400', date_of_death = '01/01/2020')
expect_death(person_id=1400, death_date = '2020-01-01')

declareTest(1401, 'Death type')
add_baseline(eid = '1401')
add_death(eid = '1401', date_of_death = '01/01/2020', source=1)
expect_death(person_id=1401, death_date = '2020-01-01', death_type_concept_id = 32815)

declareTest(1402, 'Multiple deaths')
add_baseline(eid = '1402')
add_death(eid = '1402', date_of_death = '30/01/2020')
add_death(eid = '1402', date_of_death = '01/02/2020')
expect_count_death(1, person_id=1402)
expect_death(person_id=1402, death_date = '2020-01-30')

declareTest(1403, 'Cause of death')
add_baseline(eid = '1403')
add_death(eid = '1403', ins_index = 0, date_of_death = '30/01/2020')
add_death_cause(eid = '1403', ins_index = 0, arr_index = 0, cause_icd10 = 'I10')
expect_death(person_id=1403, cause_concept_id = 320128, cause_source_value = 'I10')

declareTest(1404, 'Multiple causes of death, only primary cause')
add_baseline(eid = '1404')
add_death(eid = '1404', ins_index = 0, date_of_death = '30/01/2020')
add_death_cause(eid = '1404', ins_index = 0, arr_index = 0, cause_icd10 = 'I259')
add_death_cause(eid = '1404', ins_index = 0, arr_index = 1, cause_icd10 = 'I10')
expect_death(person_id=1404, cause_concept_id = 315286, cause_source_concept_id = 45552784)

declareTest(1405, 'Empty death date not recorded')
add_baseline(eid = '1405')
add_death(eid = '1405', date_of_death = '')
expect_no_death(person_id=1405)


