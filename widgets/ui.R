fluidPage(
  
  titlePanel("Widget demo"),
  
  sidebarLayout(
    sidebarPanel(
      
      dateRangeInput(inputId = "dateRange",
                     label = "Graph date range",
                     start = as.Date("2016-05-19"),
                     end = NULL),
      
      checkboxGroupInput(inputId = "checkGroup",
                         label = "Table columns",
                         choices = list("Rownames" = "rownames", 
                                        "Value", "Class"),
                         selected = list("rownames", "Value", "Class")),
      
      selectInput(inputId = "comboBox",
                  label = "Theme of story",
                  choices = list("power struggle", "espionage", "love"))
      
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Plot", 
                 checkboxInput(inputId = "boxInput",
                               label = "Square the output?",
                               value = TRUE),
                 radioButtons(inputId = "pickRadio",
                              label = "Smoothing statistic",
                              choices = list("LOESS" = "loess", 
                                             "Linear moodel" = "lm")),
                 plotOutput("plotDisplay"),
                 textInput(inputId = "comment",
                           label = "textInput",
                           value = "Graph title")),
        
        tabPanel("Table", sliderInput(inputId = "slider",
                                      label = "Number of rows",
                                      min = 1, max = 9, value = 9),
                 dataTableOutput("tableDisplay")),
        
        tabPanel("Text", dateInput(inputId = "theDate",
                                   label = "Story date"),
                 textAreaInput("textArea", "The Story", 
                               value = "Boy meets girl"),
                 numericInput(inputId = "pickNumber",
                              label = "Number of stories",
                              min = 1, max = 10, value = 1),
                 textOutput("textDisplay"))
      )
    )
  )
)