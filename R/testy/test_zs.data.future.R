url <- read_rds("output/zs.url.rds")
url <- url[1:10]

context("future download and processing")
zs.data <- map(url, ~future(p.get.all(.x)))
zs.data <- map(zs.data, ~value(.x))
zs.data <- bind_rows(zs.data)
test_that("cela sada", {
  expect_is(zs.data, "data.frame")
  expect_equal(dim(zs.data), c(10, 7))
  expect_equal(as.vector(is.na(zs.data)), rep(F, 70))
})

context("future download and processing with bad url")
url[10] <- "https://gov.cz/obcan/zivotni-situace/bydleni/hasici/vyhlaseni-varovneho-si"
zs.data <- map(url, ~future(p.get.all(.x)))
zs.data <- map(zs.data, ~value(.x))
zs.data <- bind_rows(zs.data)
test_that("cela sada", {
  expect_is(zs.data, "data.frame")
  expect_equal(dim(zs.data), c(10, 7))
  # expect_equal(as.vector(is.na(zs.data)), (rep(F, 60))) # opravit
})