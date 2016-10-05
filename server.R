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
    
    data <- data[is.na(data$FC_35sLFY_LER) | data$FC_35sLFY_LER >= input$minimum_FC_35LFY_Ler ,]
    data <- data[is.na(data$FC_35sLFY_LER) | data$FC_35sLFY_LER <= input$maximum_FC_35LFY_Ler ,]
    
    data <- data[is.na(data$FC_DexCyclo_cyclo) | data$FC_DexCyclo_cyclo >= input$minimum_FC_DexCyclo_Cyclo,]
    data <- data[is.na(data$FC_DexCyclo_cyclo) | data$FC_DexCyclo_cyclo <= input$maximum_FC_DexCyclo_Cyclo,]
    
    data <- data[is.na(data$FC_Dex_mock) | data$FC_Dex_mock>= input$minimum_FC_DEX_MOCK,]
    data <- data[is.na(data$FC_Dex_mock) | data$FC_Dex_mock <= input$maximum_FC_DEX_MOCK,]
    
    data <- data[is.na(data$FC_LFYGR_WT_GSE28062) | data$FC_LFYGR_WT_GSE28062 >= input$minimum_FC_LFYGR_WT,]
    data <- data[is.na(data$FC_LFYGR_WT_GSE28062) | data$FC_LFYGR_WT_GSE28062 <= input$maximum_FC_LFYGR_WT,]
    
    data <- data[is.na(data$FC_SP1_col) | data$FC_SP1_col >= input$minimum_FC_SP1_col,]
    data <- data[is.na(data$FC_SP1_col) | data$FC_SP1_col <= input$maximum_FC_SP1_col,]
    
    data <- data[is.na(data$FC_SP3_col) | data$FC_SP3_col >= input$minimum_FC_SP3_col,]
    data <- data[is.na(data$FC_SP3_col) | data$FC_SP3_col <= input$maximum_FC_SP3_col,]
    
  })
  
  ####################################
  #### display the table
  output$table <- DT::renderDataTable(DT::datatable({
    datasetInputModif()
  }))
  
  ####################################
  #### display the download button
  output$downloadData <- downloadHandler(
    filename = function() { input$dataset },
    content = function(file) {
      write.table(datasetInputModif(), file, row.names = FALSE,sep = ";")
    }
  )
  
  ####################################
  #### collect specific headers
  output$column3_head <- renderText({
    names(datasetInput())[3]
  })
  
  output$column8_head <- renderText({
    names(datasetInput())[8]
  })
  
  output$column6_head <- renderText({
    names(datasetInput())[6]
  })
  
  ####################################
  #### create numeric input to enter min and max
  output$min_FC_35LFY_Ler<- renderUI({
    numericInput("minimum_FC_35LFY_Ler", "Min_FC_35LFY_Ler:", min(datasetInput()$FC_35sLFY_LER,na.rm=TRUE))
  })
  output$max_FC_35LFY_Ler<- renderUI({
    numericInput("maximum_FC_35LFY_Ler", "Max_FC_35LFY_Ler:", max(datasetInput()$FC_35sLFY_LER,na.rm=TRUE))
  })
  
  output$min_FC_DexCyclo_Cyclo<- renderUI({
    numericInput("minimum_FC_DexCyclo_Cyclo", "Min_FC_DexCyclo_Cyclo:", min(datasetInput()$FC_DexCyclo_cyclo,na.rm=TRUE))
  })
  output$max_FC_DexCyclo_Cyclo<- renderUI({
    numericInput("maximum_FC_DexCyclo_Cyclo", "Max_FC_DexCyclo_Cyclo:", max(datasetInput()$FC_DexCyclo_cyclo,na.rm=TRUE))
  })
  
  output$min_FC_DEX_MOCK<- renderUI({
    numericInput("minimum_FC_DEX_MOCK", "Min_FC_DEX_MOCK:", min(datasetInput()$FC_Dex_mock,na.rm=TRUE))
  })
  output$max_FC_DEX_MOCK<- renderUI({
    numericInput("maximum_FC_DEX_MOCK", "Max_FC_DEX_MOCK:", max(datasetInput()$FC_Dex_mock,na.rm=TRUE))
  })
  
  output$min_FC_LFYGR_WT<- renderUI({
    numericInput("minimum_FC_LFYGR_WT", "Min_FC_LFYGR_WT:", min(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE))
  })
  output$max_FC_LFYGR_WT<- renderUI({
    numericInput("maximum_FC_LFYGR_WT", "Max_FC_LFYGR_WT:", max(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE))
  })
  
  output$min_FC_SP1_col<- renderUI({
    numericInput("minimum_FC_SP1_col", "Min_FC_SP1_col:", min(datasetInput()$FC_SP1_col,na.rm=TRUE))
  })
  output$max_FC_SP1_col<- renderUI({
    numericInput("maximum_FC_SP1_col", "Max_FC_SP1_col:", max(datasetInput()$FC_SP1_col,na.rm=TRUE))
  })
  
  output$min_FC_SP3_col<- renderUI({
    numericInput("minimum_FC_SP3_col", "Min_FC_SP3_col:", min(datasetInput()$FC_SP3_col,na.rm=TRUE))
  })
  output$max_FC_SP3_col<- renderUI({
    numericInput("maximum_FC_SP3_col", "Max_FC_SP3_col:", max(datasetInput()$FC_SP3_col,na.rm=TRUE))
  })
  
})