library(dplyr)
library(d3plus2)

line_data <- tibble(
  id = "alpha",
  ab1 = c(0,-1,1,0),
  ab2 = c(1,2,5,0)
)

d3plus() %>%
  d3p_type("line") %>%
  d3p_data(data = line_data) %>%
  d3p_groupBy("id") %>%  
  d3p_axis(x = "ab1", y = "ab2") %>% 
  d3p_loadingHTML("resizing...")
