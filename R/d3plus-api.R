#' @export
d3p_type <- function(d3p, type = NULL) {
  d3p$x[["type"]] <- type
  d3p
}

#' @export
d3p_data <- function(d3p, data = NULL, sum = NULL, nodes = NULL, links = NULL, topojson = NULL) {
  stopifnot(
    is.null(data) | is.data.frame(data),
    is.null(nodes) | is.data.frame(nodes),
    is.null(links) | is.data.frame(links)
  )
  
  d3p$x[["data"]] <- data
  d3p$x[["links"]] <- links
  d3p$x[["nodes"]] <- nodes
  d3p$x[["sum"]] <- sum
  d3p$x[["topojson"]] <- topojson
  d3p
}

#' @export
d3p_groupBy <- function(d3p, vars = NULL) {
  d3p$x[["groupBy"]] <- vars
  d3p
}

#' @export
d3p_tooltipConfig <- function(d3p, ...) {
  d3p$x$tooltipConfig <- list(...)
  d3p
}

#' @export
d3p_legendConfig <- function(d3p, ...) {
  d3p$x$legendConfig <- list(...)
  d3p
}

#' @export
d3p_shapeConfig <- function(d3p, ...) {
  d3p$x$shapeConfig <- list(...)
  d3p
}

#' @export
d3p_topojsonId <- function(d3p, value = NULL) {
  d3p$x$topojsonId <- value
  d3p
}

#' @export
d3p_axis <- function(d3p, x = NULL, y = NULL) {
  d3p$x[["xaxis"]] <- x
  d3p$x[["yaxis"]] <- y
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
