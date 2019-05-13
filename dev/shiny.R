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
           <li>Area (stacked from v1)</li>
           <li>Bar</li>
           <li>Donut</li>
           <li>Geomap</li>
           <li>Line</li>
           <li>Pie</li>
           <li>Treemap</li>
        </ul>"
      )
    ),
    
    mainPanel(
      h1("Area"),
      d3plusOutput("area", height = "400px"),
      
      h1("Bar"),
      d3plusOutput("bar", height = "400px"),
      
      h1("Donut"),
      d3plusOutput("donut", height = "400px"),
      
      h1("Geomap"),
      d3plusOutput("geomap", height = "400px"),
      
      h1("Line"),
      d3plusOutput("line", height = "400px"),
      
      h1("Pie"),
      d3plusOutput("pie", height = "400px"),
      
      h1("Treemap"),
      d3plusOutput("treemap", height = "400px")
    )
  )
)

server <- function(input, output) {
  
  area_data <- tibble(
    id = c(rep("alpha", 3), rep("beta", 2)),
    ab1 = letters[1:5],
    ab2 = c(1,2,5,-1,-2)
  )
  
  bar_data <- tibble(
    id = c(rep("alpha", 3), "beta"),
    ab1 = letters[1:4],
    ab2 = c(1,2,5,-1)
  )
  
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
    id = "alpha",
    ab1 = c(0,-1,1,0),
    ab2 = c(1,2,5,0)
  )
  
  pie_data <- tibble(
    parent = c(rep("Group 1", 3), rep("Group 2", 2)),
    id = c("alpha", "beta", "gamma", "delta", "eta"),
    value = c(29, 10, 2, 29, 25)
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
  
  output$area <- renderD3plus({
    d3plus() %>%
      d3p_type("area") %>%
      d3p_data(data = area_data) %>%
      d3p_groupBy("id") %>%  
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
