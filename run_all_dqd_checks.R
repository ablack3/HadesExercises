library(DatabaseConnector)
connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             # password = keyring::key_get(), 
                                             # password = rstudioapi::askForPassword(),
                                             port = "5439")

# dqChecks <- DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails,
#                                                   cdmDatabaseSchema = "mycdm.synthea23m", 
#                                                   resultsDatabaseSchema = "mycdm.synthea23mresults",
#                                                   writeToTable = F,
#                                                   cdmSourceName = "Synthea23m",
#                                                   outputFolder = "~/synthea23mDQChecks")
# 
# DataQualityDashboard::viewDqDashboard("~/synthea23mDQChecks/Synthea23m/results_Synthea23m.json")

dqChecks <- DataQualityDashboard::executeDqChecks(connectionDetails = connectionDetails,
                                                  cdmDatabaseSchema = "mycdm.cmsdesynpuf23m", 
                                                  resultsDatabaseSchema = "mycdm.cmsdesynpuf23mresults",
                                                  writeToTable = F,
                                                  cdmSourceName = "Synpuf23m",
                                                  outputFolder = "~/DQChecks")

DataQualityDashboard::viewDqDashboard("~/DQChecks/Synpuf23m/results_Synpuf23m.json")
