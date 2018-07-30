library(shiny)
library(DT, warn.conflicts = FALSE)
library(ggplot2)
Eastern2017 <- read.csv("Eastern2017.csv")


ui <- fluidPage(
  titlePanel("MLS Eastern Conference"),
  
  # Create a new Row in the UI for selectInputs
  fluidRow(
    column(4,
           selectInput("tm",
                       "Team:",
                       c("All",
                         unique(as.character(Eastern2017$Team))))
    ),
    column(4,
           selectInput("fgoal",
                       "First Goal:",
                       c("All",
                         unique(as.character(Eastern2017$First.Goal.))))
    ),
    column(4,
           selectInput("wl",
                       "Win:",
                       c("All",
                         unique(as.character(Eastern2017$Win.))))
    )
  ),
  # Create a new row for the table.
  fluidRow(
    DT::dataTableOutput("table")
  )
)

server <- function(input, output) {
  
  # Filter data based on selections
  output$table <- DT::renderDataTable(DT::datatable({
    data <- Eastern2017
    if (input$tm != "All") {
      data <- data[data$Team == input$tm,]
    }
    if (input$wl != "All") {
      data <- data[data$Win. == input$wl,]
    }
    if (input$fgoal != "All") {
      data <- data[data$First.Goal. == input$fgoal,]
    }
    data
  }))
  
}

shinyApp(ui, server)
