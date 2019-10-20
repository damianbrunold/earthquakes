#' Creates a leaflet map of the NOAA earthquake data
#' and annotates the earthquakes using the annot_col
#' column in the data.
#'
#' @param data the cleaned NOAA earthquake dataset
#' @param annot_col the column to use for annotation labels
#' @return the leaflet map
#'
#' @examples
#' \dontrun{
#' eq_map(data, annot_col = "LOCATION_NAME")
#' }
#'
#' @export
#'
eq_map <- function(data, annot_col) {
    result <- leaflet::leaflet()
    result <- leaflet::addTiles(result)
    result <- leaflet::addCircleMarkers(result,
                 lng = data$LONGITUDE,
                 lat = data$LATITUDE,
                 radius = data$EQ_PRIMARY,
                 weight = 1,
                 popup = data[[annot_col]])
    result
}
