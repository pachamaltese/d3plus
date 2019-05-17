# not working
# check example here http://d3plus.org/examples/d3plus-plot/radar-chart/

library(dplyr)
library(d3plus)

radar_data <- tibble(
  name = c(rep("alpha", 3), rep("beta", 3)),
  skill = rep(c("power", "courage", "wisdom"), 2),
  value = c(4, 8, 2, 5, 4, 6)
)

d3plus() %>%
  d3p_type("radar") %>%
  d3p_data(
    data = radar_data,
    metric = "skill",
    value = "value"
  ) %>%
  d3p_groupBy("name")
