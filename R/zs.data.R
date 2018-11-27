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
  gestor <- html %>%  # ok
    html_node("col-lg-4 order-lg-2, p") %>% 
    html_text()
}  
get.id <- function(html) {
  id <- html %>% # ok
    html_node("div.mb-1") %>%
    html_text() %>% 
    str_remove("ID Záznamu") %>% 
    str_remove_all("\\s+")
}
get.info <- function(html) {
  info <- html %>%  # ok
    html_node(".dropdown__content") %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.zakon <- function(html) {
  zakon <- html %>%  # ok
    html_node(".dropdown__content") %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.zpracovano <- function(html) {
  zpracovano <- html %>%  # ok
    html_nodes("div.mb-1") %>% 
    .[2] %>% 
    html_text() %>% 
    str_remove("Zpracováno k datu") %>% 
    str_remove_all("\\s+") %>% 
    dmy() # pokud chybí, gestor nezadal
}
get.aktualizace <- function(html) {
  aktualizace <- html %>%  # ok
    html_nodes("div.mb-1") %>% 
    .[3] %>% 
    html_text() %>% 
    str_remove("Poslední aktualizace") %>% 
    str_remove_all("\\s+") %>% 
    dmy()
}

# stažení údajů
get.df <- function(url) {
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
