test_that("eq_clean_data creates DATE column", {
  data <- load_data() %>% eq_clean_data()
  expect_true("DATE" %in% colnames(data))
})


test_that("eq_clean_data convert long/lat columns", {
  data <- load_data() %>% eq_clean_data()
  expect_true(is.numeric(data$LATITUDE))
  expect_true(is.numeric(data$LONGITUDE))
})
