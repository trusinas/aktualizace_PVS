url <- c("https://gov.cz/obcan/zivotni-situace/bydleni/hasici/postup-obcana-u-ktereho-vznikl-pozar-nebyl-li-pozar-likvidovan-jednotkou-pozarni-ochrany.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/hasici/unik-nebezpecne-chemicke-latky-do-zivotniho-prostredi.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/hasici/vyhlaseni-varovneho-signalu-vseobecna-vystraha.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/katastr-nemovitosti/navrh-na-zahajeni-rizeni-o-povoleni-vkladu-do-katastru-nemovitosti.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/katastr-nemovitosti/poskytovani-udaju-z-katastru-nemovitosti.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/katastr-nemovitosti/zalozeni-zakaznickeho-uctu-pro-dalkovy-pristup-k-udajum-katastru-nemovitosti.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/katastr-nemovitosti/zaznam-prava-k-nemovitostem-do-katastru-nemovitosti.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/postovni-sluzby/baleni-postovnich-zasilek-a-jejich-nasledne-podani.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/postovni-sluzby/dodani-postovnich-zasilek-fyzickym-osobam.html?uplny=", 
  "https://gov.cz/obcan/zivotni-situace/bydleni/postovni-sluzby/nesrovnalosti-pri-poskytovani-postovnich-sluzeb.html?uplny="
)

context("future_map download and processing")
zs.data <- future_map(url, p.get.all)
zs.data <- bind_rows(zs.data)
test_that("vytvoření DF se správnými URL", {
  expect_is(zs.data, "data.frame")
  expect_equal(dim(zs.data), c(10, 6))
  expect_equal(as.vector(is.na(zs.data)), rep(F, 60))
})

context("future_map download and processing with bad url")
url[10] <- "https://gov.cz/obcan/zivotni-situace/bydleni/hasici/vyhlaseni-varovneho-si"
zs.data <- future_map(url, p.get.all)
zs.data <- bind_rows(zs.data)
test_that("vytvoření DF se špatnou URL", {
  expect_is(zs.data, "data.frame")
  expect_equal(dim(zs.data), c(10, 6))
  expect_equal(as.vector(is.na(zs.data)), rep(c(rep(F, 9), T), 6))
})
