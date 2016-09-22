shinyUI(pageWithSidebar(
  headerPanel('CSV Filtering Tool'),

  sidebarPanel(
    selectInput("dataset", "Choose a dataset:", 
                choices = c("william_2003", "Winter_2014_Winter_seedling")),
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
             selectInput("panel2",
                         textOutput("column5_head"),
                         c("All",
                           4,3,2.5 ))
      ),
      column(4,
             selectInput("panel3",
                         textOutput("column6_head"),
                         c("All",
                         2,2.5,3))
      )
    ),
    DT::dataTableOutput("table")
  )
  
))