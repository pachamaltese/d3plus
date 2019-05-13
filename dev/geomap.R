library(dplyr)

geomap_data <- tibble(
  commune_name = c("Arica", "Putre"),
  commune_id = c("15101", "15201"),
  value = c(200, 150)
)

# reference
# https://gist.github.com/pachamaltese/ba8597718701e55fc62dc45671e6c841
d3plus() %>%
  d3p_type("geomap") %>%
  d3p_data(data = geomap_data,
           topojson = "https://raw.githubusercontent.com/pachamaltese/chilemaps/master/data_topojson/simplified_communes/new/r15.topojson") %>%
  d3p_groupBy("commune_id") %>% 
  d3p_colorScale("value") %>% 
  d3p_topojsonId(JS("function(d) { return d.properties.commune_id; }")) %>% 
  d3p_tooltipConfig(
    body = JS("
              function(d) {
              var table = \"<table class='tooltip-table'>\";
              table += \"<tr><td class='title'>Nombre:</td><td class='data'>\" + d.commune_name + \"</td></tr>\";
             table += \"<tr><td class='title'>ID:</td><td class='data'>\" + d.commune_id + \"</td></tr>\";
             table += \"</table>\";
             return table;
             }
             "
    ),
    footer = JS("
               function(d) {
               return \"<sub class='tooltip-footer'>This is just an example</sub>\";
               }
               "
    ),
    title =  JS("
                function(d) {
                var txt = 'Información de la comuna';
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
                }
                "
    )
  ) %>% 
  d3p_loadingHTML("resizing...")
