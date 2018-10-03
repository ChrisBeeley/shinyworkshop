library(tidyverse)

function(input, output) { 
  
  output$plotDisplay = renderPlot({
    
    theData = data.frame("Date" = seq(input$dateRange[1], 
                                      input$dateRange[2], "days"))
    
    if(input$boxInput){
      
      theData$y = ((1 : nrow(theData)) ^ 2) * runif(nrow(theData))
      
    } else {
      
      theData$y = (1 : nrow(theData)) * runif(nrow(theData))
      
    }
    
    p = ggplot(theData, aes(x = Date, y = y)) + 
      geom_line() + 
      geom_smooth(method = input$pickRadio) +
      ggtitle(input$comment)
    
    return(p)
    
  })
  
  output$tableDisplay = renderDataTable({
    
    getMat = matrix(c(input$slider, class(input$slider),
                      paste(input$checkGroup, collapse = ','), 
                      class(input$checkGroup),
                      input$boxInput, class(input$boxInput),
                      as.character(as.Date(input$theDate)), 
                      class(input$theDate),
                      paste(as.character(as.Date(input$dateRange[1])),
                            as.character(as.Date(input$dateRange[2])), 
                            collapse = ','),
                      class(input$dateRange),
                      input$pickNumber, class(input$pickNumber),
                      input$pickRadio, class(input$pickRadio),
                      input$comboBox, class(input$comboBox),
                      
                      input$comment, class(input$comment)
    ), ncol = 2, byrow = TRUE)
    
    getFrame = data.frame(1 : nrow(getMat), getMat)
    
    names(getFrame) = c("rownames", "Value", "Class")
    
    return(getFrame[1 : input$slider, input$checkGroup])
    
  })
  
  output$textDisplay = renderText({
    
    if(input$theDate == Sys.Date()) {
      
      storyDate = "today"
      
    } else if(input$theDate < Sys.Date()){
      
      storyDate = "in the past"
      
    } else if(input$theDate > Sys.Date()){
      
      storyDate = "in the future"
    }
    
    pasteString = c("This story is written", storyDate,
                         "it concerns", input$comboBox, 
                    ". Basically it goes like this:",
                    input$textArea, ". The story should be told", 
                    input$pickNumber, "times.")
    
    pasteString = rep(pasteString, input$pickNumber)
  })
  
}