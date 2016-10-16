fileNames<-dir("data/", pattern =".csv")

shinyUI(fluidPage(
  headerPanel('CSV Filtering Tool'),
  
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                fileNames )
  ),
  
  mainPanel(
 DT::dataTableOutput("table")
)
  
))