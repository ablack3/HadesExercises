# generate all cohorts on all CDMs 
# skip cohorts that have already been generated

library(ROhdsiWebApi)
library(dplyr)

baseUrl <- "https://eco.ohdsitutorials.amazingawsdemos.com/WebAPI"

sourceKey <- getCdmSources(baseUrl)$sourceKey

cohortMetaData <- getCohortDefinitionsMetaData(baseUrl) 

# get generation information for all cohorts
generationInfo <- purrr::map_dfr(cohortMetaData$id, ~getCohortGenerationInformation(., baseUrl)) 

cohortsToSkip <- generationInfo %>% 
  filter(status == "COMPLETE") %>% 
  select(id = cohortDefinitionId, sourceKey) %>% 
  distinct()

cohortsToGenerate <- cohortMetaData %>% 
  select(id, name) %>% 
  tidyr::expand_grid(sourceKey) %>% 
  anti_join(cohortsToSkip, by = c("id", "sourceKey"))

# call the invokeCohortGeneration function for each combination of cohortId and sourceKey
purrr::walk2(cohortsToGenerate$id, cohortsToGenerate$sourceKey, 
             ~invokeCohortGeneration(cohortId = .x, baseUrl = baseUrl, sourceKey = .y))
