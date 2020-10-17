
# Make sure that cdm source has at least one row - this fix should be applied before the tutorial.
# causes error in dqd
executeSql(conn, "insert into synthea1k.cdm_source (cdm_source_name) values ('synthea1k');")
executeSql(conn, "insert into synthea100k.cdm_source (cdm_source_name) values ('synthea100k');")
executeSql(conn, "insert into synthea23m.cdm_source (cdm_source_name) values ('synthea23m');")

executeSql(conn, "insert into cmsdesynpuf1k.cdm_source (cdm_source_name) values ('cmsdesynpuf1k');")
executeSql(conn, "insert into cmsdesynpuf100k.cdm_source (cdm_source_name) values ('cmsdesynpuf100k');")
executeSql(conn, "insert into cmsdesynpuf23m.cdm_source (cdm_source_name) values ('cmsdesynpuf23m');")

# Also add TZ="Etc/Universal" to .Renvion

# copy files to all home directories
library(tidyverse)
dirs <- list.files("/home") %>%
# dirs <- system("ls /home", T) %>% 
  str_subset("User") 

df <- tibble(dir = paste0("/home/", dirs))
list.dirs("/home/User1")
list.files("/home/User1")
list.files("/home/Anthony")

system("sudo ls /home/User1", intern = T)
df %>% 
  mutate(ls = map(dir, list.files))
