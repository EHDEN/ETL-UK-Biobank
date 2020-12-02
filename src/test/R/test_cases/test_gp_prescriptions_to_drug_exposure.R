# test ID range 1200-1299

declareTest(1200, 'Test no drug exposure if no drug fields available')
add_baseline(eid = '1200')
add_gp_prescriptions(eid = '1200', dmd_code = NULL, read_2 = NULL, drug_name = NULL)
expect_no_drug_exposure(person_id = 1200)

# dm+d -> trimethoprim 100 MG Oral Tablet
declareTest(1201, 'Test drug fields priority when all drug fields available')
add_baseline(eid = '1201')
add_gp_prescriptions(eid = '1201', dmd_code = '324430000', read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1201, drug_concept_id = 1705676, drug_source_concept_id = 21199984, drug_source_value = '324430000')#, drug_type_concept_id=38000177)

 # Read v2 -> Acetaminophen 500 MG Oral Tablet
declareTest(1202, 'Test drug fields priority when only Read v2 & drug name available')
add_baseline(eid = '1202')
add_gp_prescriptions(eid = '1202', dmd_code = NULL, read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1202, drug_concept_id = 41091617, drug_source_concept_id = 0, drug_source_value = 'di21.', drug_type_concept_id=38000177)

# drug name -> ibuprofen 200 MG Oral Tablet
declareTest(1203, 'Test drug fields priority when only drug name available')
add_baseline(eid = '1203')
add_gp_prescriptions(eid = '1203', dmd_code = NULL, read_2 = NULL, drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1203, drug_concept_id = 19078461, drug_source_concept_id = 0, drug_source_value = 'Ibuprofen 200mg tablets', drug_type_concept_id=38000177)

declareTest(1204, 'Test data source code creation')
add_baseline(eid = '1204')
add_gp_prescriptions(eid = '1204', dmd_code = '324430000', data_provider = 1)
expect_drug_exposure(person_id = 1204, data_source = 'GP-1')

# PLACEHOLDERS

#declareTest(1205, 'Test correct start date format')
#add_baseline(eid = '1205')
#add_gp_prescriptions(eid = '1205', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1205)
#
#declareTest(1206, 'Test correct default start date')
#add_baseline(eid = '1206')
#add_gp_prescriptions(eid = '1206', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1206)
#
#declareTest(1207, 'Test end date same as start date if no quantity')
#add_baseline(eid = '1207')
#add_gp_prescriptions(eid = '1207', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1207)
#
#declareTest(1208, 'Test inferred end date if valid quantity (tablets)')
#add_baseline(eid = '1208')
#add_gp_prescriptions(eid = '1208', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1208)
#
#declareTest(1209, 'Test end date same as start date if invalid quantity (packets)')
#add_baseline(eid = '1209')
#add_gp_prescriptions(eid = '1209', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1209)
#
#declareTest(1210, 'Test numeric quantity extraction')
#add_baseline(eid = '1210')
#add_gp_prescriptions(eid = '1210', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1210)
#
#declareTest(1211, 'Test unit extraction')
#add_baseline(eid = '1211')
#add_gp_prescriptions(eid = '1211', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1211)
#
#declareTest(1212, 'Test retrieving visit occurrence id')
#add_baseline(eid = '1212')
#add_gp_prescriptions(eid = '1212', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1212)
#
#declareTest(1213, 'Test long drug source value (> 50 chars)')
#add_baseline(eid = '1213')
#add_gp_prescriptions(eid = '1213', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1213)

# add_gp_prescriptions(eid, data_provider, issue_date, read_2, bnf_code, dmd_code, drug_name, quantity)

# expecte_drug_exposure(
# person_id,
# drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date,
# drug_concept_id, drug_type_concept_id, drug_source_value, drug_source_concept_id,
# quantity, dose_unit_source_value,
# visit_occurrence_id, visit_detail_id)