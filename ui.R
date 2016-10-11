fileNames<-dir("data/", pattern =".csv")

shinyUI(fluidPage(
  headerPanel('CSV Filtering Tool'),
  
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                fileNames ),
    # ,uiOutput("boxInput"),
    # checkboxInput("min_FC_35LFY_Ler", "min_FC_35LFY_Ler"),
    # checkboxInput("max_FC_35LFY_Ler", "max_FC_35LFY_Ler"),
    downloadButton('downloadData', 'Download')
  ),
  
  mainPanel(
    fluidRow(
      uiOutput("numInput"),
      uiOutput("numInput2")
      # ,conditionalPanel(
      #   condition = "input.min_FC_35LFY_Ler == true",
      #   column(2, uiOutput("min_FC_35LFY_Ler") )
      # )
      # ,
      # conditionalPanel(
      #   condition = "input.max_FC_35LFY_Ler == true",
      #   column(2, uiOutput("max_FC_35LFY_Ler") )
      # )
      # ,
      # column(2, uiOutput("min_P.value_35sLFY_LER_down") ),
      # column(2, uiOutput("max_P.value_35sLFY_LER_down") ),
      # column(2, uiOutput("min_P.value_35sLFY_LER_up") ),
      # column(2, uiOutput("max_P.value_35sLFY_LER_up") ),
      # column(2, uiOutput("min_FC_DEX_MOCK") ),
      # column(2, uiOutput("max_FC_DEX_MOCK") ),
      # column(2, uiOutput("min_P.value_Dex_mock_down") ),
      # column(2, uiOutput("max_P.value_Dex_mock_down") ),
      # column(2, uiOutput("min_FC_DexCyclo_Cyclo") ),
      # column(2, uiOutput("max_FC_DexCyclo_Cyclo") ),
      # column(2, uiOutput("min_FC_LFYGR_WT") ),
      # column(2, uiOutput("max_FC_LFYGR_WT") ),
      # column(2, uiOutput("min_FC_SP1_col") ),
      # column(2, uiOutput("max_FC_SP1_col") ),
      # column(2, uiOutput("min_FC_SP3_col") ),
      # column(2, uiOutput("max_FC_SP3_col") )
    ),
    
    fluidRow(
    DT::dataTableOutput("table")
    )
    
    )
  
))