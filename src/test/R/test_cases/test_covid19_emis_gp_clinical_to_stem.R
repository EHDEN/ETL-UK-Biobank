# test ID range 2600-2699

declareTest(2600, 'SNOMED code: Serum alanine aminotransferase level')
add_baseline(eid = 2600)
add_covid19_emis_gp_clinical(eid = 2600, code=1018251000000107, code_type = '2',event_dt='24/02/2020', value=5.0, unit='g/L')
expect_measurement(person_id=2600, measurement_concept_id=37393531, measurement_date='2020-02-24', value_as_number=5.0, unit_concept_id=8636)

declareTest(2601, 'No Event date')
add_baseline(eid = 2601)
add_covid19_emis_gp_clinical(eid = 2601, event_dt = '')
expect_no_measurement(person_id = 2601)

declareTest(2602, 'Value is -9000001.0')
add_baseline(eid=2602)
add_covid19_emis_gp_clinical(eid = 2602, event_dt = '24/02/2020', code = 163020007, value = '-9000001.0')
expect_no_measurement(person_id = 2602)

declareTest(2603, 'Code is -99')
add_baseline(eid = 2603)
add_covid19_emis_gp_clinical(eid = 2603, event_dt = '24/02/2020', code = '-99', value = 1)
expect_no_measurement(person_id = 2603)

declareTest(2604, 'Local code: Suspected 2019-nCoV (novel coronavirus) infection')
add_baseline(eid = 2604)
add_covid19_emis_gp_clinical(eid = 2604, event_dt = '24/02/2020', code_type = '3', code = 'EMISNQSU106', value = '5.6', unit = '10*12/L')
expect_measurement(person_id = 2604, measurement_concept_id = 37311060, measurement_date = '2020-02-24', value_as_number = 5.6, unit_concept_id = 44777575)

declareTest(2605, 'Unit is -9999999')
add_baseline(eid = 2605)
add_covid19_emis_gp_clinical(eid = 2506, event_dt = '24/02/2020', code_type = '3', code = 'EMISNQTE31', value = '467', unit = '-9999999')
expect_measurement(person_id = 2506, measurement_concept_id = 756055, measurement_date = '2020-02-24', value_as_number = 467, unit_concept_id = NULL)

declareTest(2606, 'Covid19 EMIS GP clinical to stem, EMISNQCO303 with value mapping')
add_baseline(eid = 2606)
add_covid19_emis_gp_clinical(eid = 2606, event_dt = '01/04/2021', code_type = 3, code = 'EMISNQCO303', value = '')
expect_measurement(person_id = 2606, measurement_concept_id = 756065, value_as_concept_id = 4126681)

declareTest(2607, 'Covid19 EMIS GP clinical to stem, no meas when future date')
add_baseline(eid = 2607)
add_covid19_emis_gp_clinical(eid = 2607, event_dt = '01/07/2037', code=1018251000000107)
expect_no_measurement(person_id = 2607, measurement_date = '2037-07-01')

declareTest(2608, 'Covid19 EMIS GP clinical to stem, domain_id=Measure when value_as_number > 0')
add_baseline(eid = 2608)
add_covid19_emis_gp_clinical(eid = 2608, event_dt = '01/07/2017', code=163020007, value=23.0)
expect_measurement(person_id = 2608, measurement_date = '2017-07-01')

declareTest(2609, 'Covid19 EMIS GP clinical to stem, domain_id=Measure when value_as_concept_id != None')
add_baseline(eid = 2609)
add_covid19_emis_gp_clinical(eid = 2609, event_dt = '01/07/2017', code_type=3, code='EMISNQCO303', value='')
expect_measurement(person_id = 2609, measurement_date = '2017-07-01')

declareTest(2610, 'Covid19 EMIS GP clinical to stem, domain_id=Condition when value_as_number == 0')
add_baseline(eid = 2610)
add_covid19_emis_gp_clinical(eid = 2610, event_dt = '01/07/2017', code=1018251000000107, value=0.0)
expect_no_measurement(person_id = 2610, measurement_date = '2017-07-01')