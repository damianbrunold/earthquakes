#' A ggplot2 geom function for creating a NoAA earthquake timeline.
#'
#' @inheritParams ggplot2::geom_point
#'
#' @examples
#' \dontrun{
#' data %>%
#'    eq_clean_data() %>%
#'    filter(COUNTRY %in% c("TURKEY", "ITALY", "GREECE"), YEAR > 2005) %>%
#'    ggplot(aes(x = DATE,
#'               y = COUNTRY,
#'               color = as.numeric(TOTAL_DEATHS),
#'               size = as.numeric(EQ_PRIMARY)
#'    )) +
#'    geom_timeline()
#' }
#'
#' @export
#'
geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE,
                          show.legend = NA, inherit.aes = TRUE, ...) {
    ggplot2::layer(
        geom = GeomTimeline, mapping = mapping,
        data = data, stat = stat, position = position,
        show.legend = show.legend, inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
    )
}

#' A ggplot2 geom object for creating a NOAA earthquake timeline.
#'
#' @export
#'
GeomTimeline <- ggplot2::ggproto("GeomTimeline", ggplot2::Geom,
                       required_aes = c("x"),
                       default_aes = ggplot2::aes(color = "gray", fill = "gray", size = 5, alpha = 0.8, y = 0.5),
                       draw_key = ggplot2::draw_key_point,
                       draw_panel = function(data, panel_scales, coord) {
                           coords <- coord$transform(data, panel_scales)

                           points <- grid::circleGrob(
                               x = coords$x,
                               y = coords$y,
                               r = ggplot2::unit(coords$size / 2, "mm"),
                               gp = grid::gpar(fill = coords$fill,
                                               col = coords$colour,
                                               alpha = coords$alpha)
                           )

                           minx <- min(coords$x)
                           maxx <- max(coords$x)
                           lines <- NULL
                           uy <- unique(coords$y)
                           for (idx in seq_along(uy)) {
                               y <- uy[idx]
                               lx <- c(minx, maxx)
                               ly <- c(y, y)
                               if (is.null(lines)) {
                                   lines <- grid::linesGrob(x = lx, y = ly, gp = grid::gpar(color = "gray"))
                               } else {
                                   lines <- grid::gList(lines, grid::linesGrob(x = lx, y = ly, gp = grid::gpar(color = "gray")))
                               }
                           }

                           grid::gTree(children = grid::gList(points, lines))
                       })
