library(shiny)

shinyUI(fluidPage(
  titlePanel("Linear Regression"),
  sidebarLayout(
    sidebarPanel(
      p("Input Data"),
      fileInput('file1', label='',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      
      tags$hr(),
      uiOutput("dependent"),
      uiOutput("independents"),
      tags$hr(),
      uiOutput('ui.action') # instead of conditionalPanel
    ),
    mainPanel(
      p("Graph!"),
      plotOutput("distPlot"),
      p("RUN:"),
      verbatimTextOutput('contents')
      
      
    )
  )
))