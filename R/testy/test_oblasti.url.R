# get.oblasti.url()
context('get.oblasti.url')
out <- get.oblasti.url()
test_that('right length', {
  expect_length(out, 13)
})

test_that('doplnění https://gov.cz/obcan do url', {
  expect_equal(startsWith(out, "https://gov.cz/obcan"), rep(T, 13))
})
# error
# NA