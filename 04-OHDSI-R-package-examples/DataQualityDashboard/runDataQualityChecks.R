library(DataQualityDashboard)

connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             port = "5439")

outputFolder <- "~/HadesExercises/04-OHDSI-R-package-examples/DataQualityDashboard/DQChecks"

dqChecks <- executeDqChecks(connectionDetails = connectionDetails,
                            cdmDatabaseSchema = "mycdm.synthea1k",
                            resultsDatabaseSchema = "mycdm.synthea1kresults",
                            writeToTable = F,
                            cdmSourceName = "Synthea1k",
                            outputFolder = outputFolder)

# viewDqDashboard(paste0(outputFolder, "/Synthea1k/results_Synthea1k.json"))

# view prior results
# viewDqDashboard("~/HadesExercises/04-OHDSI-R-package-examples/DataQualityDashboard/DQD_results/DQD_results_Synpuf23m.json")
# viewDqDashboard("~/HadesExercises/04-OHDSI-R-package-examples/DataQualityDashboard/DQD_results/DQD_results_Synthea23m.json")
