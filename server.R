shinyServer(function(input, output) {
  
  ####################################
  #### when the user selects a dataset in the data directory (input$dataset)
  datasetInput <- reactive({
    inFile2 <- paste("data/", input$dataset, sep = "") 
    read.csv(inFile2, header = TRUE, sep = ";", quote = '"')
  })
  
  
  
  ####################################
  #### when the user does multiple filters on the table
  datasetInputModif <- reactive({
    data<-datasetInput()
    if (input$panel1 != "All") {
      data <- data[data$Functional.category == input$panel1,]
    }
    
    data <- data[data$D.M >= input$panel2[1],]
    data <- data[data$D.M < input$panel2[2],]
    
    data <- data[data$DC.C >= input$panel3[1],]
    data <- data[data$DC.C < input$panel3[2],]
    
    data
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    datasetInputModif()
  }))
  
  output$downloadData <- downloadHandler(
    filename = function() { input$dataset },
    content = function(file) {
      write.table(datasetInputModif(), file, row.names = FALSE,sep = ";")
    }
  )
  
  ####################################
  #### collect specific headers
  output$column4_head <- renderText({
    names(datasetInput())[4]
  })
  
  output$column5_head <- renderText({
    names(datasetInput())[5]
  })
  
  output$column6_head <- renderText({
    names(datasetInput())[6]
  })
  
})