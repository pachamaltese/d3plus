library(shiny)
library(dplyr)
library(d3plus2)

ui <- fluidPage(
  
  titlePanel("Hello Shiny!"),
  
  sidebarLayout(
    
    sidebarPanel(
      p("The examples here are fully tailored to show all the functions within the package.
        You can obtain similar results with much simpler code."),
      p("Included examples:"),
      HTML(
        "<ul>
           <li>Area</li>
           <li>Bar</li>
           <!--<li>Box and whiskers (not working)</li>-->
           <li>Donut</li>
           <li>Geomap</li>
           <li>Line</li>
           <li>Network (WIP)</li>
           <li>Pie</li>
           <li>Scatterplot</li>
           <li>Stacked</li>
           <li>Treemap</li>
        </ul>"
      )
    ),
    
    mainPanel(
      h1("Area"),
      d3plusOutput("area", height = "400px"),
      
      h1("Bar"),
      d3plusOutput("bar", height = "400px"),
      
      # h1("Box"),
      # d3plusOutput("box", height = "400px"),
      
      h1("Donut"),
      d3plusOutput("donut", height = "400px"),
      
      h1("Geomap"),
      d3plusOutput("geomap", height = "400px"),
      
      h1("Line"),
      d3plusOutput("line", height = "400px"),
      
      h1("Pie"),
      d3plusOutput("pie", height = "400px"),
      
      h1("Scatterplot"),
      d3plusOutput("scatterplot", height = "400px"),
      
      h1("Stacked"),
      d3plusOutput("stacked", height = "400px"),
      
      h1("Treemap"),
      d3plusOutput("treemap", height = "400px")
    )
  )
)

server <- function(input, output) {
  # Data ----
  
  area_data <- tibble(
    id = c(rep("alpha", 3), rep("beta", 3)),
    ab1 = c(4,5,6,4,5,6),
    ab2 = c(7,25,13,17,8,13)
  )
  
  bar_data <- tibble(
    id = c(rep("alpha", 3), "beta"),
    ab1 = letters[1:4],
    ab2 = c(1,2,5,-1)
  )
  
  # box_data <- tibble(
  #   year = rep(c(1991,1992), 8),
  #   name = c(rep("alpha", 2), rep("alpha2", 2),
  #            rep("beta", 2), rep("beta2", 2),
  #            rep("gamma", 2), rep("gamma2", 2),
  #            rep("delta", 2), rep("delta2", 2)),
  #   value = c(15,34,17,65,10,10,40,38,5,10,20,34,50,
  #             43,17,35)
  # )
  
  donut_data <- tibble(
    parent = c(rep("Group 1", 3), rep("Group 2", 2)),
    id = c("alpha", "beta", "gamma", "delta", "eta"),
    value = c(29, 10, 2, 29, 25)
  )
  
  geomap_data <- tibble(
    commune_name = c("Arica", "Putre"),
    commune_id = c("15101", "15201"),
    value = c(200, 150)
  )
  
  line_data <- tibble(
    id = c(rep("alpha", 3), rep("beta", 3)),
    ab1 = c(4,5,6,4,5,6),
    ab2 = c(7,25,13,17,8,13)
  )
  
  pie_data <- tibble(
    parent = c(rep("Group 1", 3), rep("Group 2", 2)),
    id = c("alpha", "beta", "gamma", "delta", "eta"),
    value = c(29, 10, 2, 29, 25)
  )
  
  scatterplot_data <- tibble(
    x = c(4,5,6),
    y = c(7,2,13),
    value = c(240,120,180),
    type = c("alpha", "beta", "gamma")
  )
  
  stacked_data <- tibble(
    id = c(rep("alpha", 3), rep("beta", 3)),
    ab1 = c(4,5,6,4,5,6),
    ab2 = c(7,25,13,17,8,13)
  )
  
  treemap_data <- tibble(
    parent = c(rep("Group 1", 3), rep("Group 2", 2)),
    id = c("alpha", "beta", "gamma", "delta", "eta"),
    value = c(29, 10, 2, 29, 25),
    icon = c(
      rep("https://datausa.io/static/images/attrs/thing_apple.png", 3),
      rep("https://datausa.io/static/images/attrs/thing_fish.png", 2)
    ),
    color = c(rep("cornflowerblue", 3), rep("firebrick", 2))
  )

  # Output ----
  
  output$area <- renderD3plus({
    d3plus() %>%
      d3p_type("area") %>%
      d3p_data(data = area_data) %>%
      d3p_axis(x = "ab1", y = "ab2") %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
  
  output$bar <- renderD3plus({
    d3plus() %>%
      d3p_type("bar") %>%
      d3p_data(data = bar_data) %>%
      d3p_groupBy("id") %>%  
      d3p_axis(x = "ab1", y = "ab2") %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
  
  # output$box <- renderD3plus({
  #   d3plus() %>%
  #     d3p_type("box") %>%
  #     d3p_data(data = box_data) %>%
  #     d3p_groupBy("name") %>% 
  #     d3p_axis(x = "year", y = "value")
  # })
  
  output$donut <- renderD3plus({
    d3plus() %>%
      d3p_type("donut") %>%
      d3p_data(data = donut_data) %>%
      d3p_groupBy("id") %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
  
  output$geomap <- renderD3plus({
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
  })
  
  output$line <- renderD3plus({
    d3plus() %>%
      d3p_type("line") %>%
      d3p_data(data = line_data) %>%
      d3p_groupBy("id") %>%  
      d3p_axis(x = "ab1", y = "ab2") %>% 
      d3p_loadingHTML("resizing...")
  })
  
  output$pie <- renderD3plus({
    d3plus() %>%
      d3p_type("pie") %>%
      d3p_data(data = pie_data) %>%
      d3p_groupBy("id") %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
  
  output$scatterplot <- renderD3plus({
    d3plus() %>%
      d3p_type("scatter") %>%
      d3p_data(data = scatterplot_data) %>%
      d3p_groupBy("type") %>% 
      d3p_axis(x = "x", y = "y") %>% 
      d3p_size(size = "value", size_min = 20, size_max = 100)
  })
  
  output$stacked <- renderD3plus({
    d3plus() %>%
      d3p_type("stacked") %>%
      d3p_data(data = stacked_data) %>%
      d3p_groupBy("id") %>%  
      d3p_axis(x = "ab1", y = "ab2") %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
  
  output$treemap <- renderD3plus({
    d3plus() %>%
      d3p_type("treemap") %>%
      d3p_data(data = treemap_data, sum = "value") %>%
      d3p_groupBy(c("parent", "id")) %>% 
      d3p_shapeConfig(
        hoverOpacity = 0.85,
        fill = d3p_JSarg("color"),
        labelConfig = list(
          fontFamily = "Fira Sans",
          fontMax = 32
        )
      ) %>% 
      d3p_legendConfig(
        shapeConfig = list(
          width = 30,
          height = 30,
          backgroundImage = d3p_JSarg("icon")
        ),
        label = FALSE 
      ) %>% 
      d3p_tooltipConfig(
        body = JS("
             function(d) {
             var table = \"<table class='tooltip-table'>\";
             table += \"<tr><td class='title'>Parent:</td><td class='data'>\" + d.parent + \"</td></tr>\";
             table += \"<tr><td class='title'>Value:</td><td class='data'>\" + d.value + \"</td></tr>\";
             table += \"</table>\";
             return table;
             }
             "
        ),
        footer = d3p_footer("This is a footer"),
        title =  d3p_titleCase("id")
      ) %>% 
      d3p_loadingHTML("resizing...")
  })
}

shinyApp(ui, server)
