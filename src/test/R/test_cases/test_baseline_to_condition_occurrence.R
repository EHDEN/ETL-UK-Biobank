
declareTest(3100, 'Baseline to observation - secondary cause of death')
add_baseline(eid=3100, `40000-0.0`='2020-12-07', `40002-0.0`='T751')
expect_observation(person_id=3100, observation_date ='2020-12-07', observation_concept_id =4046219, observation_source_concept_id =45547722)

declareTest(3101, 'Baseline to observation, no date')
add_baseline(eid=3101, `40000-0.0`='', `40002-0.0`='K559')
expect_no_observation(person_id=3101)

declareTest(3102, 'Baseline to observation, no ICD10 code')
add_baseline(eid=3102, `40000-0.0`='2020-12-07', `40002-0.0`='')
expect_no_observation(person_id=3102)

declareTest(3103, 'Baseline to observation - secondary cause of death')
add_baseline(eid=3103, `40000-0.0`='2020-12-07', `40002-0.0`='J189')
expect_observation(person_id=3103, observation_date ='2020-12-07', observation_concept_id =4099094, observation_source_concept_id =45601954)

declareTest(3104, 'Baseline to observation - multiple secondary causes of death')
add_baseline(eid=3104, `40000-0.0`='2020-12-07', `40002-0.0`='E119', `40002-0.1`='A419')
expect_observation(person_id = 3104, observation_date = '2020-12-07', observation_concept_id = 4193704)
expect_observation(person_id = 3104, observation_date = '2020-12-07', observation_concept_id = 132797)



add_observation(eid = 3104, ins_index = 0, date_of_death = '30/01/2020')
add_death_cause(eid = 3104, ins_index = 0, arr_index = 0, cause_icd10 = 'I10')
expect_no_death(person_id=3104, death_date = '2020-12-07')

A419
C80
I259
R688
J81