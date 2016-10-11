shinyServer(function(input, output) {
  
  ####################################
  #### when the user selects a dataset in the data directory (input$dataset)
  datasetInput <- reactive({
    inFile2 <- paste("data/", input$dataset, sep = "")
    read.csv(inFile2, header = TRUE, sep = ";", quote = '"')
  })
  
  ####################################
  #### select integer columns
  integCol <- reactive({
    nums <- sapply(datasetInput(), is.numeric)
    datasetInput()[ , nums]
  })
  
  ####################################
  #### Create widgets in function to column number that contains integer
  output$numInput <- renderUI({
    colNum <- ncol(integCol())
    lapply(1:colNum, function(i) {
      numericInput(paste0("mini_",colnames(integCol())[i]), paste("min_",names(integCol()[i])), min(integCol()[,i],na.rm=TRUE))
    })
  })
  
  output$numInput2 <- renderUI({
    colNum <- ncol(integCol())
    lapply(1:colNum, function(i) {
      numericInput(paste0("maxi_",colnames(integCol())[i]), paste("max_",names(integCol()[i])), max(integCol()[,i],na.rm=TRUE))
    })
  })
  
  # output$boxInput <- renderUI({
  #   colNum <- ncol(integCol())
  #   lapply(1:colNum, function(i) {
  #     checkboxInput(paste0("mini_",colnames(integCol())[i]), paste0("min_",colnames(integCol())[i]))
  #   })
  # })
  
  # output$boxInput <- renderUI({
  #   colNum <- ncol(integCol())
  #   lapply(1:colNum, function(i) {
  #   checkboxGroupInput(paste0("mini_",colnames(integCol())[i]), paste0("mini_",colnames(integCol())[i]),paste0("mini_",colnames(integCol())[i]))
  # })
  # })
  
  ####################################
  #### when the user does multiple filters on the table
  datasetInputModif <- reactive({
    
    data<-datasetInput()
    
    for(i in colnames(integCol())){
    data <- data[is.na(data[[i]]) | data[[i]] >= input[[paste0("mini_",i)]] ,]
    data <- data[is.na(data[[i]]) | data[[i]] <= input[[paste0("maxi_",i)]] ,]
    }
    data
    
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
  # output$min_FC_35LFY_Ler<- renderUI({
  #   numericInput("minimum_FC_35LFY_Ler", "Min_FC_35LFY_Ler", min(datasetInput()$FC_35sLFY_LER,na.rm=TRUE))
  # })
  output$max_FC_35LFY_Ler<- renderUI({
    numericInput("maximum_FC_35LFY_Ler", "Max_FC_35LFY_Ler", max(datasetInput()$FC_35sLFY_LER,na.rm=TRUE))
  })
  
  # output$min_P.value_35sLFY_LER_up<- renderUI({
  #   numericInput("minimum_P.value_35sLFY_LER_up", "Min_Pvalue_35sLFY_LER_up", min(datasetInput()$P.value_35sLFY_LER_up,na.rm=TRUE))
  # })
  output$max_P.value_35sLFY_LER_up<- renderUI({
    numericInput("maximum_P.value_35sLFY_LER_up", "Max_Pvalue_35sLFY_LER_up", max(datasetInput()$P.value_35sLFY_LER_up,na.rm=TRUE))
  })
  
  # output$min_FC_DEX_MOCK<- renderUI({
  #   numericInput("minimum_FC_DEX_MOCK", "Min_FC_DEX_MOCK", min(datasetInput()$FC_Dex_mock,na.rm=TRUE))
  # })
  output$max_FC_DEX_MOCK<- renderUI({
    numericInput("maximum_FC_DEX_MOCK", "Max_FC_DEX_MOCK", max(datasetInput()$FC_Dex_mock,na.rm=TRUE))
  })
  
  # output$min_P.value_Dex_mock_down<- renderUI({
  #   numericInput("minimum_P.value_Dex_mock_down", "Min_P.value_Dex_mock_down", min(datasetInput()$P.value_Dex_mock_down,na.rm=TRUE))
  # })
  output$max_P.value_Dex_mock_down<- renderUI({
    numericInput("maximum_P.value_Dex_mock_down", "Max_P.value_Dex_mock_down", max(datasetInput()$P.value_Dex_mock_down,na.rm=TRUE))
  })
  
  # output$min_FC_DexCyclo_Cyclo<- renderUI({
  #   numericInput("minimum_FC_DexCyclo_Cyclo", "Min_FC_DexCyclo_Cyclo", min(datasetInput()$FC_DexCyclo_cyclo,na.rm=TRUE))
  # })
  output$max_FC_DexCyclo_Cyclo<- renderUI({
    numericInput("maximum_FC_DexCyclo_Cyclo", "Max_FC_DexCyclo_Cyclo", max(datasetInput()$FC_DexCyclo_cyclo,na.rm=TRUE))
  })
  
  # output$min_FC_LFYGR_WT<- renderUI({
  #   numericInput("minimum_FC_LFYGR_WT", "Min_FC_LFYGR_WT", min(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE))
  # })
  output$max_FC_LFYGR_WT<- renderUI({
    numericInput("maximum_FC_LFYGR_WT", "Max_FC_LFYGR_WT", max(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE))
  })
  
  # output$min_FC_SP1_col<- renderUI({
  #   numericInput("minimum_FC_SP1_col", "Min_FC_SP1_col", min(datasetInput()$FC_SP1_col,na.rm=TRUE))
  # })
  output$max_FC_SP1_col<- renderUI({
    numericInput("maximum_FC_SP1_col", "Max_FC_SP1_col", max(datasetInput()$FC_SP1_col,na.rm=TRUE))
  })
  
  # output$min_FC_SP3_col<- renderUI({
  #   numericInput("minimum_FC_SP3_col", "Min_FC_SP3_col", min(datasetInput()$FC_SP3_col,na.rm=TRUE))
  # })
  output$max_FC_SP3_col<- renderUI({
    numericInput("maximum_FC_SP3_col", "Max_FC_SP3_col", max(datasetInput()$FC_SP3_col,na.rm=TRUE))
  })
  
  # output$min_P.value_35sLFY_LER_down<- renderUI({
  #   numericInput("minimum_P.value_35sLFY_LER_down", "Min_Pvalue_35LFY_LER_down", min(datasetInput()$P.value_35sLFY_LER_down,na.rm=TRUE))
  # })
  output$max_P.value_35sLFY_LER_down<- renderUI({
    numericInput("maximum_P.value_35sLFY_LER_down", "Max_Pvalue_35LFY_LER_down", max(datasetInput()$P.value_35sLFY_LER_down,na.rm=TRUE))
  })
  
  # output$min_P.value_35sLFY_LER_up<- renderUI({
  #   numericInput("minimum_P.value_35sLFY_LER_up", "Min_Pvalue_35sLFY_LER_up", min(datasetInput()$P.value_35sLFY_LER_up,na.rm=TRUE))
  # })
  output$max_P.value_35sLFY_LER_up<- renderUI({
    numericInput("maximum_P.value_35sLFY_LER_up", "Max_Pvalue_35sLFY_LER_up", max(datasetInput()$P.value_35sLFY_LER_up,na.rm=TRUE))
  })
  
})