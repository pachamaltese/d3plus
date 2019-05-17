# not fully working
# see http://d3plus.org/examples/d3plus-hierarchy/pack/

library(dplyr)
library(d3plus)

bubbles_data <- tibble(
  value = c(100,70,40,15,5,1),
  name = c("alpha", "beta", "gamma", "delta", "epsilon", "zeta"),
  group = c("group 1", rep("group 2", 3), rep("group 1", 2))
)

d3plus() %>%
  d3p_type("bubbles") %>%
  d3p_data(data = bubbles_data, sum = "value") %>%
  d3p_groupBy(c("group", "name"))
