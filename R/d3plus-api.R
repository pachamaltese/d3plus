#' @export
d3p_type <- function(d3p, type = NULL) {
  d3p$x[["type"]] <- type
  d3p
}

#' @export
d3p_data <- function(d3p, data = NULL, nodes = NULL, links = NULL, topojson = NULL,
                     sum = NULL, metric = NULL, value = NULL) {
  stopifnot(
    is.null(data) | is.data.frame(data),
    is.null(nodes) | is.data.frame(nodes),
    is.null(links) | is.data.frame(links)
  )
  
  d3p$x[["data"]] <- data
  d3p$x[["links"]] <- links
  d3p$x[["nodes"]] <- nodes
  d3p$x[["topojson"]] <- topojson
  d3p$x[["metric"]] <- metric
  d3p$x[["value"]] <- value
  d3p
}

#' @export
d3p_groupBy <- function(d3p, vars = NULL) {
  d3p$x[["groupBy"]] <- vars
  d3p
}

#' @export
d3p_legendConfig <- function(d3p, ...) {
  d3p$x$legendConfig <- list(...)
  d3p
}

#' @export
d3p_size <- function(d3p, size = NULL, size_min = NULL, size_max = NULL) {
  d3p$x[["size"]] <- size
  d3p$x[["sizeMin"]] <- size_min
  d3p$x[["sizeMax"]] <- size_max
  d3p
}

#' @export
d3p_tooltipConfig <- function(d3p, ...) {
  d3p$x$tooltipConfig <- list(...)
  d3p
}

#' @export
d3p_shapeConfig <- function(d3p, ...) {
  d3p$x$shapeConfig <- list(...)
  d3p
}

# axis is specific to bar/line/area type
#' @export
d3p_axis <- function(d3p, x = NULL, y = NULL) {
  d3p$x[["xaxis"]] <- x
  d3p$x[["yaxis"]] <- y
  d3p
}

# topojsonId & colorScale are specific to geomap type
#' @export
d3p_topojsonId <- function(d3p, value = NULL) {
  d3p$x$topojsonId <- value
  d3p
}
#' @export
d3p_colorScale <- function(d3p, value = NULL) {
  d3p$x$colorScale <- value
  d3p
}

#' @export
d3p_loadingHTML <- function(d3p, value = NULL) {
  d3p$x$loadingHTML <- value
  d3p
}

#' @export
d3p_center <- function(d3p, center = NULL) {
  d3p$x[["center"]] <- center
  d3p
}
