# test ID range 100-199

declareTest(100, 'Test care site id = 1')
add_covid(eid = 100, laboratory = 1)
expect_care_site(care_site_id = 1, care_site_source_value = '1')

declareTest(101, 'Test care site id = 5')
add_covid(eid = 101, laboratory = 5)
expect_care_site(care_site_id = 5, care_site_source_value = '5')