# test ID range 1700-1799

declareTest(1700, 'Test no drug exposure if no drug fields available')
add_baseline(eid = '1700')
add_gp_prescriptions(eid = '1700', dmd_code = NULL, read_2 = NULL, drug_name = NULL)
expect_no_drug_exposure(person_id = 1700)

# dm+d -> trimethoprim 100 MG Oral Tablet
declareTest(1701, 'Test drug fields priority when all drug fields available')
add_baseline(eid = '1701')
add_gp_prescriptions(eid = '1701', dmd_code = '324430000', read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1701, drug_concept_id = 1705676, drug_source_concept_id = 21199984, drug_source_value = '324430000', drug_type_concept_id=38000177)

 # Read v2 -> Acetaminophen 500 MG Oral Tablet
declareTest(1702, 'Test drug fields priority when only Read v2 & drug name available')
add_baseline(eid = '1702')
add_gp_prescriptions(eid = '1702', dmd_code = NULL, read_2 = 'di21.', drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1702, drug_concept_id = 41091617, drug_source_concept_id = 0, drug_source_value = 'di21.', drug_type_concept_id=38000177)

# drug name -> ibuprofen 200 MG Oral Tablet
declareTest(1703, 'Test drug fields priority when only drug name available')
add_baseline(eid = '1703')
add_gp_prescriptions(eid = '1703', dmd_code = NULL, read_2 = NULL, drug_name = 'Ibuprofen 200mg tablets')
expect_drug_exposure(person_id = 1703, drug_concept_id = 19078461, drug_source_concept_id = 0, drug_source_value = 'Ibuprofen 200mg tablets', drug_type_concept_id=38000177)

declareTest(1704, 'Test data source code creation')
add_baseline(eid = '1704')
add_gp_prescriptions(eid = '1704', dmd_code = '324430000', data_provider = 1)
expect_drug_exposure(person_id = 1704, data_source = 'GP-1')

# PLACEHOLDERS

#declareTest(1705, 'Test correct start date format')
#add_baseline(eid = '1705')
#add_gp_prescriptions(eid = '1705', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1705)
#
#declareTest(1706, 'Test correct default start date')
#add_baseline(eid = '1706')
#add_gp_prescriptions(eid = '1706', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1706)
#
#declareTest(1707, 'Test end date same as start date if no quantity')
#add_baseline(eid = '1707')
#add_gp_prescriptions(eid = '1707', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1707)
#
#declareTest(1708, 'Test inferred end date if valid quantity (tablets)')
#add_baseline(eid = '1708')
#add_gp_prescriptions(eid = '1708', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1708)
#
#declareTest(1709, 'Test end date same as start date if invalid quantity (packets)')
#add_baseline(eid = '1709')
#add_gp_prescriptions(eid = '1709', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1709)
#
#declareTest(1710, 'Test numeric quantity extraction')
#add_baseline(eid = '1710')
#add_gp_prescriptions(eid = '1710', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1710)
#
#declareTest(1711, 'Test unit extraction')
#add_baseline(eid = '1711')
#add_gp_prescriptions(eid = '1711', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1711)
#
#declareTest(1712, 'Test retrieving visit occurrence id')
#add_baseline(eid = '1712')
#add_gp_prescriptions(eid = '1712', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1712)
#
#declareTest(1713, 'Test long drug source value (> 50 chars)')
#add_baseline(eid = '1713')
#add_gp_prescriptions(eid = '1713', dmd_code = '324430000')
#expect_drug_exposure(person_id = 1713)

# add_gp_prescriptions(eid, data_provider, issue_date, read_2, bnf_code, dmd_code, drug_name, quantity)

# expecte_drug_exposure(
# person_id,
# drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date,
# drug_concept_id, drug_type_concept_id, drug_source_value, drug_source_concept_id,
# quantity, dose_unit_source_value,
# visit_occurrence_id, visit_detail_id)