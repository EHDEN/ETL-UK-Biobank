# test IDs 500-599

declareTest(500, 'Test covid to visit occurrence 1')
add_baseline(eid = 500)
add_covid(eid = 500, specdate = '09/04/2020', laboratory = 46)
expect_visit_occurrence(person_id = 500, visit_start_date = '2020-04-09', visit_end_date = '2020-04-09', care_site_id = 46)

declareTest(501, 'Test covid to visit occurrence 2')
add_baseline(eid = 501)
add_covid(eid = 501, specdate = '29/04/2020', laboratory = 52)
expect_visit_occurrence(person_id = 501, visit_start_date = '2020-04-29', visit_end_date = '2020-04-29', care_site_id = 52)