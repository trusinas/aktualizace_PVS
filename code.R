library(tidyverse)
library(rvest)
source("R/zs.links.R")

# oblasti
oblasti <- get.oblasti.url()

# podoblasti
kat.url <- map(oblasti, p.get.kat.url)
kat.url <- unlist(kat.url) # 127 (všechny unikátní)

# ŽS
zs.list <- map(kat.url, get.zs.url)
zs.url <- unlist(zs.list) # 653
# uložit nepročištěné + s oblastí a podoblastí (Bydlení - Hasiči)
# lze sestavit i z url x v př. duplicitních ne
# ŽS stahovat z neduplicitních
zs.url <- paste0("https://gov.cz", zs.url, "?uplny=") # dosáhnu jednotné struktury (vždy 24 bodů)
write_rds(zs.url, "zs.url.rds")
