# test ID range 2400-2499

declareTest(2400, 'dm+d code: Ramipril 10mg capsules')
add_baseline(eid = 2400)
add_covid19_tpp_gp_scripts(eid = 2400, dmd_code = '318906001')
expect_drug_exposure(person_id = 2400, drug_concept_id = 1334494,
                     drug_source_concept_id = 21255739, drug_source_value = 318906001)


declareTest(2401, 'dmd code: -1')
add_baseline(eid = '2401')
add_covid19_tpp_gp_scripts(eid = '2401', dmd_code = '-1')
expect_no_drug_exposure(person_id = 2401)


declareTest(2402, 'start and end date same')
add_baseline(eid = '2402')
add_covid19_tpp_gp_scripts(eid = '2402', dmd_code = '323365007', issue_date = '02/07/2017')
expect_drug_exposure(person_id = 2402, drug_concept_id = 40223768,
                     drug_exposure_start_datetime = '2017/07/02', drug_exposure_start_date = '2017/07/02',
                     drug_exposure_end_datetime = '2017/07/02', drug_exposure_end_date = '2017/07/02')


declareTest(2403, 'data source')
add_baseline(eid = '2403')
add_covid19_tpp_gp_scripts(eid = '2403', dmd_code = '321998002', issue_date = '10/08/2019')
expect_drug_exposure(person_id = 2403, drug_concept_id = 725180,
                     drug_exposure_start_datetime = '2019/08/10', data_source = 'covid19 gp_tpp')


declareTest(2404, 'visit id')
add_baseline(eid = '2404')
add_covid19_tpp_gp_scripts(eid = '2404', dmd_code = '318858008', issue_date = '29/06/2019')
expect_drug_exposure(person_id = 2404, drug_concept_id = 1308251,
                     drug_exposure_end_date = '2019/06/29', visit_occurrence_id = '5000240420190629')


declareTest(2405, 'if no dmd code skip')
add_baseline(eid = '2405')
add_covid19_tpp_gp_scripts(eid = '2405', dmd_code = '')
expect_no_drug_exposure(person_id = 2405)