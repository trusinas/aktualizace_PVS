library(rvest)
library(tidyverse)

#TODO Vytáhnout název kategorie a podkategorie

# odkazy na jednotlivé oblasti
get.oblasti.url <- function(url) {
  # url <- "https://gov.cz/obcan/zivotni-situace"
  oblasti <- url %>%
    read_html() %>% 
    html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[1]/div/ul") %>% 
    html_nodes("a") %>% 
    html_attr("href")
  oblasti <- paste0("https://gov.cz", oblasti)
  return(oblasti)
}

# odkazy na kategorie
get.kat.url <- function(link) {
  url <- link %>%
    read_html() %>% 
    html_nodes(xpath = "/html/body/div/div/div[2]/div/div[2]/div[2]/div/ul/li") %>%
    html_nodes("a") %>% 
    html_attr("href")
  url <- paste0("https://gov.cz", url)
  return(url)
}

p.get.kat.url <- possibly(get.kat.url, NA)

# odkazy na ŽS
get.zs.url <- function(link) {
  url <- link %>%
    read_html() %>% 
    html_nodes(xpath = "/html/body/div/div/div[2]/div/div[2]/div[3]/div/ul/li") %>%
    html_nodes("a") %>% 
    html_attr("href")
  # url <- paste0("https://gov.cz", url)
  url <- paste0("https://gov.cz", url, "?uplny=")
  return(url)
}

p.get.zs.url <- possibly(get.zs.url, NA)

read.zs.url <- function(...) {
  path = as.character(...)
  if(is_empty(path)) {
     path = list.files("output/", pattern = "zs.url_", full.names = T)
     path = sort(path, decreasing = T)[1]
     }
  url <- read_rds(path)
}