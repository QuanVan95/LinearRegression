library(shiny)

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    
    fmla <- as.formula(paste(input$dependent," ~ ",paste(input$independents)))
    
    reg<-(lm(fmla,data=filedata()))
    summary(reg)
    plot(fmla,data=filedata())
    abline(reg)
    
    
  })
  
  filedata <- reactive({
    infile <- input$file1
    if (is.null(infile)){
      return(NULL)      
    }
    read.csv(infile$datapath)
  })
  
  output$ui.action <- renderUI({
    if (is.null(filedata())) return()
    actionButton("action", "Run Linear Regression")
  })
  
  output$independents <- renderUI({
    df <- filedata()
    if (is.null(df)) return(NULL)
    items=names(df)
    names(items)=items
    selectInput("independents","Independent Variale:",items)
  })
  
  
  output$dependent <- renderUI({
    df <- filedata()
    if (is.null(df)) return(NULL)
    items=names(df)
    names(items)=items
    selectInput("dependent","Dependent Variable:",items,multiple=FALSE)
  })
  
  
  
  output$contents <- renderPrint({
    if (is.null(input$action)) return()
    if (input$action==0) return()
    
    df <- filedata()
    if (is.null(df)) return(NULL)
    fmla <- as.formula(paste(input$dependent," ~ ",paste(input$independents,collapse="+")))
    summary(lm(fmla,data=df))
    
  })
  
  
})