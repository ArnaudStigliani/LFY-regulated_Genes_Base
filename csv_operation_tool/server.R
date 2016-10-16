shinyServer(function(input, output) {
  
  library(dplyr)
  
  ####################################
  #### when the user selects a dataset in the data directory (input$dataset)
  datasetInput <- reactive({
    inFile2 <- paste("data/", input$dataset, sep = "")
    read.csv(inFile2, header = TRUE, sep = ";", quote = '"')
  })
  
  ####################################
  #### display the table
  output$table <- DT::renderDataTable(DT::datatable(
    datasetInput()
  , caption = 'Table 1: This is a table listing genes regulated by LFY.',style = 'bootstrap', class = 'cell-border stripe',filter = 'top',
  extensions = 'Buttons',
  options = list( pageLength = 20,autoWidth = TRUE,
    dom = 'Bfrtipl',
    buttons = 
      list('copy', 'print', list(
        extend = 'collection',
        buttons = c('csv', 'excel', 'pdf'),
        text = 'Download'
      ))
    
  )))

  
})