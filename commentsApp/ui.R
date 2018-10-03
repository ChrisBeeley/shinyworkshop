
fluidPage(
  
  title = ("Comments application"),
  
  fluidRow(
    column(2, 
           selectInput(
             "directorate", "Directorate:", 
             # in the full application this is loaded in global.R but 
             # global.R doesn't work with .Rmd
             c("CAMHS", "Adult mental health", "Mental health services for older people", 
               "Rampton", "High secure women's service", "Arnold lodge", "High secure PD pathway", 
               "Substance misuse services", "Prescribed services", NA, "Low secure and CFS", 
               "Intellectual and developmental disability", "High secure LD", 
               "High secure MH", "Wathwood", "Offender health", "Children and young people", 
               "IAPT", "Rushcliffe", "Specialist services", "Mansfield and Ashfield", 
               "Nottingham West", "Nottingham North and East", "Bassetlaw", 
               "Newark and Sherwood", "Sure Start"))),
    
    column(5, dataTableOutput("bestComments")),
    
    column(5, dataTableOutput("improveComments"))
  ),
  
  fluidRow(
    column(5, htmlOutput("bestText"), offset = 2),
    column(5, htmlOutput("improveText"))
  )
)