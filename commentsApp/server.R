
library(rlang)
library(tidyverse)
library(pander)
library(tidytext)
library(pander)
library(xtable)
library(DT)

load("commentsApp/testData.Rdata")

function(input, output) {
  
  filterData <- reactive({
    
    testData %>%
      filter(Directorate2 == input$directorate)
  })
  
  returnTable <- function(df, variableName){
    
    tidy_comments = df %>%
      filter(!is.na(!!(sym(variableName)))) %>%
      unnest_tokens(word, !!(sym(variableName)))
    
    tidy_comments <- tidy_comments %>%
      anti_join(stop_words)
    
    tidy_comments %>%
      count(word, sort = TRUE) %>%
      slice(1:10) %>%
      as.data.frame
  }
  
  output$bestComments <- renderDataTable({
    
    datatable(
      returnTable(filterData(), "Best"),
      selection = "single"
    )
  })
  
  output$bestText <- renderText({
    
    validate(
      need(input$bestComments_rows_selected, "")
    )
    
    returnWord = returnBestTable() %>%
      slice(input$bestComments_rows_selected) %>%
      pull(word)
    
    filterData() %>%
      filter(grepl(returnWord, filterData()$Best)) %>%
      pull(Best) %>% 
      paste("<p>", ., "</p>")
  })
  
  output$improveComments <- renderDataTable({
    
    datatable(
      returnTable(filterData(), "Improve"),
      selection = "single"
    )
  })
  
  output$bestText = renderText({
    
    validate(
      need(input$bestComments_rows_selected, "")
    )
    
    returnWord = returnTable(filterData(), "Best") %>%
      slice(input$bestComments_rows_selected) %>%
      pull(word)
    
    filterData() %>%
      filter(grepl(returnWord, filterData()$Best)) %>%
      pull(Best) %>% 
      paste("<p>", ., "</p>")
  })
  
  output$improveText = renderText({
    
    validate(
      need(input$improveComments_rows_selected, "")
    )
    
    returnWord = returnTable(filterData(), "Improve") %>%
      slice(input$improveComments_rows_selected) %>%
      pull(word)
    
    filterData() %>%
      filter(grepl(returnWord, filterData()$Improve)) %>%
      pull(Improve) %>% 
      paste("<p>", ., "</p>")
  })
  
}
