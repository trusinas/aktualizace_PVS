library(rvest)
library(tidyverse)
library(lubridate)

# funkce na jednotlivé údaje
get.nazev <- function(html) {
  nazev <- html %>%
    html_node(".mb-md-1") %>% 
    html_text()
}
get.gestor <- function(html) {
  gestor <- html %>%
    html_node("col-lg-4 order-lg-2, p") %>% 
    html_text()
}  
get.id <- function(html) {
  id <- html %>%
    html_node("div.mb-1") %>%
    html_text() %>% 
    # str_remove("ID Záznamu") %>% 
    str_squish() %>% 
    str_remove("ID\\s+Záznamu\\s+")
}
get.info <- function(html) {
  info <- html %>%
    html_node(".dropdown__content") %>% 
    html_text() %>% 
    str_squish()
}
get.zakon <- function(html) {
  zakon <- html %>%
    html_nodes(".dropdown__content") %>% 
    .[14] %>% 
    html_text() %>%
    str_extract("\\d{1,3}/\\d{4}")
}
get.zpracovano <- function(html) {
  zpracovano <- html %>%
    html_nodes("div.mb-1") %>% 
    .[2] %>% 
    html_text() %>% 
    str_remove("Zpracováno k datu") %>% 
    str_squish() %>% 
    dmy() # pokud chybí, gestor nezadal
}
get.aktualizace <- function(html) {
  aktualizace <- html %>%
    html_nodes("div.mb-1") %>% 
    .[3] %>% 
    html_text() %>% 
    str_remove("Poslední aktualizace") %>% 
    str_squish() %>% 
    dmy()
}

# stažení údajů
get.all <- function(url) {
  html <- url %>%
    read_html()
  nazev <- get.nazev(html)
  gestor <- get.gestor(html)
  id <- get.id(html)
  info <- get.info(html)
  zakon <- get.zakon(html)
  zpracovano <- get.zpracovano(html)
  aktualizace <- get.aktualizace(html)
  combine.data <- tibble(nazev, gestor, id, info, zakon, zpracovano, aktualizace)
}
p.get.all <- possibly(get.all, data.frame(nazev = NA, gestor = NA, id = NA, info = NA, zakon = NA,
                      zpracovano = NA, aktualizace = NA))
