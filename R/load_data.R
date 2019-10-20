#' Loads the raw NOAA significant earthquake data.
#'
#' @return a dataframe containing the raw NOAA significant earthquake data.
#'
#' @export
#'
load_data <- function() {
  readr::read_delim(file = system.file("extdata/noaa_signif_earthquake.txt", package = "earthquakes"), delim = "\t", quote = '\"', guess_max = 100000)
}
