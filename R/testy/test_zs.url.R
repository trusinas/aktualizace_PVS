context('get.zs.url')
# testy na funkci
out <- get.zs.url("https://gov.cz/obcan/zivotni-situace/bydleni/hasici")
test_that('3 ŽS v bydleni/hasici', {
  expect_length(out, 3)
})
test_that('doplnění https://gov.cz/obcan do url', {
  expect_equal(startsWith(out, "https://gov.cz/obcan"), c(T, T, T))
  expect_equal(endsWith(out, "?uplny="), c(T, T, T))
})

context('p.get.zs.url')
test_that('wrong url = NA', {
  expect_equal(p.get.kat.url("https://gov.cz/obcan/zivotni-situace/bydle"), NA)
})
out <- p.get.zs.url("https://gov.cz/obcan/zivotni-situace/bydleni/hasici")
test_that('ok url bez NA', {
  expect_equal(is.na(out), c(F, F, F))
})

context('future p.get.zs.url')
kat.url <- c("https://gov.cz/obcan/zivotni-situace/bydleni/hasici", "https://gov.cz/obcan/zivotni-situace/bydleni/hasic")
out <- map(kat.url, ~future(p.get.zs.url(.x)))
out <- map(out, ~value(.x))
out <- unlist(out)
test_that("get correct results", {
  expect_length(out, 4)
  expect_equal(is.na(out), c(F, F, F, T))
})
