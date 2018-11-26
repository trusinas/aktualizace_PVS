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

write_rds(zs.url, "zs.url.rds")
