library(rvest)
library(tidyverse)

# odkazy na jednotlivé oblasti
get.oblasti.url <- function() {
  url <- "https://gov.cz/obcan/zivotni-situace"
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
    html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[2]") %>%
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
    html_nodes(xpath = "/html/body/div/div/div[3]/div/div[2]/div[2]/div") %>%
    html_nodes("a") %>% 
    html_attr("href")
  return(url)
}
