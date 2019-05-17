# Not working
# check example here http://d3plus.org/examples/d3plus-plot/box-whisker/

library(dplyr)
library(d3plus)

box_data <- tibble(
  id = c(rep("alpha", 8), rep("beta", 8)),
  value = c(300,20,180,40,170,125,74,80,180,30,120,50,140,115,14,30)
)

d3plus() %>%
  d3p_type("box") %>%
  d3p_data(data = box_data) %>%
  d3p_groupBy(c("id", "value")) %>%
  d3p_axis(x = "id", y = "value")
