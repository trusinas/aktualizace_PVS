context('get.kat.url')
# testy na funkci
out <- get.kat.url("https://gov.cz/obcan/zivotni-situace/bydleni")
test_that('kat bydleni vrátí 6 výsledků', {
  expect_length(out, 6)
})
test_that('doplnění https://gov.cz/obcan do url', {
  expect_equal(startsWith(get.kat.url("https://gov.cz/obcan/zivotni-situace/bydleni"),
                         "https://gov.cz/obcan"), c(T, T, T, T, T, T))
})

context('p.get.kat.url')
test_that('wrong url = NA', {
  expect_equal(p.get.kat.url("https://gov.cz/obcan/zivotni-situace/bydle"), NA)
})
out <- p.get.kat.url("https://gov.cz/obcan/zivotni-situace/bydleni")
test_that('ok url bez NA', {
  expect_equal(is.na(out), c(F, F, F, F, F, F))
})

context('future_map p.get.kat.url')
oblasti <- c("https://gov.cz/obcan/zivotni-situace/bydleni", "https://gov.cz/obcan/zivotni-situace/bydle")
out <- future_map(oblasti, p.get.kat.url)
out <- unlist(out)
test_that("get correct results", {
  expect_length(out, 7)
  expect_equal(is.na(out), c(F, F, F, F, F, F, T))
})

