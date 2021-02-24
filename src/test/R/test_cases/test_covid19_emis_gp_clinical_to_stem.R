# test ID range 2500-2599

declareTest(2500, 'SNOMED code: Serum alanine aminotransferase level')
add_baseline(eid = 2500)
add_covid19_emis_gp_clinical(eid = 2500, code=1018251000000107, event_dt='24/02/2020', value=5.0, unit='g/L')
expect_measurement(person_id=2500, measurement_concept_id=37393531, measurement_date='2020-02-24', value_as_number=5.0, unit_concept_id=8636)

declareTest(2501, 'No Event date')
add_baseline(eid = 2501)
add_covid19_emis_gp_clinical(eid = 2501, event_dt = '')
expect_no_measurement(person_id = 2501)

declareTest(2502, 'Value is -9000001.0')
add_baseline(eid=2502)
add_covid19_emis_gp_clinical(eid = 2502, event_dt = '24/02/2020', code = 163020007, value = '-9000001.0')
expect_no_measurement(person_id = 2502)

declareTest(2503, 'Code is -99')
add_baseline(eid = 2503)
add_covid19_emis_gp_clinical(eid = 2503, event_dt = '24/02/2020', code = '-99', value = 1)
expect_no_measurement(person_id = 2503)

declareTest(2504, 'Local code: Suspected 2019-nCoV (novel coronavirus) infection')
add_baseline(eid = 2504)
add_covid19_emis_gp_clinical(eid = 2504, event_dt = '24/02/2020', code = 'EMISNQSU106', value = '5.6', unit = '10*12/L')
expect_measurement(person_id = 2504, measurement_concept_id = 37311060, measurement_date = '2020-02-24', value_as_number = 5.6, unit_concept_id = 44777575)

declareTest(2505, 'Unit is -9999999')
add_baseline(eid = 2505)
add_covid19_emis_gp_clinical(eid = 2505, event_dt = '24/02/2020', code = 'EMISNQTE31', value = '467', unit = '-9999999')
expect_measurement(person_id = 2505, measurement_concept_id = 756055, measurement_date = '2020-02-24', value_as_number = 467, unit_concept_id = NULL)

