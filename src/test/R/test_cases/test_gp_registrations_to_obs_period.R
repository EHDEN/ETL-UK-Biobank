# test ID range 300-399

declareTest(301, 'Test start date')
add_gp_registrations(eid = '301', reg_date = '1999/03/19')
expect_observation_period(person_id = 301, observation_period_start_date = '1999/03/19')

declareTest(302, 'Test end date')
add_gp_registrations(eid = '302', deduct_date = '2007/11/05')
expect_observation_period(person_id = 302, observation_period_end_date = '2007/11/05')

declareTest(303, 'Test fall back dates')
add_gp_registrations(eid = '303', deduct_date = '04/23')
expect_observation_period(person_id = 303, observation_period_start_date = '1970/07/01',
                          observation_period_end_date = '1970/07/01')
