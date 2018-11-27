library(tidyverse)
library(rvest)
library(future)
source("R/zs.links.R")
source("R/zs.data.R")

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

# import stažených ŽS
url <- read_rds("output/zs.url.rds")
url <- unique(url) # 548 = 105 duplicitních (ve více oblastech)

zs.data <- map(url, ~future(p.get.all(.x)))
zs.data <- map(zs.data, ~value(.x))
if (table(is.na(zs.data))[[1]] == length(zs.data)) {
  zs.data <- bind_rows(zs.data)
  write_tsv(zs.data, paste0("output/zs_", Sys.Date(), ".tsv"))
  print("Stazeni probehlo v poradu.")
} else {
  write_rds(zs.data, paste0("output/zs_", Sys.Date(), ".rds"))
  print("Je nutne rucni zpracovani stazenych dat (NA)")
}

