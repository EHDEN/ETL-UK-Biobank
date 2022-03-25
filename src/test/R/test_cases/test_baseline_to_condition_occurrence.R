
declareTest(3100, 'Baseline to condition occurrence - secondary cause of death')
add_baseline(eid=3100, `40000-0.0`='2020-11-06', `40002-0.0`='T751')
expect_condition_occurrence(person_id=3100, condition_start_date='2020-11-06',
                            condition_concept_id=443081, condition_source_concept_id=45604505)

declareTest(3101, 'Baseline to condition occurrence, no date')
add_baseline(eid=3101, `40000-0.0`='', `40002-0.0`='K559')
expect_no_condition_occurrence(person_id=3101)

declareTest(3102, 'Baseline to condition occurrence - no ICD10 code')
add_baseline(eid=3102, `40000-0.0`='2020-09-05', `40002-0.0`='')
expect_no_condition_occurrence(person_id=3102)

declareTest(3103, 'Baseline to condition occurrence - secondary cause of death')
add_baseline(eid=3103, `40000-0.0`='2020-03-17', `40002-0.0`='J189')
expect_condition_occurrence(person_id=3103, condition_start_date='2020-03-17',
                            condition_concept_id=255848, condition_source_concept_id=45601123)

declareTest(3104, 'Baseline to condition occurrence - already in condition occurrence table')
add_baseline(eid=3104, `40000-0.0`='2020-01-30', `40002-0.0`='C80')
add_death(eid=3104, ins_index=0, date_of_death='29/01/2020')
add_death_cause(eid=3104, ins_index=0, arr_index = 1, cause_icd10='C80')
expect_no_condition_occurrence(person_id=3104, condition_start_date='2020-01-30')
