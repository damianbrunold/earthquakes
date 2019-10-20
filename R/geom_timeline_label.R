#' A ggplot2 geom function for creating NoAA earthquake timeline labels.
#'
#' @inheritParams ggplot2::geom_text
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
#'    geom_timeline() +
#'    geom_timeline_label(aes(label = LOCATION_NAME), n_max = 5)
#' }
#'
#' @export
#'
geom_timeline_label <- function(mapping = NULL, data = NULL, stat = "identity",
                                position = "identity", na.rm = FALSE,
                                show.legend = FALSE, inherit.aes = TRUE, ...) {
    ggplot2::layer(
        geom = GeomTimelineLabel, mapping = mapping,
        data = data, stat = stat, position = position,
        show.legend = show.legend, inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
    )
}

#' A ggplot2 geom object for creating NOAA earthquake timeline labels.
#'
#' @export
#'
GeomTimelineLabel <- ggplot2::ggproto("GeomTimelineLabel", ggplot2::Geom,
                            required_aes = c("x", "label"),
                            default_aes = ggplot2::aes(color = "gray", fill = "gray", size = 5, alpha = 0.8, y = 0.5, n_max = NULL),
                            draw_key = ggplot2::draw_key_abline,
                            setup_data = function(data, params) {
                                if (!is.null(params$n_max)) {
                                    data <- dplyr::group_by(data, group)
                                    data <- dplyr::top_n(data, params$n_max, size)
                                    data <- dplyr::ungroup(data)
                                }
                                data
                            },
                            draw_panel = function(data, panel_scales, coord) {
                                coords <- coord$transform(data, panel_scales)
                                ny <- length(unique(coords$y))
                                off <- 0.2 / ny

                                lines <- grid::polylineGrob(
                                    x = ggplot2::unit(c(coords$x, coords$x), "npc"),
                                    y = ggplot2::unit(c(coords$y, coords$y + off), "npc"),
                                    id = rep(1:dim(coords)[1], 2),
                                    gp = grid::gpar(col = "darkgrey"))

                                 names <- grid::textGrob(
                                     label = coords$label,
                                     x = ggplot2::unit(coords$x, "npc"),
                                     y = ggplot2::unit(coords$y + off, "npc"),
                                     just = c("left", "bottom"),
                                     rot = 45)

                                 grid::gList(lines, names)
                            })
