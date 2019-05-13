library(dplyr)
library(d3plus2)

dta <- tibble(
  parent = c(rep("Group 1", 3), rep("Group 2", 2)),
  id = c("alpha", "beta", "gamma", "delta", "eta"),
  value = c(29, 10, 2, 29, 25),
  icon = c(rep("https://datausa.io/static/images/attrs/thing_apple.png", 3),
           rep("https://datausa.io/static/images/attrs/thing_fish.png", 2))
)

d3p <- d3plus() %>%
  d3p_type("treemap") %>%
  d3p_data(data = dta, sum = "value") %>%
  d3p_groupBy(c("parent", "id")) 

d3p %>% 
  d3p_legendConfig(
    shapeConfig = list(
      width = 30,
      height = 30,
      backgroundImage = JS("function(d) { return d.icon; }")
    ),
    label = FALSE 
  ) %>% 
  d3p_tooltipConfig(
    body = JS("
             function(d) {
             var table = \"<table class='tooltip-table'>\";
             table += \"<tr><td class='title'>Parent:</td><td class='data'>\" + d.parent + \"</td></tr>\";
             table += \"<tr><td class='title'>Value:</td><td class='data'>\" + d.value + \"</td></tr>\";
             table += \"</table>\";
             return table;
             }
             "
    ),
    footer = JS("
               function(d) {
               return \"<sub class='tooltip-footer'>This is just an example</sub>\";
               }
               "
    ),
    title =  JS("
                function(d) {
                var txt = d.id;
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
                }
                "
    )
  ) %>% 
  d3p_shapeConfig(
    labelConfig = list(
      fontFamily = "Fira Sans",
      fontMax = 32
    ),
    hoverOpacity = 0.85
  ) %>% 
  d3p_loadingHTML("resizing...")
