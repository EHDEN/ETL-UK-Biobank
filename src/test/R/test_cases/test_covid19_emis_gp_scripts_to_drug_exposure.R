# test ID range 2300-2399

declareTest(2300, 'dm+d code: Paracetamol 500mg tablets')
add_baseline(eid = 2300)
add_covid19_emis_gp_scripts(eid = 2300, code_type = '6', code = '322236009')
expect_drug_exposure(person_id = 2300, drug_concept_id = 19020053,
                     drug_source_concept_id = 21311718, drug_source_value = 322236009)

declareTest(2301, 'dm+d long code: Otomize ear spray')
add_baseline(eid = '2301')
add_covid19_emis_gp_scripts(eid = '2301', code_type = '6', code = '507711000001101')
expect_drug_exposure(person_id = 2301, drug_concept_id = 40752252,
                     drug_source_concept_id = 21256355, drug_source_value = 507711000001101,
                     drug_type_concept_id=32838)

declareTest(2302, 'start and end date same')
add_baseline(eid = '2302')
add_covid19_emis_gp_scripts(eid = '2302', code_type = '6', code = '317919004', issue_date = '13/09/2018')
expect_drug_exposure(person_id = 2302, drug_concept_id = 19073982,
                     drug_exposure_start_datetime = '2018/09/13', drug_exposure_start_date = '2018/09/13',
                     drug_exposure_end_datetime = '2018/09/13', drug_exposure_end_date = '2018/09/13')

declareTest(2303, 'data source')
add_baseline(eid = '2303')
add_covid19_emis_gp_scripts(eid = '2303', code_type = '6', code = '317291008', issue_date = '02/11/2020')
expect_drug_exposure(person_id = 2303, drug_concept_id = 19019418,
                     drug_exposure_start_datetime = '2020/11/02', data_source = 'covid19 gp_emis')

declareTest(2304, 'visit id')
add_baseline(eid = '2304')
add_covid19_emis_gp_scripts(eid = '2304', code_type = '6', code = '322503009', issue_date = '21/04/2019')
expect_drug_exposure(person_id = 2304, drug_concept_id = 40223112,
                     drug_exposure_end_date = '2019/04/21', visit_occurrence_id = '6000230420190421')

declareTest(2305, 'if no code_type skip')
add_baseline(eid = '2305')
add_covid19_emis_gp_scripts(eid = '2305', code = '322503009')
expect_no_drug_exposure(person_id = 2305, drug_concept_id = 21274334)

declareTest(2306, 'code_type 3 (local emis code)')
add_baseline(eid = '2306')
add_covid19_emis_gp_scripts(eid = '2306', code_type = '3', code = 'PECA2194', issue_date = '23/01/2021')
expect_drug_exposure(person_id = 2306, drug_concept_id = 0,
                     drug_exposure_start_datetime = '2021/01/23',
                     drug_source_concept_id = 0, drug_source_value = 'PECA2194')

declareTest(2307, 'emis script to drug - skip 2037 date')
add_baseline(eid = '2307')
add_covid19_emis_gp_scripts(eid = '2307', issue_date = '01/07/2037', code = '322236009')
expect_no_drug_exposure(person_id = 2307)
