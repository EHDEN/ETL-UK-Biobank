# IDs 2200-2299

declareTest(2200, 'Take minimum and maximum date - one date for each, baseline is min, hes is max')
add_baseline(eid = 2200, `53-0.0`='2000-01-01', `53-1.0`='2000-07-01')
add_hesin(eid = 2200, admimeth = '2010-01-01', disdate='2010-07-01')
expect_observation_period(person_id=2200, observation_period_start_date = '2000-01-01', observation_period_end_date = '2010-07-01')
