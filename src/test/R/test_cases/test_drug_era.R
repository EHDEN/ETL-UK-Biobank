# test ID range 2100-2199

# dm+d -> trimethoprim 100 MG Oral Tablet
declareTest(2100, 'Test one exposure to drug era')
add_baseline(eid = '2100')
add_gp_prescriptions(eid = '2100', dmd_code = '324430000', issue_date = '01/01/2021')
expect_drug_era(person_id = 2100, drug_concept_id = 1705674, drug_era_start_date = '2021-01-01')

# dm+d -> ibuprofen
declareTest(2101, 'Test two exposure to one drug era')
add_baseline(eid = '2101')
add_gp_prescriptions(eid = '2101', dmd_code = '387207008', issue_date = '02/01/2021', quantity = '10 tablets')
add_gp_prescriptions(eid = '2101', dmd_code = '387207008', issue_date = '12/01/2021', quantity = '10 tablets')
expect_count_drug_era(1, person_id = 2101)
expect_drug_era(person_id = 2101, drug_concept_id = 1177480, drug_era_start_date = '2021-01-02', drug_era_end_date = '2021-01-21')
