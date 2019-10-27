
library(tidyverse)
library(gapminder)
library(leaflet)
library(ggmap)

load("geocodedData.Rdata")

function(input, output) {
  
  # Summary 
  
  # shiny text function here
  
  # feel free to change the name of input$inputName to something
  # meaningful (and add it to the ui definition)
    
    subset_data <- mapData %>%
      filter(year >= input$inputName[1], year <= input$inputName[2])
    
    paste0(input$inputName[2] - input$inputName[1], " years are selected. There are ", 
           length(unique(subset_data$country)), " countries in the dataset measured at ",
           length(unique(subset_data$year)), " occasions.")
  # })
  
  # # trend
  # 
  # # shiny graph function here
  # 
  #   subset_data <- mapData %>%
  #     filter(year >= input$inputName[1], year <= input$inputName[2])
  # 
  #   thePlot = subset_data %>%
  #     group_by(continent, year) %>%
  #     summarise(meanLife = mean(lifeExp)) %>%
  #     ggplot(aes(x = year, y = meanLife, group = continent, colour = continent)) +
  #     geom_line() + ggtitle("Graph to show life expectancy by continent over time")
  # 
  #   # add test for checkbox here
  # 
  #   return(thePlot)
  # # })
  # 
  # # draw map
  # 
  # # shiny function here
  # 
  #   mapData %>%
  #     filter(year == input$inputName[2]) %>%
  #     leaflet() %>%
  #     addTiles() %>%
  #     setView(lng = 0, lat = 0, zoom = 2) %>%
  #     addCircles(lng = ~ lon, lat = ~ lat, weight = 1,
  #                radius = ~ lifeExp * 5000,
  #                popup = ~ paste(country, lifeExp))
  # # })
  
}