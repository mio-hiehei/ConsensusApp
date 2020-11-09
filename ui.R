#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(pageWithSidebar(
    
    headerPanel("MPs in Zoomland"),
    sidebarPanel(
        textInput('names', 'Enter your names (comma delimited)', "Angela, Emmanuel, Boris, Pedro, Giuseppe")
    ),
    
    mainPanel(
        h4('MPs in the online-affairs committee'),
        # plotOutput("plot"),
        tableOutput("table"),
        plotOutput("plot", width = "50%")
    )
))