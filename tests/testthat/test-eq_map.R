test_that("eq_map returns leaflet object", {
  map <- load_data() %>%
    eq_clean_data() %>%
    dplyr::filter(COUNTRY == "TURKEY", YEAR > 2005) %>%
    eq_map(annot_col = "COUNTRY")
  expect_is(map, "leaflet")
})
