declareTest(1700, 'GP clinical to stem, readv2 code in read_3 field')
add_baseline(eid = 1700)
add_gp_clinical(eid = 1700, event_dt = '19/04/2020', read_2 = NULL, read_3 = '246A.', value1 = 100)
expect_measurement(person_id = 1700, measurement_concept_id = 4060831,  measurement_source_concept_id = 45468573, measurement_source_value = '246A.')

declareTest(1701, 'GP clinical to stem, visit lookup')
add_baseline(eid = 1701)
add_gp_clinical(eid = 1701, event_dt = '02/04/2020', read_2 = '246..')
expect_measurement(person_id = 1701,
                   visit_occurrence_id = lookup_visit_occurrence('visit_occurrence_id', person_id = 1701, visit_start_date = '2020-04-02'))

declareTest(1702, 'GP clinical to stem, unknown read2 code')
add_baseline(eid = 1702)
add_gp_clinical(eid = 1702, event_dt = '03/04/2020', read_2 = '123abc')
expect_measurement(person_id = 1702, measurement_date = '2020-04-03',
                   measurement_concept_id = 0, measurement_source_concept_id = 0, measurement_source_value = '123abc')

declareTest(1703, 'GP clinical to stem, read3 code')
add_baseline(eid = 1703)
add_gp_clinical(eid = 1703, event_dt = '04/04/2020', read_2 = NULL, read_3 = 'XE2q5', value1 = 100)
expect_measurement(person_id = 1703, measurement_date = '2020-04-04',
                   measurement_concept_id = 37392176, measurement_source_concept_id = 0, measurement_source_value = 'XE2q5')

declareTest(1704, 'GP clinical to stem, missing date')
add_baseline(eid = 1704)
add_gp_clinical(eid = 1704, event_dt = NULL, read_2 = '246..', data_provider = '3')
expect_no_measurement(person_id = 1704, measurement_source_value = '246..')

declareTest(1705, 'GP clinical to stem, Serum creatinine with value')
add_baseline(eid = 1705)
add_gp_clinical(eid = 1705, event_dt = '15/04/2020', read_2 = '44J3.', value1 = 12, data_provider = '1')
expect_measurement(person_id = 1705, measurement_concept_id = 37392176, measurement_source_value = '44J3.', measurement_source_concept_id = 45461929,
                   value_as_number = 12)

declareTest(1706, 'GP clinical to stem, unit concept ID (MEA code)')
add_baseline(eid = 1706)
add_gp_clinical(eid = 1706, event_dt = '02/12/2020', read_3 = 'XE2q5', value3 = 'MEA057')
expect_measurement(person_id = 1706, measurement_date = '2020-12-02', unit_concept_id = 8636, unit_source_value = 'MEA057')

declareTest(1707, 'GP clinical to stem, unit concept ID (unit symbol)')
add_baseline(eid = 1707)
add_gp_clinical(eid = 1707, event_dt = '02/12/2020', read_2 = '246..', value3 = 'x10^9/l')
expect_measurement(person_id = 1707, measurement_date = '2020-12-02', unit_concept_id = 9444, unit_source_value = 'x10^9/l')

declareTest(1708, 'GP clinical to stem, readv3 serum urea')
add_baseline(eid = 1708)
add_gp_clinical(eid = 1708, event_dt = '18/04/2020', read_2 = NULL, read_3 = 'XM0lt')
expect_measurement(person_id = 1708, measurement_concept_id = 37392195, measurement_source_value = 'XM0lt')

declareTest(1709, 'GP clinical to stem, DBP with value')
add_baseline(eid = 1709)
add_gp_clinical(eid = 1709, event_dt = '16/04/2020', read_2 = '246A.', value1 = 80.7, value2 = NULL, data_provider = '2')
expect_measurement(person_id = 1709, measurement_concept_id = 4060831, measurement_source_value = '246A.', measurement_source_concept_id = 45468573,
                   value_as_number = 80.7)

declareTest(1710, 'GP clinical to stem, SBP with value')
add_baseline(eid = 1710)
add_gp_clinical(eid = 1710, event_dt = '16/04/2020', read_2 = '2469.', value1 = 80.7, value2 = NULL, data_provider = '2')
expect_measurement(person_id = 1710, measurement_concept_id = 4062019, measurement_source_value = '2469.', measurement_source_concept_id = 45475200,
                   value_as_number = 80.7)

declareTest(1711, 'GP clinical to stem, generic blood pressure code with no custom logic')
add_baseline(eid = 1711)
add_gp_clinical(eid = 1711, event_dt = '01/04/2020', read_2 = '246..', data_provider = '3')
expect_measurement(person_id = 1711, measurement_date = '2020-04-01', measurement_type_concept_id = 32817,
                   measurement_concept_id = 4061103, measurement_source_concept_id = 45471867, measurement_source_value = '246..')

declareTest(1712, 'GP clinical to stem, generic blood pressure code with values for both DBP and SBP (code ending in dot)')
add_baseline(eid = 1712)
add_gp_clinical(eid = 1712, event_dt = '17/04/2020', read_2 = '246..', value1 = 123, value2 = 85, data_provider = '2')
expect_measurement(person_id = 1712, measurement_concept_id = 4060831, measurement_source_value = '246..', value_as_number = 123, measurement_source_concept_id = 45471867)
expect_measurement(person_id = 1712, measurement_concept_id = 4062019, measurement_source_value = '246..', value_as_number = 85, measurement_source_concept_id = 45471867)

declareTest(1713, 'GP clinical to stem, generic blood pressure code with values for both DBP and SBP (code ending in 00)')
add_baseline(eid = 1713)
add_gp_clinical(eid = 1713, event_dt = '17/04/2020', read_2 = '246..00', value1 = 123, value2 = 85, data_provider = '2')
expect_measurement(person_id = 1713, measurement_concept_id = 4060831, measurement_source_value = '246..00', value_as_number = 123, measurement_source_concept_id = 45471867)
expect_measurement(person_id = 1713, measurement_concept_id = 4062019, measurement_source_value = '246..00', value_as_number = 85, measurement_source_concept_id = 45471867)

declareTest(1714, 'GP clinical 1902/02/02 to yob-07-01')
add_baseline(eid = 1714, `34-0.0` = '1991')
add_gp_clinical(eid = 1714, event_dt = '02/02/1902', read_2 = NULL, read_3 = '246A.')
expect_measurement(person_id = 1714, measurement_date='1991-07-01')
