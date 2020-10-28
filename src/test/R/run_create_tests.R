# Copyright 2020 The Hyve
#
# Licensed under the GNU General Public License, version 3,
# or (at your option) any later version (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.gnu.org/licenses/
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

library(yaml)
config <- yaml.load_file('config.yml')

# Initialize the framework once -------------------------------------------
# NOTE: remove initFramework() from TestFramework.R, otherwise it resets with every import!
source('TestFramework_ukbb.R')
initFramework()

# Import test cases ------------------------------------------------------------
# source('test_cases/test_assessment_center_to_location.R')   # test IDs    1-99
source('test_cases/test_covid_to_care_site.R')              # test IDs 100-199
# source('test_cases/test_baseline_to_person.R')              # test IDs 200-299
# source('test_cases/test_gp_registrations_to_obs_period.R')  # test IDs 300-399
# source('test_cases/test_gp_clinical_to_visit_occurrence.R') # test IDs 400-499
# source('test_cases/test_gp_clinical_to_stem_table.R')       # test IDs 500-599

# Generate source csv files -----------------------------------------------------
dir.create(config$sourceDataDir, recursive=T, showWarnings = F)
writeSourceCsv(config$sourceDataDir)
print(paste0('Test source tables written to ', config$sourceDataDir))

# Create test query -------------------------------------------------------
testSql <- generateTestSql(config$cdmSchema)
dir.create(dirname(config$testQueryFileName), recursive=T, showWarnings = F)
write(testSql, config$testQueryFileName)
print(paste0('Test queries written to ', config$testQueryFileName))

# Test coverages -----------------------------------------------------------
print(summaryTestFramework())
print(getUntestedSourceFields())
print(getUntestedTargetFields())

# List all test cases ----------------------------------------------------------
exportTestsOverviewToFile('all_test_cases.csv')
