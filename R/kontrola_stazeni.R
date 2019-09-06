df <- tibble(url = c(oblasti, kat.url, zs.url),
                 name = c(rep("oblasti", length(oblasti)), rep("kat.url", length(kat.url)), rep("zs.url", length(zs.url))))
df <- df %>% 
  mutate(url = str_remove_all(url, "https://gov.cz/"))
df <- df %>% 
  separate(url, c("url1", "url2", "url3", "url4", "url5"), sep = "/", remove = F)

# kontrola stažení celé PVS
# problém s poslední adresou (n == 1), nebo špatná url (https://gov.cz?uplny=) - pro Honzu
problem <- df %>% 
  count(url4) %>% 
  filter(n == 1 | is.na(n)) %>% 
  left_join(df, by = "url4") %>% 
  pull(url) %>% 
  paste0("https://gov.cz/", .)
chybi <- kat.url[c(which(zs.list == "https://gov.cz?uplny="), which(is.na(zs.list)))]
vse <- c(problem, chybi)
vse <- unique(vse)
