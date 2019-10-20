#' Cleans the raw NOAA significant earthquake data.
#'
#' This converts latitude and longitude into numeric variables,
#' converts various other variables to numeric type, and creates
#' a new variable called DATE, which is of type Date and contains
#' the combination of the YEAR, MONTH and DAY variables.
#'
#' Careful: NA values in MONTH and DAY are replaces with 1, e.g.
#' YEAR = 2019, MONTH = NA, DAY = NA will result in DATE = 2019-01-01.
#' Negative years return in NA in the DATE variable, i.e. the historic
#' earthquakes are not correctly handled.
#'
#' Additionally, the LOCATION_NAME column is cleaned up using the
#' eq_location_clean function.
#'
#' @examples
#' \dontrun{
#' data <- readr::read_delim("noaa_signif_earthquake.txt", delim = "\t")
#' clean_data <- eq_clean_data(data)
#' }
#'
#' @param df the raw NOAA significant earthquake dataset
#' @return the cleaned up data set
#'
#' @export
#'
eq_clean_data <- function(df) {
  df$LATITUDE <- as.numeric(df$LATITUDE)
  df$LONGITUDE <- as.numeric(df$LONGITUDE)
  df$SECOND <- as.numeric(df$SECOND)
  df$EQ_PRIMARY <- as.numeric(df$EQ_PRIMARY)
  df$EQ_MAG_MW <- as.numeric(df$EQ_MAG_MW)
  df$DEATHS <- as.numeric(df$DEATHS)
  df$INJURIES <- as.numeric(df$INJURIES)
  df$TOTAL_DEATHS <- as.numeric(df$TOTAL_DEATHS)
  df$DATE <- as.Date(paste(df$YEAR,
                           ifelse(is.na(df$MONTH), "1", df$MONTH),
                           ifelse(is.na(df$DAY), "1", df$DAY),
                           sep = "/"),
                     format = "%Y/%m/%d")
  df$LOCATION_NAME <- eq_location_clean(df$LOCATION_NAME)
  df
}
