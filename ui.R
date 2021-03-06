#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# # Define UI for application that draws a histogram
# shinyUI(pageWithSidebar(
#     
#     headerPanel("MPs in Zoomland"),
#     sidebarPanel(
#         textInput('names', 'Enter your names (comma delimited)', "Angela, Emmanuel, Boris, Pedro, Giuseppe")
#     ),
#     
#     mainPanel(
#         h4('MPs in the online-affairs committee'),
#         # plotOutput("plot"),
#         tableOutput("table"),
#         plotOutput("plot1", width = "100%"),
#         plotOutput("plot2", width = "100%")
#         
#     )
# ))


fluidPage(
    
    titlePanel("MPs in Zoomland"),

     sidebarPanel(
         textInput('names', 'Enter your names (comma delimited)', "Rena, Ria, Mio, WIlli, Tatti, Johann, Lovis, Friedrich, Walter, Christa, Hartmut, Paula, Jakob, Rainer, Annette, Julius, Ina"),
         tableOutput("table")
         
     ),
    
    fluidRow(


        column(5,
               plotOutput("plot1", width = "120%"),
               plotOutput("plot2", width = "120%")
        )
        
    )
)
