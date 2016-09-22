shinyServer(function(input, output) {
  
  ####################################
  #### when the user select a dataset in the data directory (input$dataset)
  datasetInput <- reactive({
    inFile2 <- paste("data/", input$dataset, sep = "", ".csv") 
    read.csv(inFile2, header = TRUE, sep = ";", quote = '"')
  })
  
  datasetInputModif <- reactive({
    data<-datasetInput()
    if (input$panel1 != "All") {
      data <- data[data$Functional.category == input$panel1,]
    }
    if (input$panel2 != "All") {
      data <- data[data$D.M == input$panel2,]
    }
    if (input$panel3 != "All") {
      data <- data[data$DC.C == input$panel3,]
    }
    data
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    datasetInputModif()
  }))
  
  output$downloadData <- downloadHandler(
    filename = function() { paste(input$dataset, '.csv', sep='') },
    content = function(file) {
      write.table(datasetInputModif(), file, row.names = FALSE,sep = ";")
      #write.csv(datasetInputModif(), file,sep = ";")
    }
  )

  
  output$column4_head <- renderText({
    names(datasetInput())[4]
  })
  
  output$column5_head <- renderText({
    names(datasetInput())[5]
  })
  
  output$column6_head <- renderText({
    names(datasetInput())[6]
  })
  
  output$columns <- renderText({
    names(datasetInput())
  })
  
})