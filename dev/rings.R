# not working
# check http://d3plus.org/examples/d3plus-network/simple-rings/

library(dplyr)
library(d3plus)

rings_data <- tibble(
  name = c("alpha", "beta", "gamma", "theta", "zeta", "epsilon"),
  val = c(10, 20, 30, 30, 20, 10)
)

rings_edges <- tibble(
  source = c(0,0,3,3,5),
  target = c(1,2,4,5,0)
)

d3plus() %>%
  d3p_type("rings") %>%
  d3p_data(data = rings_data, links = rings_edges) %>%
  d3p_center("alpha")
