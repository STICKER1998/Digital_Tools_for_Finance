library(readxl)
library(shiny)
library(ggplot2)
library(ggcorrplot)

ui <- fluidPage(
  
  titlePanel("Digital Tools for Finance"),
  
  sidebarLayout(
    sidebarPanel(
      
      sliderInput("start",
                  "Start Date:",
                  min = as.Date("2015-01-06","%Y-%m-%d"),
                  max = as.Date("2019-12-31","%Y-%m-%d"),
                  value=as.Date("2016-01-01"),timeFormat="%Y-%m-%d"),
      
      sliderInput("end",
                  "End Date:",
                  min = as.Date("2015-01-06","%Y-%m-%d"),
                  max = as.Date("2019-12-31","%Y-%m-%d"),
                  value=as.Date("2016-12-01"),timeFormat="%Y-%m-%d"),

    ),
    
    mainPanel(
      plotOutput("StockPlot"),
      plotOutput("BondPlot"),
      plotOutput("GoldPlot"),
      plotOutput("CorPlot")
    )
  ))


server <- function(input, output) {

  output$StockPlot <- renderPlot({
  df <- read_excel("r_data.xlsx")
  df$Year <- as.Date(df$Year)
  start = input$start
  end = input$end
  ggplot(data = df[(df$Year >= start & df$Year <= end),], 
         aes(x = Year, y = Stock)) + xlab("Date") +
    geom_line(color = "darkred") + 
    scale_x_date(date_labels = "%Y-%m-%d") + 
    theme(axis.text=element_text(size=16),
          axis.title=element_text(size=16,face="bold"))
  })
  
  output$BondPlot <- renderPlot({
    df <- read_excel("r_data.xlsx")
    df$Year <- as.Date(df$Year)
    start = input$start
    end = input$end
    ggplot(data = df[(df$Year >= start & df$Year <= end),], 
           aes(x = Year, y = Bond)) + xlab("Date") + 
      geom_line(color = "darkblue") + 
      scale_x_date(date_labels = "%Y-%m-%d") + 
      theme(axis.text=element_text(size=16),
            axis.title=element_text(size=16,face="bold"))
  })
  
  output$GoldPlot <- renderPlot({
    df <- read_excel("r_data.xlsx")
    df$Year <- as.Date(df$Year)
    start = input$start
    end = input$end
    ggplot(data = df[(df$Year >= start & df$Year <= end),], 
           aes(x = Year, y = Gold)) + xlab("Date") +
      geom_line(color = "darkgreen") + 
      scale_x_date(date_labels = "%Y-%m-%d") + 
      theme(axis.text=element_text(size=16),
            axis.title=element_text(size=16,face="bold"))
  })
  
  output$CorPlot <- renderPlot({
    df <- read_excel("r_data.xlsx")
    df$Year <- as.Date(df$Year)
    start = input$start
    end = input$end
    ggcorrplot(cor(df[(df$Year >= start & df$Year <= end),2:4]), 
               colors = c("#6D9EC1", "white", "#E46726"), lab =TRUE)
  })
}

shinyApp(ui, server)
