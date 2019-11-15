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
znovu <- oblasti[which(is.na(kat.url))]
n <- 0 # 3x zkusit stáhnout NA znovu
while(length(znovu) > 0 & n < 3) {
  kat.url[which(is.na(kat.url))] <- future_map(znovu, p.get.kat.url, .progress = T)
  znovu <- oblasti[which(is.na(kat.url))]
  n <- n + 1
}
kat.url <- unlist(kat.url)

# ŽS
zs.list <- future_map(kat.url, p.get.zs.url, .progress = T)
znovu <- kat.url[which(is.na(zs.list))]
n <- 0 # 3x zkusit stáhnout NA znovu
while(length(znovu) > 0 & n < 3) {
  zs.list[which(is.na(zs.list))] <- future_map(znovu, p.get.zs.url, .progress = T)
  znovu <- kat.url[which(is.na(zs.list))]
  n <- n + 1
}
zs.url <- unlist(zs.list)

# uložit nepročištěné + s oblastí a podoblastí (Bydlení - Hasiči)
# lze sestavit i z url x v př. duplicitních ne
# ŽS stahovat z neduplicitních
print(paste("pocet NA v kat. ZS:", kat.url %>% as_tibble %>% filter(is.na(value)) %>% nrow()))
print(paste("pocet NA v ZS:", zs.url %>% as_tibble %>% filter(is.na(value)) %>% nrow()))

write_rds(zs.url, paste0("output/zs.url_", Sys.Date(), ".rds"))

# import stažených ŽS
url <- read.zs.url()
url <- unique(url) # 548 = 105 duplicitních (ve více oblastech)

zs.data <- future_map(url, p.get.all, .progress = T)
zs.data <- bind_rows(zs.data)
write_tsv(zs.data, paste0("output/zs_", Sys.Date(), ".tsv"))
