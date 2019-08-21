library(rvest)
library(tidyverse)
library(lubridate)

# funkce na jednotlivé údaje
get.nazev <- function(html) {
  nazev <- html %>%
    html_node(xpath = "/html/body/div/div/div[2]/div/div[2]/div/div[1]/h2") %>% 
    html_text()
}

get.id <- function(html) {
  id <- html %>%
    html_node(xpath = "/html/body/div/div/div[2]/div/div[2]/div/div[2]/div[1]/div[1]/span") %>%
    html_text() %>% 
    # str_remove("ID Záznamu") %>% 
    str_squish() %>% 
    str_remove("ID\\s+Záznamu\\s+")
}
get.info <- function(html) {
  info <- html %>%
    html_node(".accordion__content") %>% 
    html_text() %>% 
    str_squish()
}
get.zakon <- function(html) {
  zakon <- html %>%
    html_nodes(".accordion__content") %>% 
    .[14] %>% 
    html_text() %>%
    str_extract("\\d{1,3}/\\d{4}")
}
get.zpracovano <- function(html) {
  zpracovano <- html %>%
    html_node(xpath = "/html/body/div/div/div[2]/div/div[2]/div/div[2]/div[1]/div[2]/span") %>% 
    html_text() %>% 
    str_squish() %>% 
    dmy() # pokud chybí, gestor nezadal
}
get.aktualizace <- function(html) {
  aktualizace <- html %>%
    html_node(xpath = "/html/body/div/div/div[2]/div/div[2]/div/div[2]/div[1]/div[3]/span") %>% 
    html_text() %>% 
    str_squish() %>% 
    dmy()
}

# stažení údajů
get.all <- function(url) {
  html <- url %>%
    read_html()
  nazev <- get.nazev(html)
  id <- get.id(html)
  info <- get.info(html)
  zakon <- get.zakon(html)
  zpracovano <- get.zpracovano(html)
  aktualizace <- get.aktualizace(html)
  combine.data <- tibble(nazev, id, info, zakon, zpracovano, aktualizace)
}
p.get.all <- possibly(get.all, data.frame(nazev = NA, id = NA, info = NA, zakon = NA,
                      zpracovano = NA, aktualizace = NA))
