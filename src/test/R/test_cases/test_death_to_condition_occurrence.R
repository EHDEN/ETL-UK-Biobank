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

declareTest(1605, 'Death to condition occurrence - 2 death causes')
add_baseline(eid='1605')
add_death(eid='1605', date_of_death='2018-01-01')
add_death_cause(eid='1605', arr_index=1, cause_icd10='C679')
add_death_cause(eid='1605', arr_index=1, cause_icd10='J449')
expect_condition_occurrence(person_id=1605, condition_concept_id=196360, condition_start_date='2018-01-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45571528)
expect_condition_occurrence(person_id=1605, condition_concept_id=255573, condition_start_date='2018-01-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45548115)

declareTest(1606, 'Death to condition occurrence - 4 death causes')
add_baseline(eid='1606')
add_death(eid='1606', date_of_death='2018-07-01')
add_death_cause(eid='1606', arr_index=1, cause_icd10='G931')
add_death_cause(eid='1606', arr_index=2, cause_icd10='C349')
add_death_cause(eid='1606', arr_index=3, cause_icd10='N189')
add_death_cause(eid='1606', arr_index=4, cause_icd10='A419')
expect_condition_occurrence(person_id=1606, condition_concept_id=377845, condition_start_date='2018-07-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45538146)
expect_condition_occurrence(person_id=1606, condition_concept_id=4311499, condition_start_date='2018-07-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45542592)
expect_condition_occurrence(person_id=1606, condition_concept_id=46271022, condition_start_date='2018-07-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45553438)
expect_condition_occurrence(person_id=1606, condition_concept_id=	132797, condition_start_date='2018-07-01', condition_type_concept_id=32815,
                            condition_source_concept_id=45585911)







