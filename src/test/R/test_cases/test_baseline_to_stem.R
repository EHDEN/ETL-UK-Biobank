declareTest(900, 'Baseline - Hand grip')
add_baseline(eid = '900', `53-0.0`='2010-10-10', `47-0.0`='11.3')
expect_measurement(person_id = 900, measurement_date = '2010-10-10', measurement_concept_id = 44805438,
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
                   unit_concept_id = 44777588, value_as_number = 5.55)

declareTest(904, 'Baseline - Field 20002, Diabetes Mellitus')
add_baseline(eid = '904', `53-0.0`='2020-11-02', `20002-0.0`='1220', `30002-0.0`='2020-11-01')
expect_observation(person_id = 904, observation_date = '2020-11-02', observation_concept_id = 4214956, value_as_concept_id = 201820)

declareTest(905, 'Baseline - Chestpain absent, with source value')
add_baseline(eid = '905', `53-0.0`='2010-10-10', `2335-0.0`='0')
expect_observation(person_id = 905, observation_date = '2010-10-10', observation_concept_id = 40481925,
                   value_as_concept_id = 4133044, observation_source_value = '2335|0',
                   observation_source_concept_id = 35810289)

declareTest(906, 'Baseline - Chestpain present, repeat visit')
add_baseline(eid = '906', `53-1.0`='2013-12-11', `2335-1.0`='1')
expect_observation(person_id = 906, observation_date = '2013-12-11', observation_concept_id = 4214956,
                   value_as_concept_id = 4133044)

declareTest(907, 'Baseline - Chestpain present, imaging visit')
add_baseline(eid = '907', `53-2.0`='2014-12-11', `2335-2.0`='1')
expect_observation(person_id = 907, observation_date = '2014-12-11', observation_concept_id = 4214956)

declareTest(908, 'Baseline - Chestpain present, imaging repeat visit')
add_baseline(eid = '908', `53-3.0`='2015-12-11', `2335-3.0`='1')
expect_observation(person_id = 908, observation_date = '2015-12-11', observation_concept_id = 4214956)

declareTest(909, 'Baseline - Chestpain ignored')
add_baseline(eid = '909', `53-0.0`='2013-09-05', `2335-0.0`='-1')
expect_no_observation(person_id = 909, observation_date = '2013-9-5', observation_concept_id = 4214956)

declareTest(910, 'Baseline - Do not map year of birth or gender')
add_baseline(eid = '910', `31-0.0`='0', `34-0.0`='1970')
expect_no_observation(person_id = 910, observation_source_value = '31|0')
expect_no_observation(person_id = 910, observation_source_value = '34')

declareTest(912, 'Baseline - Treatment')
add_baseline(eid = '912', `20003-0.0`='2038459704')
expect_observation(person_id = 912, observation_concept_id = 4059354, value_as_concept_id = 740275)

declareTest(913, 'Baseline - Treatment with instance and array index')
add_baseline(eid = '913', `20003-1.15`='2038459704')
expect_observation(person_id = 913, observation_concept_id = 4059354, value_as_concept_id = 740275)

declareTest(914, 'Baseline - Age at first live birth')
add_baseline(eid = '914', `2754-0.0`='35')
expect_observation(person_id = 914, value_as_number = 35, observation_source_value = '2754',
                   observation_source_concept_id = 35810315)

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

declareTest(919, 'Baseline - visit occurrence instance 0 (Alcohol use)')
add_baseline(eid = '919', `53-0.0`='2010-10-12', `1558-0.0`='1')
expect_observation(person_id = 919, observation_date = '2010-10-12',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 919, visit_start_date = '2010-10-12'))

declareTest(920, 'Baseline - visit occurrence instance 3 (Alcohol use)')
add_baseline(eid = '920', `53-3.0`='2010-10-13', `1558-3.0`='1')
expect_observation(person_id = 920, observation_date = '2010-10-13',
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 920, visit_start_date = '2010-10-13'))

declareTest(923, 'Baseline - type registry (handgrip strength)')
add_baseline(eid = '923', `47-0.0`='7002')
expect_measurement(person_id = 923, measurement_type_concept_id = 32879)

declareTest(924, 'Baseline - type patient filled survey (Alcohol use)')
add_baseline(eid = '924', `1558-0.0`='1')
expect_observation(person_id = 924, observation_source_value = '1558|1', observation_type_concept_id = 32862,
                   observation_source_concept_id = 35810226)

declareTest(925, 'Baseline - type professional filled survey')
add_baseline(eid = '925', `20002-0.0`='1220')
expect_observation(person_id = 925, observation_source_value = '20002|1220', observation_type_concept_id = 32851,
                   observation_source_concept_id = 35810059)

declareTest(926, 'Baseline - date field related to concept field, instance 0')
add_baseline(eid = '926', `30140-0.0` = '3.8', `30142-0.0` = '2018-09-11')
expect_measurement(person_id = 926, measurement_date = '2018-09-11')

declareTest(927, 'Baseline - date field related to concept field, instance 2')
add_baseline(eid = '927', `30080-2.0` = '235.7', `30082-2.0` = '1999-02-08')
expect_measurement(person_id = 927, measurement_date = '1999-02-08')

declareTest(928, 'Baseline - realetd date field is empty backup (53) taken')
add_baseline(eid = 928, `30080-3.0` = '228',`30082-3.0` = '', `53-3.0` = '2019-03-16')
expect_measurement(person_id = 928, measurement_date = '2019-03-16')

declareTest(929, 'Baseline - no related date field use field 53')
add_baseline(eid = '929', `4080-1.0` = '137', `53-1.0` = '2017-09-13')
expect_measurement(person_id = 929, measurement_date = '2017-09-13')

declareTest(930, 'Baseline - empty date field use default date')
add_baseline(eid = '930', `4079-3.0` = '81', `53-3.0` = '')
expect_measurement(person_id = 930, measurement_date = '1970-01-01')

declareTest(931, 'Baseline - datetime format')
add_baseline(eid = '931', `30070-0.0` = '123', `30072-0.0` = '2010-07-08T07:39:23')
expect_measurement(person_id = 931, measurement_date = '2010-07-08')

declareTest(932, 'Baseline - truncate long value of device ID')
add_baseline(eid = '932', `53-0.0` = '2020-02-01', `36-0.0` = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz')
expect_device_exposure(person_id = 932, device_exposure_start_date = '2020-02-01', device_concept_id = 4272314,
                       unique_device_id = 'abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwx')

declareTest(933, 'Baseline - age at cancer diagnosis')
add_baseline(eid = '933', `40005-1.0` = '2011-10-18', `40008-1.0` = '43')
expect_measurement(person_id = 933, measurement_date = '2011-10-18',
                   measurement_concept_id = 3007016, value_as_number = 43, unit_concept_id = 9448)

declareTest(934, 'Baseline - behaviour of cancer tumour')
add_baseline(eid = '934', `40005-2.0` = '2018-02-13', `40012-2.0` = '6')
expect_observation(person_id = 934, observation_date = '2018-02-13',
                   observation_concept_id = 4077872, value_as_concept_id = 36311298)

declareTest(935, 'Baseline - cancer record format')
add_baseline(eid = '935', `40005-4.0` = '2020-08-30', `40019-4.0` = '13')
expect_observation(person_id = 935, observation_date = '2020-08-30',
                   observation_concept_id = 4299598)

declareTest(936, 'Baseline - cancer record origin')
add_baseline(eid = '936', `40005-11.0` = '2017-04-07', `40021-11.0` = 'NCIN')
expect_observation(person_id = 936, observation_date = '2017-04-07',
                   observation_concept_id = 4299598)

declareTest(937, 'Baseline - device id')
add_baseline(eid = '937', `30003-0.0` = 'ABC123')
expect_device_exposure(person_id = 937, device_concept_id = 4272314, unique_device_id = 'ABC123')

declareTest(938, 'Baseline - Age Glaucoma: unit and concept mapping')
add_baseline(eid = '938', `4689-0.0` = 67)
expect_observation(person_id = 938, observation_concept_id = 4214956,
                   value_as_number = 67, unit_concept_id = 9448, value_as_concept_id = 437541)

declareTest(939, 'Baseline - Age Diabetes')
add_baseline(eid = '939', `2976-0.0` = 37)
expect_observation(person_id = 939, observation_concept_id = 4214956,
                   value_as_number = 37, unit_concept_id = 9448, value_as_concept_id = 201820)

declareTest(940, 'Baseline - BMI')
add_baseline(eid = '940', `21001-0.0` = 18)
expect_measurement(person_id = 940, measurement_concept_id = 4245997,
                   value_as_number = 18)

declareTest(941, 'Baseline - LV ejection fraction')
add_baseline(eid = '941', `22420-0.0` = 94)
expect_measurement(person_id = 941, measurement_source_concept_id = 35811603,
                   value_as_number = 94)

declareTest(942, 'Baseline - Age last episode of depression - source concept')
add_baseline(eid = '942', `20434-0.0` = 41)
expect_observation(person_id = 942, observation_source_concept_id = 35811128, observation_source_value = '20434|41')

declareTest(943, 'Baseline - Distance to viewer left eye - lookup target concept from OMOP vocab')
add_baseline(eid = '943', `5211-0.0` = 1.5)
expect_observation(person_id = 943, observation_concept_id = 4302663, unit_concept_id = 9546, value_as_number = 1.5)

declareTest(943, 'Baseline - Distance to viewer left eye - lookup target concept from OMOP vocab')
add_baseline(eid = '943', `5211-0.0` = 1.5)
expect_observation(person_id = 943, observation_concept_id = 4302663, unit_concept_id = 9546, value_as_number = 1.5)

declareTest(944, 'Baseline - do not include primary cause of death as observation')
add_baseline(eid = '944', `40001-0.0` = 'C15')
expect_no_observation(person_id = 944, observation_source_value = '40001|C15')
