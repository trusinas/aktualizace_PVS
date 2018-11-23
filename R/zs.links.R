library(rvest)
library(tidyverse)
library(future)

# odkazy na jednotlivé oblasti
oblasti <- "https://gov.cz/obcan/zivotni-situace"
oblasti <- oblasti %>% 
  read_html() %>% 
  html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[1]/div/ul") %>% 
  html_nodes("a") %>% 
  html_attr("href")
url.oblasti <- paste0("https://gov.cz", oblasti)

# odkazy na kategorie
get.kat.links <- function(link) {
  link %>%
    read_html() %>% 
    html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[2]") %>%
    html_nodes("a") %>% 
    html_attr("href")
}
plan(multiprocess)
# kat.url <- map(url.oblasti, possibly(get.kat.links, NA)) # 1.762263 mins
kat.url <- map(url.oblasti, ~future(get.kat.links(.x))) # paralel 2.708643 secs
kat.url <- map(kat.url, value)
kat.url <- unlist(kat.url) # 127 (všechny unikátní)
kat.url <- paste0("https://gov.cz", kat.url)

# odkazy na ŽS
get.zs.links <- function(link) {
  link %>%
    read_html() %>% 
    html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[2]/div") %>%
    html_nodes("a") %>% 
    html_attr("href")
}
list.zs <- map(kat.url, possibly(get.zs.links, NA))
url <- unlist(list.zs)
print(paste("chybi stazenych ZS", table(is.na(url)) %>% 
  map("TRUE")))
# uložit nepročištěné + s oblastí a podoblastí (Bydlení - Hasiči)
# lze sestavit i z url x v př. duplicitních ne
# ŽS stahovat z neduplicitních
url <- paste0("https://gov.cz", url, "?uplny=") # dosáhnu jednotné struktury (vždy 24 bodů)
write_rds(url, "output/zs.url.rds")
