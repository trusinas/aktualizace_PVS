url <- "https://gov.cz/obcan/zivotni-situace/bydleni/hasici/postup-obcana-u-ktereho-vznikl-pozar-nebyl-li-pozar-likvidovan-jednotkou-pozarni-ochrany.html?uplny="
html <- url %>%
  read_html()

context("get.nazev")
out <- get.nazev(html)
test_that("nazev", {
  expect_equal(out, "Postup občana, u kterého vznikl požár (nebyl-li požár likvidován jednotkou požární ochrany)")
})

context("get.id")
out <- get.id(html)
test_that("ID", {
  expect_equal(out, "i-102-587")
})

context("get.info")
out <- get.info(html)
test_that("info", {
  expect_equal(nchar(out), 191)
})

context("get.zakon")
out <- get.zakon(html)
test_that("zakon", {
  expect_equal(out, "133/1985")
})

context("get.zpracovano")
out <- get.zpracovano(html)
test_that("zpracovano", {
  expect_equal(out, as_date("2014-01-01"))
})

context("get.aktualizace")
out <- get.aktualizace(html)
test_that("aktualizace", {
  expect_equal(out, as_date("2014-09-15"))
})

context("get.all")
out <- get.all(url)
test_that("cela sada", {
  expect_is(out, "data.frame")
  expect_equal(dim(out), c(1, 6))
  expect_equal(as.vector(is.na(out)), rep(F, 6))
})

context("p.get.all")
out <- p.get.all("https://gov.cz/obcan/zivotni-situace/bydleni/katastr-nemovitosti/poskyto")
test_that("wrong url", {
  expect_equal(out, data.frame(nazev = NA, id = NA, info = NA, zakon = NA, zpracovano = NA, 
                         aktualizace = NA))
})