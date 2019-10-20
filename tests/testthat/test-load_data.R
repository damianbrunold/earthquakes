test_that("load_data returns data frame", {
  expect_is(load_data(), "data.frame")
})
