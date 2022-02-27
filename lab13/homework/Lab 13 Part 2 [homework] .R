library(tidyverse)
library(shiny)
library(shinydashboard)
library(here)
library(janitor)
library(lubridate)

gabon <- readr::read_csv("IvindoData_DryadVersion.csv")

ui <- dashboardPage(
  dashboardHeader(title = "Gabon"),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          selectInput("RA", "Select Relative Abundance", choices = c("RA_Birds", "RA_Monkeys", "RA_Apes", "RA_Elephant", "RA_Ungulate", "RA_Rodent"), 
                      selected = "Birds"),
          helpText("Please select a Relative Abundance that matches the guild you want.")),
      
      box(title = "Plot of % Relative Abundance vs. Distance to Nearest Villages", width = 7,
          plotOutput("plot", width = "600px", height = "500px")))))

server <- function(input, output, session) { 
  output$plot <- renderPlot({
    gabon %>% 
      ggplot(aes_string(x="Distance", y=input$RA))+
      geom_point(size = 4, alpha=0.8)+
      geom_smooth(method=lm, se=T)+
      labs(x="Relative Abundance (%)",
           y="Distance to nearest village (km)")
    
  })
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)
