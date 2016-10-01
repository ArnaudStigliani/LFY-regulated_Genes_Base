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
       column(2, uiOutput("slider_FC_35LFY_Ler_GSE911") )
      , column(2, uiOutput("slider_FC_DexCyclo_Cyclo_GSE911") )
       , column(2, uiOutput("slider_FC_DEX_MOCK_GSE911") )
       , column(2, uiOutput("slider_FC_LFYGR_WT_GSE28062") )
    ),
    
    fluidRow(
    DT::dataTableOutput("table")
    )
    )
  
))