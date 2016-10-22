fileNames<-dir("data/", pattern =".csv")

shinyUI(fluidPage(
  headerPanel('LFY-regulated Genes Base'),
  
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", fileNames )
  ),
  
  mainPanel(
 DT::dataTableOutput("table")
)
  
))