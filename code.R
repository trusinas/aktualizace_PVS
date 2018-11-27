library(tidyverse)
library(rvest)
library(future)
source("R/zs.links.R")

# oblasti
oblasti <- get.oblasti.url()

# podoblasti
plan(multiprocess)
kat.url <- map(oblasti, ~future(p.get.kat.url(.x)))
kat.url <- map(kat.url, ~value(.x))
kat.url <- unlist(kat.url)

# ŽS
zs.list <- map(kat.url, ~future(p.get.zs.url(.x)))
zs.list <- map(zs.list, ~value(.x))
zs.url <- unlist(zs.list)
# uložit nepročištěné + s oblastí a podoblastí (Bydlení - Hasiči)
# lze sestavit i z url x v př. duplicitních ne
# ŽS stahovat z neduplicitních
print(paste("pocet NA v kat. ZS:", table(is.na(kat.url))[2]))
print(paste("pocet NA v ZS:", table(is.na(zs.url))[2]))

write_rds(zs.url, "output/zs.url.rds")


# k opravě ------------------------------------------------------------------


# import stažených ŽS
url <- readRDS("zs.url.rds")
url <- unique(url) # 548 = 105 duplicitních (ve více oblastech)
# url <- url[1:20] pro test



# var. s listem + uložit
# data.zs <- map(url, safely(get.df))
pboptions(type = "txt")
data.zs <- pblapply(url, safely(get.df))
data.zs <- data.zs %>% transpose()
is_ok <- data.zs$error %>% map_lgl(is_null)
chybi_zs <- map(data.zs$result, nrow)
chybi_zs <- unlist(chybi_zs)
table(is_ok) # kolik správně stažených
table(chybi_zs) # kolik špatně stažených
# url[which(is_ok == F)] # kontrola url s chybou
# saveRDS(data.zs$result, "zs.data.rds")
# saveRDS(data.zs$error, "errors.rds")
data <- bind_rows(data.zs$result)
write_tsv(data, paste0("zs_", Sys.Date(), ".tsv"))