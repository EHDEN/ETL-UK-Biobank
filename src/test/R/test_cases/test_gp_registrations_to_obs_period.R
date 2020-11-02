# test ID range 300-399

declareTest(301, 'Observation Period - Start date')
add_baseline(eid = '301')

add_gp_registrations(eid = '301', reg_date = '19/03/1999')
expect_observation_period(person_id = 301, observation_period_start_date = '1999/03/19')

declareTest(302, 'Observation Period - End date')
add_baseline(eid = '302')
add_gp_registrations(eid = '302', reg_date = '27/09/2001', deduct_date = '05/11/2007')
expect_observation_period(person_id = 302, observation_period_end_date = '2007/11/05')

declareTest(303, 'Observation Period - Incomplete dates')
add_baseline(eid = '303')
add_gp_registrations(eid = '303', reg_date = '04/1985', deduct_date = '2004')
expect_observation_period(person_id = 303, observation_period_start_date = '1985/04/01',
                          observation_period_end_date = '2004/12/31')

declareTest(304, 'Observation Period - Empty dates')
add_baseline(eid = '304')
add_gp_registrations(eid = '304', reg_date = '', deduct_date = '')
expect_observation_period(person_id = 304, observation_period_start_date = '1970/01/01',
                          observation_period_end_date = '1970/01/01')

declareTest(305, 'Observation Period - Multiple record for one person')
add_baseline(eid = '305')
add_gp_registrations(eid = '305', reg_date = '20/03/1999', deduct_date = '20/05/2000')
add_gp_registrations(eid = '305', reg_date = '01/01/2000', deduct_date = '31/12/2000')
expect_observation_period(person_id = 305, observation_period_start_date = '1999-03-20',
                          observation_period_end_date = '2000-05-20')
expect_observation_period(person_id = 305, observation_period_start_date = '2000-01-01',
                          observation_period_end_date = '2000-12-31')

declareTest(306, 'Observation Period - Type concepts')
add_baseline(eid = '306')
add_gp_registrations(eid = '306')
expect_observation_period(person_id = 306, type_concept_id = 32817)

declareTest(307, 'Observation Period - No person')
add_gp_registrations(eid = '307')
expect_no_observation_period(person_id = 307)
