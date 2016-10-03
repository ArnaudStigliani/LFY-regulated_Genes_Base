fileNames<-dir("data/", pattern =".csv")

shinyUI(fluidPage(
  headerPanel('CSV Filtering Tool'),
  
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                fileNames ),
    downloadButton('downloadData', 'Download')
  ),
  
  mainPanel(
    fluidRow(
      column(2, uiOutput("min_FC_35LFY_Ler") ),
      column(2, uiOutput("max_FC_35LFY_Ler") ),
      column(2, uiOutput("min_FC_DexCyclo_Cyclo") ),
      column(2, uiOutput("max_FC_DexCyclo_Cyclo") ),
      column(2, uiOutput("min_FC_DEX_MOCK") ),
      column(2, uiOutput("max_FC_DEX_MOCK") ),
      column(2, uiOutput("min_FC_LFYGR_WT") ),
      column(2, uiOutput("max_FC_LFYGR_WT") )
    ),
    
    fluidRow(
    DT::dataTableOutput("table")
    )
    
    )
  
))