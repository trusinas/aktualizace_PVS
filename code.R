library(tidyverse)
library(rvest)
library(future)
library(furrr)
source("R/zs.links.R")
source("R/zs.data.R")

# oblasti
oblasti <- c("https://gov.cz/obcan/zivotni-situace", "https://gov.cz/podnikani/zivotni-situace") %>% 
  map(get.oblasti.url) %>% 
  unlist(use.names = F)

# podoblasti
plan(multiprocess)
kat.url <- future_map(oblasti, p.get.kat.url, .progress = T)
kat.url <- unlist(kat.url)

# ŽS
zs.list <- future_map(kat.url, p.get.zs.url, .progress = T)
zs.url <- unlist(zs.list)
# TODO kontrola kat.url oproti oblasti a zs.url oproti kat.url

# uložit nepročištěné + s oblastí a podoblastí (Bydlení - Hasiči)
# lze sestavit i z url x v př. duplicitních ne
# ŽS stahovat z neduplicitních
print(paste("pocet NA v kat. ZS:", table(is.na(kat.url))[2])) #TODO předělat
print(paste("pocet NA v ZS:", table(is.na(zs.url))[2])) #TODO předělat

write_rds(zs.url, paste0("output/zs.url_", Sys.Date(), ".rds"))

# import stažených ŽS
url <- read.zs.url()
url <- unique(url) # 548 = 105 duplicitních (ve více oblastech)

zs.data <- map(url, ~future(p.get.all(.x)))
zs.data <- map(zs.data, ~value(.x))
zs.data <- bind_rows(zs.data)
write_tsv(zs.data, paste0("output/zs_", Sys.Date(), ".tsv"))

