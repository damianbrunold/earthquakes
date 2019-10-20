#' Returns an annotation vector based on a NOAA earthquake dataset.
#' The annotation contains information about location, magnitude
#' and total deaths. If any information is missing, it is skipped.
#'
#' @param data the cleaned NOAA earthquake dataset
#' @return a character vector containing the annotations labels
#'
#' @examples
#' \dontrun{
#' eq_create_label(data)
#' }
#'
#' @export
#'
eq_create_label <- function(data) {
    label <- ifelse(is.na(data$LOCATION_NAME), "", paste("<p><strong>Location:</strong>", data$LOCATION_NAME, "</p>"))
    label <- ifelse(is.na(data$EQ_PRIMARY), label, paste(label, "<p><strong>Magnitude:</strong>", data$EQ_PRIMARY, "</p>"))
    label <- ifelse(is.na(data$TOTAL_DEATHS), label, paste(label, "<p><strong>Total deaths:</strong>", data$TOTAL_DEATHS, "</p>"))
    label
}
