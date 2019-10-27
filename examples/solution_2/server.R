
library(tidyverse)
library(gapminder)
library(leaflet)
library(ggmap)

load("geocodedData.Rdata")

function(input, output) {
  
  # Summary 
  
  output$summary = renderText({
    
    subset_data <- mapData %>%
      filter(year >= input$year[1], year <= input$year[2])
    
    paste0(input$year[2] - input$year[1], " years are selected. There are ", 
           length(unique(subset_data$country)), " countries in the dataset measured at ",
           length(unique(subset_data$year)), " occasions.")
  })
  
  # trend
  
  output$trend = renderPlot({ 
    
    subset_data <- mapData %>%
      filter(year >= input$year[1], year <= input$year[2])

    thePlot = subset_data %>%
      group_by(continent, year) %>%
      summarise(meanLife = mean(lifeExp)) %>%
      ggplot(aes(x = year, y = meanLife, group = continent, colour = continent)) +
      geom_line() + ggtitle("Graph to show life expectancy by continent over time")
    
    if(input$linear){ 
      thePlot = thePlot + geom_smooth(method = "lm") 
    } 
    
    return(thePlot)
  })
  
  # map
  
  output$map = renderLeaflet({
    
    mapData %>%
      filter(year == input$year[2]) %>%
      leaflet() %>%
      addTiles() %>%
      setView(lng = 0, lat = 0, zoom = 2) %>%
      addCircles(lng = ~ lon, lat = ~ lat, weight = 1,
                 radius = ~ lifeExp * 5000, 
                 popup = ~ paste(country, lifeExp))
  })
  
}