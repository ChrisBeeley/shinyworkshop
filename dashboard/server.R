
library(ggplot2movies)
library(tidyverse)
library(scales)
library(rlang)
library(DT)

function(input, output, session) {
  
  moviesSubset = reactive({
    
    movies %>% filter(year %in% seq(input$year[1], input$year[2]), 
                      UQ(sym(input$genre)) == 1)
    
  })
  
  output$notifications = renderMenu({
    
    notificationsList = list(
      notificationItem(text = "No unauthorised logins", 
                       icon("lock"), status = "success"),
      notificationItem(text = "Database has not been refreshed for 27 days", 
                       icon = icon("database"), status = "info"))
    
    dropdownMenu(type = "notifications", .list = notificationsList, 
                 badgeStatus = "warning")
    
  })
  
  output$messages = renderMenu({
    
    from = c("HR", "Dave", "Global message")
    
    messageText = c("Don't forget drinks on Friday", 
                    "Staff meeting moved to Tuesday, 9am", 
                    "Office closed Christmas day")
    
    timeText = c("3 hours", as.character(Sys.Date()), "1030am")
    
    icons = c("glass", "globe", "gift")
    
    message1 = messageItem(from = sample(from, 1), 
                           message = sample(messageText, 1), 
                           icon = icon(sample(icons, 1)), 
                           time = sample(timeText, 1))
    message2 = messageItem(from = sample(from, 1), 
                           message = sample(messageText, 1), 
                           icon = icon(sample(icons, 1)), 
                           time = sample(timeText, 1))
    
    messageList = list(message1, message2)
    
    dropdownMenu(type = "messages", .list = messageList)
    
  })
  
  output$budgetYear = renderPlot({
    
    budgetByYear = summarise(group_by(moviesSubset(), year), 
                             m = mean(budget, na.rm = TRUE))
    
    ggplot(budgetByYear[complete.cases(budgetByYear), ], 
           aes(x = year, y = m)) + 
      geom_line() + 
      scale_y_continuous(labels = scales::comma) + 
      geom_smooth(method = "loess") + 
      ggtitle(input$title)
    
  })
  
  output$budgetYearLinear = renderPlot({
    
    budgetByYear = summarise(group_by(moviesSubset(), year), 
                             m = mean(budget, na.rm = TRUE))
    
    ggplot(budgetByYear[complete.cases(budgetByYear), ], 
           aes(x = year, y = m)) + 
      geom_line() + 
      scale_y_continuous(labels = scales::comma) + 
      geom_smooth(method = "lm") + 
      ggtitle(input$title)
    
  })
  
  output$listMovies = renderUI({
    
    selectInput("pickMovie", "Pick a movie", 
                choices = moviesSubset() %>% 
                  sample_n(10) %>%
                  select(title)
    )
  })
  
  output$moviePicker = renderDataTable({
    
    filter(moviesSubset(), title == input$pickMovie)[, 1:6]
    
  }, extensions = "Responsive")
  
  output$infoBoxYear = renderInfoBox({
    infoBox(
      "Years", paste(input$year[1], " to ", input$year[2]), 
      icon = icon("calendar-o"),
      color = "blue"
    )
  })
  
  output$infoBoxGenre = renderInfoBox({
    infoBox(
      "Genre", input$genre, icon = icon("film"),
      color = "orange", fill = TRUE
    )
  })
  
  output$valueBoxYear = renderValueBox({
    valueBox(
      "Years", paste(input$year[1], " to ", input$year[2]), 
      icon = icon("calendar-o"),
      color = "blue"
    )
  })
  
  output$valueBoxGenre = renderValueBox({
    valueBox(
      "Genre", input$genre, icon = icon("film"),
      color = "orange"
    )
  })
  
}
