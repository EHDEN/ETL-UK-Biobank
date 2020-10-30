# test ID range 300-399

declareTest(301, 'Test start date')
add_gp_registrations(eid = '301', reg_date = '19/03/1999')
expect_observation_period(person_id = 301, observation_period_start_date = '1999/03/19')

declareTest(302, 'Test end date')
add_gp_registrations(eid = '302', reg_date = '27/09/2001', deduct_date = '05/11/2007')
expect_observation_period(person_id = 302, observation_period_end_date = '2007/11/05')

declareTest(303, 'Test fall back dates')
add_gp_registrations(eid = '303', reg_date = '04/1985', deduct_date = '2004')
expect_observation_period(person_id = 303, observation_period_start_date = '1985/04/01',
                          observation_period_end_date = '2004/12/31')

declareTest(304, 'Test fall back dates')
add_gp_registrations(eid = '304', reg_date = '', deduct_date = '')
expect_observation_period(person_id = 304, observation_period_start_date = '1970/01/01',
                          observation_period_end_date = '1970/01/01')
