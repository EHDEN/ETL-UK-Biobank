# test IDs 1600-1699

declareTest(1600, 'Death to condition occurrence')
add_baseline(eid='1600')
add_death(eid='1600', date_of_death='2020-11-25')
add_death_cause(eid='1600', arr_index=1, cause_icd10='C509')
expect_condition_occurrence(person_id=1600, condition_concept_id=4162253, condition_start_date='2020-11-25', condition_type_concept_id=32815,
                            condition_source_concept_id=45547505)


declareTest(1601, 'Death to condition occurrence 2')
add_baseline(eid='1601')
add_death(eid='1601', date_of_death='2020-11-01')
add_death_cause(eid='1601', arr_index=5, cause_icd10='I489')
expect_condition_occurrence(person_id=1601, condition_concept_id=4068155, condition_start_date='2020-11-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45755409)

declareTest(1602, 'Death to condition occurrence - No death date')
add_baseline(eid='1602')
add_death(eid='1602')
add_death_cause(eid='1602', arr_index=5, cause_icd10='I10')
expect_no_condition_occurrence(person_id = 1602)

declareTest(1603, 'Death to condition occurrence - No cause icd10 code')
add_baseline(eid='1603')
add_death(eid='1603', date_of_death = '2019-08-17')
add_death_cause(eid='1603', arr_index=3)
expect_no_condition_occurrence(person_id = 1603)

declareTest(1604, 'Death to condition occurrence - arr_index is 0')
add_baseline(eid='1604')
add_death(eid='1604', date_of_death = '2019-08-17')
add_death_cause(eid='1604', arr_index=0, cause_icd10='I10')
expect_no_condition_occurrence(person_id = 1604)