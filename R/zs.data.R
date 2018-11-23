library(rvest)
library(tidyverse)
library(lubridate)
library(pbapply) # library(devtools) ; install_github("psolymos/pbapply")

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
get.info <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_node(".dropdown__content") %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info2 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[2] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info3 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[3] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info4 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[4] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info5 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[5] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info6 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[6] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info7 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[7] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info8 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[8] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info9 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[9] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info10 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[10] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info11 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[11] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info12 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[12] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info13 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[13] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info14 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[14] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info15 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[15] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info16 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[16] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info17 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[17] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info18 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[18] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info19 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[19] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info20 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[20] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info21 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[21] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info22 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[22] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info23 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[23] %>% 
    html_text() %>% 
    str_replace_all("\\s+", " ") %>% 
    str_trim()
}
get.info24 <- function(html) { # celkem 24x
  info <- html %>%  # ok
    html_nodes(".dropdown__content") %>% 
    .[24] %>% 
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
get.oblast <- function(html) {
  oblast <- html %>%
    html_node(".breadcrumb--white") %>%
    html_nodes("a") %>%
    .[3] %>% 
    html_text()
}
get.podoblast <- function(html) {
  oblast <- html %>%
    html_node(".breadcrumb--white") %>%
    html_nodes("a") %>%
    .[4] %>% 
    html_text()
}

# import stažených ŽS
url <- readRDS("zs.url.rds")
url <- unique(url) # 548 = 105 duplicitních (ve více oblastech)
# url <- url[1:20] pro test

# stažení údajů
get.df <- function(url) {
  html <- url %>%
    read_html()
  nazev <- get.nazev(html)
  gestor <- get.gestor(html)
  id <- get.id(html)
  info <- get.info(html)
  info2 <- get.info2(html)
  info3 <- get.info3(html)
  info4 <- get.info4(html)
  info5 <- get.info5(html)
  info6 <- get.info6(html)
  info7 <- get.info7(html)
  info8 <- get.info8(html)
  info9 <- get.info9(html)
  info10 <- get.info10(html)
  info11 <- get.info11(html)
  info12 <- get.info12(html)
  info13 <- get.info13(html)
  info14 <- get.info14(html)
  info15 <- get.info15(html)
  info16 <- get.info16(html)
  info17 <- get.info17(html)
  info18 <- get.info18(html)
  info19 <- get.info19(html)
  info20 <- get.info20(html)
  info21 <- get.info21(html)
  info22 <- get.info22(html)
  info23 <- get.info23(html)
  info24 <- get.info24(html)
  zpracovano <- get.zpracovano(html)
  aktualizace <- get.aktualizace(html)
  oblast <- get.oblast(html)
  podoblast <- get.podoblast(html)
  combine.data <- tibble(nazev, gestor, id, info, info2, info3, info4, info5, info6, info7, info8, info9, info10, info11, info12, info13, info14, info15, info16, info17, info18, info19, info20, info21, info22, info23, info24, zpracovano, aktualizace, oblast, podoblast)
}

# var. s listem + uložit
# data.zs <- map(url, safely(get.df))
pboptions(type = "txt")
data.zs <- pblapply(url, safely(get.df))
data.zs <- data.zs %>% transpose()
is_ok <- data.zs$error %>% map_lgl(is_null)
chybi_zs <- map(data.zs$result, nrow)
chybi_zs <- unlist(chybi_zs)
table(is_ok) # kolik správně stažených
table(chybi_zs) # kolik špatně stažených
# url[which(is_ok == F)] # kontrola url s chybou
# saveRDS(data.zs$result, "zs.data.rds")
# saveRDS(data.zs$error, "errors.rds")
data <- bind_rows(data.zs$result)
write_tsv(data, paste0("zs_", Sys.Date(), ".tsv"))