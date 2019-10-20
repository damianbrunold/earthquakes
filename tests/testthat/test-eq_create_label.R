test_that("eq_create_label returns a proper html label", {
  data <- data.frame(LOCATION_NAME = c("A", "A", NA, "A"),
                     EQ_PRIMARY = c(5, NA, 4, 3),
                     TOTAL_DEATHS = c(NA, 10, 20, 30))
  expected <- c("<p><strong>Location:</strong> A </p> <p><strong>Magnitude:</strong> 5 </p>",
                "<p><strong>Location:</strong> A </p> <p><strong>Total deaths:</strong> 10 </p>",
                " <p><strong>Magnitude:</strong> 4 </p> <p><strong>Total deaths:</strong> 20 </p>",
                "<p><strong>Location:</strong> A </p> <p><strong>Magnitude:</strong> 3 </p> <p><strong>Total deaths:</strong> 30 </p>")
  expect_equal(eq_create_label(data), expected)
})
