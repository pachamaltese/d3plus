#' @export
d3p_JSarg <- function(arg = NULL) {
  htmlwidgets::JS(sprintf("function(d) { return d.%s; }", arg))
}

#' @export
d3p_titleCase <- function(arg = NULL) {
  htmlwidgets::JS(sprintf(
      "
        function(d) {
        var txt = d.%s;
        return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
        }
      ",
      arg
    )
  )
}

#' @export
d3p_footer <- function(arg = NULL) {
  htmlwidgets::JS(sprintf(
    "
      function(d) {
      return \"<sub class='tooltip-footer'>%s</sub>\";
      }
    ",
    arg
  )
  )
}
