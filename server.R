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
      data <- data[data$Model_name == input$panel1,]
    }
     data <- data[data$FC_LFY.GR_Col_GSE28062 >= input$slider[1],]
     data <- data[data$FC_LFY.GR_Col_GSE28062 < input$slider[2],]
    # 
    # data <- data[data$DC.C >= input$panel3[1],]
    # data <- data[data$DC.C < input$panel3[2],]
    
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
  output$column1_head <- renderText({
    names(datasetInput())[1]
  })
  
  output$column8_head <- renderText({
    names(datasetInput())[8]
  })
  
  output$column6_head <- renderText({
    names(datasetInput())[6]
  })
  
  output$slider <- renderUI({
    sliderInput("slider", "FC:(LFY-GR/Col)_GSE28062", min=min(datasetInput()$FC_LFY.GR_Col_GSE28062), max=max(datasetInput()$FC_LFY.GR_Col_GSE28062), c(0,1))
  })

  
})