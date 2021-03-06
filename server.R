#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(truncnorm)
library(tidyverse)
library(ggrepel)

is.even <- function(x) x %% 2 == 0
is.odd <- function(X) x %% 2 != 0

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
        
        
        
mps_pref <- reactive({
    
        mps <- strsplit(input$names, ", ")[[1]]
        
        # Rena, Ria, Mio, WIlli, Tatti, Johann, Lovis, Friedrich, Walter, Christa, Hartmut, Paula, Jakob, Rainer, Annette, Julius, Ina
        
        p4 <- cbind(round(rtruncnorm(n = ceiling(0.35*length(mps)),
                                    mean = 40,
                                    sd = 8,
                                    a = 0,
                                    b= 100),
                          0),
                    "P4")

        waa <- cbind(round(rtruncnorm(n = length(mps) / 2 + 1 - length(p4[,1]),
                                      mean = 25,
                                      sd = 4,
                                      a = 0,
                                      b= 100),
                           0),
                     "WAA")
        
        
        
        uwe <- cbind(round(rtruncnorm(n = round((length(mps) - length(p4[,1])- length(waa[,1])) * 0.66,0),
                                      mean = 58, 
                                      sd = 10,
                                      a = 0,
                                      b = 100),
                           0),
                     "UWE")
        
        pls <- cbind(round(rtruncnorm(n = length(mps) - length(p4[,1])- length(waa[,1]) - length(uwe[,1]),
                                      mean = 5,
                                      sd =  2, 
                                      a = 0,
                                      b = 100),
                           0),
                     "PLS")
        
        preferences <- rbind(p4,waa,uwe,pls)
        
        return(data.frame(Preference = as.integer(preferences[,1]),
                                        Party = preferences[,2],
                                        Name = sample(mps))
        )
        })

                
        output$table <- renderTable({mps_pref()})
        
        output$plot1 <- renderPlot({
            
            ggplot(data = mps_pref(), aes(x = Preference,y = 1, colour = Party))+
                geom_point(size = 2.5)+
                ggtitle("Preference Distribution in Lower Chamber")+
                geom_text_repel(aes(label = Name),nudge_y = 0.0,colour = "black", size = 3)+
                theme_bw()+
                theme(axis.title.y=element_blank(),
                      axis.text.y=element_blank())
            })
    
        
    data <- data.frame(Party = c("P4","WAA","UWE","PLS"),
                       Seats = c(40, 7, 30, 100-40-7-30),
                       Parl = "Upper Chamber")

    data$Party <- factor(data$Party, levels = c("PLS","UWE","WAA", "P4"))


    output$plot2 <- renderPlot({

        ggplot(data, aes(x = Parl, y = Seats, fill = Party)) +
            geom_col() +
            geom_hline(yintercept = 50)+
            geom_text(aes(label = Seats),
                      position = position_stack(vjust = 0.5))+
            theme_minimal() +
            ylab("Seats") +
            xlab(NULL)+
            ggtitle("Seat Composition in upper chamber")


    })

    
})
