test_that("eq_location_clean works", {
  expect_equal(eq_location_clean("ABC: DEF"), "Def")
  expect_equal(eq_location_clean("ABC: DEF: GHI"), "Ghi")
})
