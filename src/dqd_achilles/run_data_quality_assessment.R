## R installation
if (!require("devtools")) install.packages("devtools")
if (!require("DatabaseConnector")) install.packages("DatabaseConnector")
if (!require("SqlRender"))("SqlRender")
if (!require("rJava"))install.packages("rJava")
if (!require("yaml")) install.packages("yaml")

library(DatabaseConnector)
library(SqlRender)
library(rJava)
library(yaml)

# Install DataQualityDashboard from v6_extensions branch
devtools::install_github(repo="OHDSI/DataQualityDashboard")

# Set working directory to directory of this R script
# setwd("c:/myPath/dqd_achilles")

# Load configuration settings
config <- yaml.load_file('config_docker.yml')
connectionConfig <- config$connectionDetails

## Executing Data Quality Checks

# fill out the connection details -----------------------------------------------------------------------
connectionDetails <- DatabaseConnector::createConnectionDetails(dbms = connectionConfig$dbms, 
                                                                server = connectionConfig$server,
                                                                user = connectionConfig$user,
                                                                password = connectionConfig$password, 
                                                                schema = connectionConfig$schema,
                                                                port = connectionConfig$port,
                                                                extraSettings = "")

resultsDatabaseSchema <- paste0(connectionConfig$schema, "_results_dqd") # the fully qualified database schema name of the results schema (that you can write to)

# run the job --------------------------------------------------------------------------------------
DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails, 
                                      cdmDatabaseSchema = connectionConfig$schema,
                                      resultsDatabaseSchema = resultsDatabaseSchema,
                                      vocabDatabaseSchema = connectionConfig$vocabDatabaseSchema,
                                      tableCheckThresholdLoc = config$tableCheckThresholdLoc,
                                      fieldCheckThresholdLoc = config$fieldCheckThresholdLoc,
                                      conceptCheckThresholdLoc = config$conceptCheckThresholdLoc,
                                      cdmSourceName = config$cdmSourceName,
                                      numThreads = config$numThreads,
                                      sqlOnly = config$sqlOnly,
                                      outputFolder = config$outputFolder,
                                      verboseMode = config$verboseMode,
                                      writeToTable = config$writeToTable,
                                      checkLevels = config$checkLevels,
                                      checkNames = config$checkNames,
                                      cdmVersion = config$cdmVersion)

# inspect logs ----------------------------------------------------------------------------
ParallelLogger::launchLogViewer(logFileName = file.path(config$outputFolder, config$cdmSourceName,
                                                        sprintf("log_DqDashboard_%s.txt", config$cdmSourceName)))

# (OPTIONAL) if you want to write the JSON file to the results table separately -----------------------------
jsonFilePath <- ""
DataQualityDashboard::writeJsonResultsToTable(connectionDetails = connectionDetails, 
                                              resultsDatabaseSchema = resultsDatabaseSchema, 
                                              jsonFilePath = jsonFilePath)

## Viewing Results
# Launching Dashboard as Shiny App
DataQualityDashboard::viewDqDashboard(jsonPath = file.path(getwd(), config$outputFolder, config$cdmSourceName, sprintf("results_%s.json", config$cdmSourceName)))

# View Checks
View(read.csv(system.file("csv","OMOP_CDMv5.3.1_Check_Descriptions.csv",package="DataQualityDashboard"),as.is=T))
