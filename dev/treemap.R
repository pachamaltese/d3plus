library(dplyr)
library(d3plus)

treemap_data <- tibble(
  parent = c(rep("Group 1", 3), rep("Group 2", 2)),
  id = c("alpha", "beta", "gamma", "delta", "eta"),
  value = c(29, 10, 2, 29, 25),
  icon = c(
    rep("https://datausa.io/static/images/attrs/thing_apple.png", 3),
    rep("https://datausa.io/static/images/attrs/thing_fish.png", 2)
  ),
  color = c(rep("cornflowerblue", 3), rep("firebrick", 2))
)

d3plus() %>%
  d3p_type("treemap") %>%
  d3p_data(data = treemap_data, sum = "value") %>%
  d3p_groupBy(c("parent", "id")) %>%
  d3p_shapeConfig(
    hoverOpacity = 0.85,
    fill = d3p_JSarg("color"),
    labelConfig = list(
      fontFamily = "Fira Sans",
      fontMax = 32
    )
  ) %>%
  d3p_legendConfig(
    shapeConfig = list(
      width = 30,
      height = 30,
      backgroundImage = d3p_JSarg("icon")
    ),
    label = FALSE
  ) %>%
  d3p_tooltipConfig(
    # https://jsfiddle.net/0y9ku3vz/1/
    body = JS('
    function(d) {
        var table = "<table class=\'tooltip-table\'>";
        table += "<tr><td class=\'title\'>Value:</td><td class=\'data\'>" +  d.value + "</td></tr>";
        table += "</table>";

        return table;
    }
             '
    ),
    footer = d3p_footer("This is a footer"),
    title =  d3p_titleCase("id")
  ) %>%
  d3p_loadingHTML("resizing...")
