library(dplyr)
library(d3plus2)

dta <- tibble(
  id = c(rep("alpha", 3), rep("beta", 2)),
  ab1 = letters[1:5],
  ab2 = c(1,2,5,-1,-2)
)

d3plus() %>%
  d3p_type("area") %>%
  d3p_data(data = dta) %>%
  d3p_groupBy("id") %>%  
  d3p_axis(x = "ab1", y = "ab2") %>% 
  d3p_shapeConfig(
    hoverOpacity = 0.85
  ) %>% 
  d3p_loadingHTML("resizing...")