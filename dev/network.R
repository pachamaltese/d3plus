# Not working
# check example here http://d3plus.org/examples/d3plus-network/getting-started/

library(dplyr)
library(d3plus2)

network_data <- tibble(
  name = c("alpha", "beta", "gamma", "theta", "zeta", "epsilon"),
  val = c(10, 20, 30, 30, 20, 10)
)

network_edges <- tibble(
  source = c(0,0,3,3,5),
  target = c(1,2,4,5,0)
)

network_nodes <- tibble(
  name = c("alpha", "beta", "gamma", "theta", "zeta", "epsilon"),
  x = c(1,2,1,3,2.5,2),
  y = c(1,1,2,2,1.5,2)
)

d3plus() %>%
  d3p_type("network") %>%
  d3p_data(nodes = network_nodes, links = network_edges) %>%
  # d3p_data(data = network_data, sum = "val", nodes = network_nodes, links = network_edges) %>%
  d3p_groupBy("name")
