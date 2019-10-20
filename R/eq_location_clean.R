#' Cleans up location names
#'
#' The NOAA significant earthquake dataset contains location names
#' that are all uppercase and consist of country, optionally region
#' and location, separated by a colon.
#'
#' This function strips country and region and converts the location
#' to title case.
#'
#' @examples
#' \dontrun{
#' data <- readr::read_delim("noaa_signif_earthquake.txt", delim = "\t")
#' clean_data <- eq_location_clean(data)
#' }
#'
#' @param location a character vector containing the raw location names
#' @return the cleaned up location names character vector
#'
#' @export
#'
eq_location_clean <- function(location) {
    location <- gsub("^[A-Z]+:[ ]*", "", location)
    location <- gsub("^[A-Z]+:[ ]*", "", location)
    # for simplicity sake, use the str_to_title function from the stringr package!
    location <- stringr::str_to_title(location)
    location
}
