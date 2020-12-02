# test ID range 1700-1799

declareTest(1700, 'No drug exposure if no drug codes available')
add_baseline(eid = '1700')
add_gp_prescriptions(eid = '1700', dmd_code = NULL, read_2 = NULL, drug_name = NULL)
expect_no_drug_exposure(person_id = 1700)

declareTest(1701, 'Test dm+d > Read 2 > drug name when all drug fields available')
add_baseline(eid = '1701')
add_gp_prescriptions(eid = '1701', dmd_code = '21199984', read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1701, drug_concept_id = 1705676) # dm+d -> trimethoprim 100 MG Oral Tablet

declareTest(1702, 'Test dm+d > Read v2 > drug name when only Read v2 & drug name available')
add_baseline(eid = '1702')
add_gp_prescriptions(eid = '1702', dmd_code = NULL, read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1702, drug_concept_id = 41091617) # Read v2 -> Acetaminophen 500 MG Oral Tablet

declareTest(1703, 'Test dm+d > Read v2 > drug name when only drug name available')
add_baseline(eid = '1703')
add_gp_prescriptions(eid = '1703', dmd_code = NULL, read_2 = NULL, drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1703, drug_concept_id = 19078461) # drug name -> ibuprofen 200 MG Oral Tablet

# add_gp_prescriptions(eid, data_provider, issue_date, read_2, bnf_code, dmd_code, drug_name, quantity)

# expecte_drug_exposure(
# person_id,
# drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date,
# drug_concept_id, drug_type_concept_id, drug_source_value, drug_source_concept_id,
# quantity, dose_unit_source_value,
# visit_occurrence_id, visit_detail_id)