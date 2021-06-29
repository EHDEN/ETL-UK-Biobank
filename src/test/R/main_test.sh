cd src/test/R
R -f run_create_tests.R
cd ../../../
python main.py -c config/config-test.yml
cd src/test/R
R -f run_evaluate_tests.R
cd ../../../