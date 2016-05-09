library(shiny)
library(shinydashboard)
library(ggplot2) # for the mpg dataset 
library(htmlwidgets) #to display data tables 
library(DT)

# http://shiny.rstudio-staging.com/gallery/datatables-options.html
# http://shiny.rstudio.com/articles/datatables.html

shinyServer(function(input, output) {
  # reactive dataset selection based on user selection
  datasetInput <- reactive( {
      switch( input$dataset
                , "rock" = rock
                , "pressure" = pressure
                , "cars" = cars )
    } 
  )
  
  plotdataInput <- reactive( {
    switch( input$plotdata
            , "rock" = rock
            , "pressure" = pressure
            , "cars" = cars )
  } 
  )
  
  # reactive plot based on user selection from datasetInput
  plotInput <- reactive( {
      df <- plotdataInput()
      p  <- ggplot( df, aes_string(x=names(df)[1], y=names(df)[2] )  
                 )  + geom_point() 
    } 
  )
  
  # reactive plot output for demo A 
  output$plot <- renderPlot( {
    print( plotInput() )
    } 
  )
  
  #### download data selection as csv
  output$downloadData <- downloadHandler(
      filename = function() { paste(input$dataset, '.csv', sep='') }
    , content  = function(file) {
                  write.csv(datasetInput(), file)
                }
  )
  
  #### download plot selection as png
  output$downloadPlot <- downloadHandler(
      filename = function() { paste(input$plotdata, '.png', sep='') }
    , content  = function(file) {
                    ggsave(file, plot = plotInput() )
                  }
  )
  output$mytable = DT::renderDataTable({
    datasetInput()
  })
  
#end shiny server  
  }
)