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
  
     data <- data[is.na(data$FC_35LFY_Ler_GSE911) | data$FC_35LFY_Ler_GSE911 >= input$slider_FC_35LFY_Ler_GSE911[1] ,]
     data <- data[is.na(data$FC_35LFY_Ler_GSE911) | data$FC_35LFY_Ler_GSE911 <= input$slider_FC_35LFY_Ler_GSE911[2] ,]

     data <- data[is.na(data$FC_DexCyclo_Cyclo_GSE91) | data$FC_DexCyclo_Cyclo_GSE911 >= input$slider_FC_DexCyclo_Cyclo_GSE911[1],]
     data <- data[is.na(data$FC_DexCyclo_Cyclo_GSE91) | data$FC_DexCyclo_Cyclo_GSE911 <= input$slider_FC_DexCyclo_Cyclo_GSE911[2],]
    
     data <- data[is.na(data$FC_DEX_MOCK_GSE911) | data$FC_DEX_MOCK_GSE911>= input$slider_FC_DEX_MOCK_GSE911[1],]
     data <- data[is.na(data$FC_DEX_MOCK_GSE911) | data$FC_DEX_MOCK_GSE911 <= input$slider_FC_DEX_MOCK_GSE911[2],]

     data <- data[is.na(data$FC_LFYGR_WT_GSE28062) | data$FC_LFYGR_WT_GSE28062 >= input$slider_FC_LFYGR_WT_GSE28062[1],]
     data <- data[is.na(data$FC_LFYGR_WT_GSE28062) | data$FC_LFYGR_WT_GSE28062 <= input$slider_FC_LFYGR_WT_GSE28062[2],]
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
  output$column3_head <- renderText({
    names(datasetInput())[3]
  })
  
  output$column8_head <- renderText({
    names(datasetInput())[8]
  })
  
  output$column6_head <- renderText({
    names(datasetInput())[6]
  })
  
  output$slider_FC_35LFY_Ler_GSE911 <- renderUI({
    sliderInput("slider_FC_35LFY_Ler_GSE911", "FC_35LFY_Ler_GSE911", min=min(datasetInput()$FC_35LFY_Ler_GSE911,na.rm=TRUE), max=max(datasetInput()$FC_35LFY_Ler_GSE911,na.rm=TRUE), c(min(datasetInput()$FC_35LFY_Ler_GSE911,na.rm=TRUE),max(datasetInput()$FC_35LFY_Ler_GSE911,na.rm=TRUE)))
  })

  output$slider_FC_DexCyclo_Cyclo_GSE911 <- renderUI({
    sliderInput("slider_FC_DexCyclo_Cyclo_GSE911", "FC_DexCyclo_Cyclo_GSE911", min=min(datasetInput()$FC_DexCyclo_Cyclo_GSE911,na.rm=TRUE), max=max(datasetInput()$FC_DexCyclo_Cyclo_GSE911,na.rm=TRUE), c(min(datasetInput()$FC_DexCyclo_Cyclo_GSE911,na.rm=TRUE),max(datasetInput()$FC_DexCyclo_Cyclo_GSE911,na.rm=TRUE)))
  })

  output$slider_FC_DEX_MOCK_GSE911 <- renderUI({
    sliderInput("slider_FC_DEX_MOCK_GSE911", "FC_DEX_MOCK_GSE911", min=min(datasetInput()$FC_DEX_MOCK_GSE911,na.rm=TRUE), max=max(datasetInput()$FC_DEX_MOCK_GSE911,na.rm=TRUE), c(min(datasetInput()$FC_DEX_MOCK_GSE911,na.rm=TRUE),max(datasetInput()$FC_DEX_MOCK_GSE911,na.rm=TRUE)))
  })

  output$slider_FC_LFYGR_WT_GSE28062 <- renderUI({
    sliderInput("slider_FC_LFYGR_WT_GSE28062", "FC_LFYGR_WT_GSE28062", min=min(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE), max=max(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE), c(min(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE),max(datasetInput()$FC_LFYGR_WT_GSE28062,na.rm=TRUE)))
  })
  
})