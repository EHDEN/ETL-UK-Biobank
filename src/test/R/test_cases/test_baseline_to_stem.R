declareTest(900, 'Baseline - Hand grip')
add_baseline(eid = '900', `53-0.0`='2010-10-10', `47-0.0`='11.3')
expect_observation(person_id = 900, observation_date = '2010-10-10', observation_concept_id = 44805438,
                   unit_concept_id = 9529, value_as_number = 11.3)

declareTest(901, 'Baseline - Alcohol use, daily to observation')
add_baseline(eid = '901', `1558-0.0`='1')
expect_observation(person_id = 901, observation_concept_id = 4052351, value_as_concept_id = 45879676)

declareTest(902, 'Baseline - Alcohol use, not answered')
add_baseline(eid = '902', `1558-0.0`='-3')
expect_no_observation(person_id = 902, observation_concept_id = 4052351)

declareTest(903, 'Baseline - White blood cell count (alternate date field)')
add_baseline(eid = '903', `30000-0.0`='5.55', `30002-0.0`='2020-11-01')
expect_measurement(person_id = 903, measurement_date = '2020-11-01', measurement_concept_id = 3010813,
                   unit_concept_id = 4175206, value_as_number = 5.55)

declareTest(904, 'Baseline - Field 20002, Diabetes Mellitus')
add_baseline(eid = '904', `53-0.0`='2020-11-02', `20002-0.0`='1220', `30002-0.0`='2020-11-01')
expect_observation(person_id = 904, observation_date = '2020-11-02', observation_concept_id = 4188893, value_as_concept_id = 201820)

declareTest(905, 'Baseline - Chestpain absent, with source value')
add_baseline(eid = '905', `53-0.0`='2010-10-10', `2335-0.0`='0')
expect_observation(person_id = 905, observation_date = '2010-10-10', observation_concept_id = 4211787,
                   value_as_concept_id = 4133044, observation_source_value = '2335|0')

declareTest(906, 'Baseline - Chestpain present, repeat visit')
add_baseline(eid = '906', `53-1.0`='2013-12-11', `2335-1.0`='1')
expect_observation(person_id = 906, observation_date = '2013-12-11', observation_concept_id = 4188893,
                   value_as_concept_id = 4133044)

declareTest(907, 'Baseline - Chestpain present, imaging visit')
add_baseline(eid = '907', `53-2.0`='2014-12-11', `2335-2.0`='1')
expect_observation(person_id = 907, observation_date = '2014-12-11', observation_concept_id = 4188893)

declareTest(908, 'Baseline - Chestpain present, imaging repeat visit')
add_baseline(eid = '908', `53-3.0`='2015-12-11', `2335-3.0`='1')
expect_observation(person_id = 908, observation_date = '2015-12-11', observation_concept_id = 4188893)

declareTest(909, 'Baseline - Chestpain ignored')
add_baseline(eid = '909', `53-0.0`='2013-09-05', `2335-0.0`='-1')
expect_no_observation(person_id = 909, observation_date = '2013-9-5', observation_concept_id = 4188893)

declareTest(910, 'Baseline - Do not map year of birth or gender')
add_baseline(eid = '910', `31-0.0`='0', `34-0.0`='1970')
expect_no_observation(person_id = 909, observation_source_value = '31|0')
expect_no_observation(person_id = 909, observation_source_value = '34')

declareTest(911, 'Baseline - One to many opcs')
add_baseline(eid = '911', `41256-0.0`='027')
expect_observation(person_id = 911, observation_concept_id = 40770405, value_as_concept_id = 4302449)
expect_observation(person_id = 911, observation_concept_id = 40770405, value_as_concept_id = 4222434)

declareTest(912, 'Baseline - Treatment')
add_baseline(eid = '912', `20003-0.0`='2038459704')
expect_observation(person_id = 912, observation_concept_id = 3021806, value_as_concept_id = 740275)

declareTest(913, 'Baseline - Treatment with instance and array index')
add_baseline(eid = '913', `20003-1.15`='2038459704')
expect_observation(person_id = 913, observation_concept_id = 3021806, value_as_concept_id = 740275)

declareTest(914, 'Baseline - Age at first live birth')
add_baseline(eid = '914', `2754-0.0`='35')
expect_observation(person_id = 914, value_as_number = 35, observation_source_value = '2754')

declareTest(915, 'Baseline - Age at first live birth not given')
add_baseline(eid = '915', `2754-0.0`='-3')
expect_no_observation(person_id = 915, observation_source_value = '2754')

declareTest(916, 'Baseline - Systolic Blood pressure at two instances')
add_baseline(eid = '916', `93-0.0`='80', `93-1.0`='89')
expect_no_observation(person_id = 916, observation_concept_id = 4152194, value_as_number = 80, unit_concept_id = 8876, observation_source_value = '93')
expect_no_observation(person_id = 916, observation_concept_id = 4152194, value_as_number = 89, unit_concept_id = 8876, observation_source_value = '93')

declareTest(917, 'Baseline - Systolic Blood pressure, empty')
add_baseline(eid = '917', `93-0.0`='')
expect_no_observation(person_id = 917, observation_source_value = '93')

declareTest(918, 'Baseline - Do not capture dates')
add_baseline(eid = '918', `53-0.0`='2010-10-10', `30002-2.0`='2010-10-10')
expect_no_observation(person_id = 918, observation_source_value = '53')
expect_no_observation(person_id = 918, observation_source_value = '53|2010-10-10')
expect_no_observation(person_id = 918, observation_source_value = '30002')
expect_no_observation(person_id = 918, observation_source_value = '30002|2010-10-10')

declareTest(919, 'Baseline - visit occurrence instance 0')
add_baseline(eid = '919', `53-0.0`='2010-10-12', `47-0.0`='11.3')
expect_observation(person_id = 919, observation_date = '2010-10-12',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 919, visit_start_date = '2010-10-12'))

declareTest(920, 'Baseline - visit occurrence instance 3')
add_baseline(eid = '920', `53-3.0`='2010-10-13', `48-3.0`='85')
expect_observation(person_id = 920, observation_date = '2010-10-13',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 920, visit_start_date = '2010-10-13'))

declareTest(921, 'Baseline - opcs3 field 41256 single target')
add_baseline(eid = '921', `41256-0.0`='018')
expect_observation(person_id = 921, observation_concept_id = 40770405, value_as_concept_id = 2110401)

declareTest(922, 'Baseline - opcs3 field 41273 single target')
add_baseline(eid = '922', `41273-0.0`='7002')
expect_observation(person_id = 922, observation_concept_id = 40770405, value_as_concept_id = 4130184)