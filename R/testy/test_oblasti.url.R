# get.oblasti.url()
context('get.oblasti.url')
out <- get.oblasti.url("https://gov.cz/podnikani/zivotni-situace")
test_that('right length', {
  expect_length(out, 11)
})

test_that('doplnění https://gov.cz/obcan do url', {
  expect_equal(startsWith(out, "https://gov.cz/podnikani"), rep(T, 11))
})
# error
# NA