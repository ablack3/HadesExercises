library(CohortDiagnostics)

baseUrl <- "https://eco.ohdsitutorials.amazingawsdemos.com/WebAPI"

connectionDetails <- createConnectionDetails(dbms = "redshift",
                                             user = "master",
                                             server = Sys.getenv("DB_SERVER"),
                                             password = Sys.getenv("DB_PASSWORD"),
                                             port = "5439")

# Get all cohorts
cohortMetadata <- ROhdsiWebApi::getCohortDefinitionsMetaData(baseUrl)

# Get all databases
databaseIds <- ROhdsiWebApi::getCdmSources(baseUrl)

# Create a dataframe with cohorts that we want to run diagnostics on
# Note these cohorts must be generated on the datasets we are using
cohortSetReference <- cohortMetadata %>% 
  filter(stringr::str_detect(name, "LEGEND|Legend")) %>% 
  mutate(atlasId = id,
         atlasName = name,
         cohortId = id,
         name = stringr::str_remove_all(name, "LEGEND|Legend|\\W")) %>% 
  select(atlasId, atlasName, cohortId, name)


CohortDiagnostics::runCohortDiagnostics(baseUrl = baseUrl,
                                        connectionDetails = connectionDetails,
                                        cdmDatabaseSchema = "mycdm.synthea100k",
                                        cohortDatabaseSchema = "mycdm.synthea100kresults",
                                        cohortTable = "cohort", 
                                        cohortSetReference = cohortSetReference,
                                        exportFolder = "~/cohortDiagnosticsExport",
                                        runInclusionStatistics = F,
                                        databaseId = "synthea100k",
                                        databaseName = "Synthea100k",
                                        databaseDescription = "Synthea100k")
# run on a second database
CohortDiagnostics::runCohortDiagnostics(baseUrl = baseUrl,
                                        connectionDetails = connectionDetails,
                                        cdmDatabaseSchema = "mycdm.CMSDESynPUF1k",
                                        cohortDatabaseSchema = "mycdm.CMSDESynPUF1kresults",
                                        cohortTable = "cohort", 
                                        cohortSetReference = cohortSetReference,
                                        exportFolder = "~/cohortDiagnosticsExport",
                                        runInclusionStatistics = F,
                                        databaseId = "CMSDESynPUF1k",
                                        databaseName = "CMSDESynPUF1k",
                                        databaseDescription = "CMSDESynPUF1k")

# Combine results into a single file
preMergeDiagnosticsFiles("~/cohortDiagnosticsExport")

# View the results
# CohortDiagnostics::launchDiagnosticsExplorer("~/cohortDiagnosticsExport")



