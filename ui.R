fileNames<-dir("data/", pattern =".csv")

shinyUI(pageWithSidebar(
  headerPanel('CSV Filtering Tool'),
  
  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                fileNames ),
    downloadButton('downloadData', 'Download')
  ),
  
  mainPanel(
    fluidRow(
      column(4,
             selectInput("panel1",
                         textOutput("column1_head"),
                         c("All",
                           "LFY-GR_vs_WT_GSE28062","Model2","Model3","Model4"	 ))
      )
      , column(4, uiOutput("slider") )
      # , column(4,
      #         sliderInput("panel2",
      #                     textOutput("column8_head"),
      #                     0, 50, c(0,50))
      # )
      #, column(4,
      #        sliderInput("panel3",
      #                    textOutput("column6_head"),
      #                    0, 40, c(0,40))
      # )
    ),
    DT::dataTableOutput("table")
  )
  
))