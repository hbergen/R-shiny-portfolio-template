# to deploy changes to this app, run
# library(rsconnect)
# deployApp()

library(shinydashboard)
library(shiny)
library(ggplot2) # for the mpg dataset 
library(htmlwidgets) #to display data tables 
library(shinythemes)
library(DT)

# guide to how to lay out your shiny app: 
# http://shiny.rstudio.com/articles/layout-guide.html

# PANEL - ABOUT ME CONTENT 
home <- tabPanel( title = "Home"
                    , mainPanel( h1("About this project")
                                  , br()
                                  , HTML("<p>Hello, World!
                                     <p>
                                     <p> This application provides a minimal working example for a Shiny app, complete with <a href='https://bootswatch.com/' target='blank_'>bootstrap</a>, favicons, navbar dropdowns, and example data and plot integration.
                                     <p> Created by Heidi Whiting.
                                     <p><i class='fa fa-linkedin fa-1x'></i>
                                     <a href = 'https://www.linkedin.com/in/heidiwhiting' target='_blank'> View my Linkedin profile</a>." )
                      )
          )


# NAVBAR 1 - PROJECT A BACKGROUND
A_background <- tabPanel( title = "background"
                    , mainPanel("Project A background") 
         )


# NAVBAR 1 - PROJECT A DATA TABLE DISPLAY
A_data <- tabPanel( title = "data"
                    , mainPanel(selectInput("dataset", "Choose a dataset:" 
                                            , choices = c("rock", "pressure", "cars") )
                                , DT::dataTableOutput('mytable'))
)


# NAVBAR 1 - PROJECT A METHODS
A_methods <- tabPanel( title = "methods"
                      , mainPanel( withMathJax()
                                   , helpText('R Shiny supports MathJax integration:
                                               $$\\frac2\\pi = \\frac{\\sqrt2}2 \\cdot
                                               \\frac{\\sqrt{2+\\sqrt2}}2 \\cdot
                                               \\frac{\\sqrt{2+\\sqrt{2+\\sqrt2}}}2 \\cdots$$'  )
                        )
           )


# NAVBAR 1 - PROJECT A RESULTS
A_results <- tabPanel( title = "results"
                       , mainPanel(
                         selectInput("plotdata", "Choose a dataset:" 
                                     , choices = c("rock", "pressure", "cars") )
                         , downloadButton('downloadData', 'CSV')
                         , downloadButton('downloadPlot', 'PNG')
                         , plotOutput('plot')
                       )
)


# NAVBAR 2 - PROJECT B
# Store pages in separate markdown documents to keep folders tidy
B_background <- tabPanel( title = "Project B background"
                          , mainPanel( includeMarkdown("static/B_background.Rmd" ) )
)


resources <- tabPanel( title = "resources"
                       , mainPanel("Page for references, articles, list of packages used, ...")
                      )


# PUT EVERYTHING TOGETHER
shinyUI(  
          navbarPage(  title = div( "Shiny Portfolio" )
                         , home
                         , navbarMenu( title = "project A"
                                        , A_background
                                        , A_data
                                        , A_methods
                                        , A_results)
                         , navbarMenu( title= "project B"
                                      , B_background)
                         , resources
                       # css from https://bootswatch.com/
                         , includeCSS("www/css/bootstrap.css")
                         , windowTitle = "A demo project"
          )
       )



