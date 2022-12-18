install.packages("readxl")
install.packages("shiny")
install.packages("ggplot2")
install.packages("ggcorrplot")
install.packages("reshape2")
library(readxl)
library(shiny)
library(ggplot2)
library(ggcorrplot)
library(reshape2)
ui <- fluidPage(
  
  titlePanel("Digital Tools for Finance"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "type",
                  label = "Choose a type:",
                  choices = c("Daily Return", "Model result")),
      
      sliderInput("start",
                  "Start Date:",
                  min = as.Date("2015-01-06","%Y-%m-%d"),
                  max = as.Date("2019-12-31","%Y-%m-%d"),
                  value=as.Date("2015-01-06"),timeFormat="%Y-%m-%d"),
      
      sliderInput("end",
                  "End Date:",
                  min = as.Date("2015-01-06","%Y-%m-%d"),
                  max = as.Date("2019-12-31","%Y-%m-%d"),
                  value=as.Date("2019-12-31"),timeFormat="%Y-%m-%d"),
      
    ),
    
    mainPanel(
      fluidRow(
        column(6, 
               plotOutput(outputId = "StockPlot")
        ),
        column(6, 
               plotOutput(outputId = "BondPlot")
        )),
      fluidRow(
        column(6, 
               plotOutput(outputId = "GoldPlot")
        ),
        column(6, 
               plotOutput(outputId = "CorPlot")
        ))
    )
  ))


server <- function(input, output) {
  DATAPATH = "../data/"
  df <- read_excel(paste0(DATAPATH,"raw/r_data.xlsx"))
  df$Year <- as.Date(df$Year)
  
  df_ws <- read_excel(paste0(DATAPATH,"result/matlab/weight_stock.xlsx"))
  df_wb <- read_excel(paste0(DATAPATH,"result/matlab/weight_bond.xlsx"))
  df_wg <- read_excel(paste0(DATAPATH,"result/matlab/weight_gold.xlsx"))
  df_nv <- read_excel(paste0(DATAPATH,"result/matlab/values.xlsx"))

  df_ws$Time <- as.Date(df_ws$Time)
  df_wb$Time <- as.Date(df_wb$Time)
  df_wg$Time <- as.Date(df_wg$Time)
  df_nv$Time <- as.Date(df_nv$Time)
  
  dataInput <- reactive({
    start = input$start
    end = input$end
    df <- df[(df$Year >= start & df$Year <= end),]
  })
  
  wsdataInput <- reactive({
    start = input$start
    end = input$end
    df_ws <- df_ws[(df_ws$Time >= start & df_ws$Time <= end),]
    df_ws <- melt(df_ws, id = "Time")
  })
  
  wbdataInput <- reactive({
    start = input$start
    end = input$end
    df_wb <- df_wb[(df_wb$Time >= start & df_wb$Time <= end),]
    df_wb <- melt(df_wb, id = "Time")
  })
  
  wgdataInput <- reactive({
    start = input$start
    end = input$end
    df_wg <- df_wg[(df_wg$Time >= start & df_wg$Time <= end),]
    df_wg <- melt(df_wg, id = "Time")
  })
  
  nvdataInput <- reactive({
    start = input$start
    end = input$end
    df_nv <- df_nv[(df_nv$Time >= start & df_nv$Time <= end),]
    df_nv <- melt(df_nv, id = "Time")
  })
  
  typeInput <- reactive({input$type})
  
  output$StockPlot <- renderPlot({
    if (typeInput() == "Daily Return") {
      ggplot(data = dataInput(), 
             aes(x = Year, y = Stock)) + 
        geom_line(color = "darkred") + 
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank())
    } else {
      ggplot(data = wsdataInput(), aes(x = Time, y = value, color = variable, group = variable)) + 
        geom_line() + ggtitle("Stock Weight")+
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              title = element_text(size=16,face="bold"),
              legend.title=element_blank(),
              legend.position="bottom")
    }
  })
  
  output$BondPlot <- renderPlot({
    if (typeInput() == "Daily Return") {
      ggplot(data = dataInput(), 
             aes(x = Year, y = Bond)) + 
        geom_line(color = "darkblue") + 
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank())
    } else {
      ggplot(data = wbdataInput(), aes(x = Time, y = value, color = variable, group = variable)) + 
        geom_line() + ggtitle("Bond Weight")+
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              title = element_text(size=16,face="bold"),
              legend.title=element_blank(),
              legend.position="bottom")
    }
  })
  
  output$GoldPlot <- renderPlot({
    if (typeInput() == "Daily Return") {
      ggplot(data = dataInput(), 
             aes(x = Year, y = Gold)) +
        geom_line(color = "darkgreen") + 
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank())
    }else {
      ggplot(data = wgdataInput(), aes(x = Time, y = value, color = variable, group = variable)) + 
        geom_line() + ggtitle("Gold Weight")+
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              title = element_text(size=16,face="bold"),
              legend.title=element_blank(),
              legend.position="bottom")
    }
  })
  
  output$CorPlot <- renderPlot({
    if (typeInput() == "Daily Return") {
      df <- read_excel(paste0(DATAPATH,"raw/r_data.xlsx"))
      df$Year <- as.Date(df$Year)
      start = input$start
      end = input$end
      ggcorrplot(cor(df[(df$Year >= start & df$Year <= end),2:4]), 
                 colors = c("#6D9EC1", "white", "#E46726"), lab =TRUE)
    }else {
      ggplot(data = nvdataInput(), aes(x = Time, y = value, color = variable, group = variable)) + 
        geom_line() + ggtitle("Net Values")+
        scale_x_date(date_labels = "%Y-%m-%d") + 
        theme(axis.text=element_text(size=16),
              axis.title=element_text(size=16,face="bold"),
              axis.text.x = element_text(angle = 30,hjust=1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              title = element_text(size=16,face="bold"),
              legend.title=element_blank(),
              legend.position="bottom")
    }
  })
}

shinyApp(ui, server)
