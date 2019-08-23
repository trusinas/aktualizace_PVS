df <- data.frame(url = c(oblasti, kat.url, zs.url),
                 name = c(rep("oblasti", 24), rep("kat.url", 160), rep("zs.url", 729)))
df <- df %>% 
  mutate(url = str_remove_all(url, "https://gov.cz/"))
df <- df %>% 
  separate(url, c("url1", "url2", "url3", "url4", "url5"), sep = "/", remove = F)

# problém s poslední adresou (n == 1) - pro Honzu
problem <- df %>% 
  count(url4) %>% 
  arrange(n)

# kontrola úplnosti
oblasti <- df %>% 
  filter(name == "oblasti") %>% 
  pull(url3)
kat.url <- df %>% 
  filter(name == "kat.url") %>% 
  pull(url4)

# kontrola stažení celé PVS
# pro všechny kat.url zkontrolovat, že obsahují min. 1 oblast, vypustit NA u kat.url
df %>% 
  filter(name == "kat.url") %>% 
  count(url3)
df %>% 
  filter(name == "kat.url") %>% 
  filter(is.na(url3))

# chybějící oblasti x KDE - občan/podnikatel ??
chybi.kat.url <- setdiff(oblasti, df %>% 
  filter(name == "kat.url") %>% 
  count(url3) %>% 
  pull(url3))
urls <- df %>% 
  filter(url3 == chybi.kat.url[1]) %>% # TODO na map
  pull(url) %>%
  paste0("https://gov.cz/", .)
p.get.kat.url(urls[1])

# pro všechny zs.url zkontrolovat, že obsahují min. 1 kat.url, vypustit NA u zs.url
df %>% 
  filter(name == "zs.url") %>% 
  count(url4) %>% 
  arrange(n)
df %>% 
  filter(name == "zs.url") %>% 
  filter(is.na(url4))

# chybějící kategorie x KDE - občan/podnikatel ??
chybi.zs.url <- setdiff(kat.url, df %>% 
          filter(name == "zs.url") %>% 
          count(url4) %>% 
          pull(url4))

# QUESTION U chybějících zkusit stáhnout znovu?
urls <- df %>% 
  filter(url4 == chybi.zs.url[1]) %>% # TODO na map
  pull(url) %>%
  paste0("https://gov.cz/", .)
p.get.zs.url(urls[1]) # test