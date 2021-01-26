# test IDs 500-599

declareTest(500, 'Covid to visit occurrence 1')
add_baseline(eid = 500)
add_covid(eid = 500, specdate = '09/04/2020', laboratory = 46)
expect_visit_occurrence(person_id = 500, visit_start_date = '2020-04-09', visit_end_date = '2020-04-09', care_site_id = 46)

declareTest(501, 'Covid to visit occurrence 2')
add_baseline(eid = 501)
add_covid(eid = 501, specdate = '29/04/2020', laboratory = 52)
expect_visit_occurrence(person_id = 501, visit_start_date = '2020-04-29', visit_end_date = '2020-04-29', care_site_id = 52)

declareTest(502, 'Two covid records on the same date')
add_baseline(eid = 502)
add_covid(eid = 502, specdate = '26/01/2021')
add_covid(eid = 502, specdate = '26/01/2021')
expect_count_visit_occurrence(1, person_id = 502, visit_start_date = '2021-01-26')