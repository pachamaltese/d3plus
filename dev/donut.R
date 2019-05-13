library(dplyr)
library(d3plus2)

dta <- tibble(
  parent = c(rep("Group 1", 3), rep("Group 2", 2)),
  id = c("alpha", "beta", "gamma", "delta", "eta"),
  value = c(29, 10, 2, 29, 25)
)

d3p <- d3plus() %>%
  d3p_type("donut") %>%
  d3p_data(data = dta) %>%
  d3p_groupBy("id") %>% 
  d3p_shapeConfig(
    hoverOpacity = 0.85
  ) %>% 
  d3p_loadingHTML("resizing...")

d3p