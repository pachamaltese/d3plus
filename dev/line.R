library(dplyr)
library(d3plus)

line_data <- tibble(
  id = c(rep("alpha", 3), rep("beta", 3)),
  ab1 = c(4,5,6,4,5,6),
  ab2 = c(7,25,13,17,8,13)
)

d3plus() %>%
  d3p_type("line") %>%
  d3p_data(data = line_data) %>%
  d3p_groupBy("id") %>%
  d3p_axis(x = "ab1", y = "ab2") %>%
  d3p_shapeConfig(Line = list(strokeWidth = 5))
  d3p_loadingHTML("resizing...")
