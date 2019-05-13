library(dplyr)
library(d3plus2)

bar_data <- tibble(
  id = c(rep("alpha", 3), "beta"),
  ab1 = letters[1:4],
  ab2 = c(1,2,5,-1)
)

d3plus() %>%
  d3p_type("bar") %>%
  d3p_data(data = bar_data) %>%
  d3p_groupBy("id") %>%  
  d3p_axis(x = "ab1", y = "ab2") %>% 
  d3p_shapeConfig(
    hoverOpacity = 0.85
  ) %>% 
  d3p_loadingHTML("resizing...")
