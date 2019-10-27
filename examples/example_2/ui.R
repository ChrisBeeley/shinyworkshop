
library(leaflet)

fluidPage(
  
  titlePanel("Gapminder"),
  
  sidebarLayout(
    sidebarPanel(
      # slider input here(
        inputId = XXXX,
        label = XXXX,
        min = 1952,
        max = 2007,
        value = c(1952, 2007),
        sep = "",
        step = 5
      # ),
      
      # shiny function for checkbox here
    ),
    
    mainPanel(
      tabsetPanel(
        # tabPanels in here
      )
    )
  )
)
