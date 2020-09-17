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
source('TestFramework.R')
initFramework() 
# NOTE: add any custom table here! (remove the following if unused)
source('custom_tables/TreatmentLine.R')

# Import test cases ------------------------------------------------------------
# NOTE: add your test cases here! (remove the following)
source('test_cases/test_sample_source_to_person.R')

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
