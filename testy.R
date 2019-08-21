library(testthat)

source("R/zs.links.R")
# test_dir("R/testy/")
library(future)
test_file("R/testy/test_oblasti.url.R")
test_file("R/testy/test_kat.url.R")
test_file("R/testy/test_zs.url.R")

source("R/zs.data.R")
test_file("R/testy/test_zs.data.R")
# test_file("R/testy/test_zs.data.future.R")
