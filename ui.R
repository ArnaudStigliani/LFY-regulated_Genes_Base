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
                         textOutput("column4_head"),
                         c("All",
                           "Signaling","Transcription","Protein modification","Sugar/amino acid biosynthesis"	 ))
      ),
      column(4,
             sliderInput("panel2",
                         textOutput("column5_head"),
                         0, 50, c(0,50))
      ),
      column(4,
             sliderInput("panel3",
                         textOutput("column6_head"),
                         0, 40, c(0,40))
      )
    ),
    DT::dataTableOutput("table")
  )
  
))