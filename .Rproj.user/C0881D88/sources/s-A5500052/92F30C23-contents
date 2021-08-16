library(shiny)
library(dplyr)


shinyServer(function(session, input, output) {

  db <- reactive({
    inFile <- input$file_input

    if (is.null(inFile)) return(NULL)

    db <- read.csv(
      inFile$datapath,
      header = TRUE,
      sep = input$separador,
      encoding = input$encoding
    )

    return(db)
  })

  output$table_output <- renderDataTable({
    db <- db()
    db
  },
    options = list(
      scrollX = TRUE,
      pageLength = 5
    )
  )

  observe({
    updateCheckboxGroupInput(
      session,
      "colunas",
      "Selecione as colunas para anonimizar:",
      choices = names(db())
    )
  })

  db_anonimizado <- reactive({


    db <- db()
    colunas <- names(db[,input$colunas])

    db_novo <- db

    for (i in 1:length(colunas)) {

      unicos <- data.frame(
        original = unique(db[,colunas[i]]),
        novo = 1:nrow(unique(db[,colunas[i]]))
      )

      db_novo <<- left_join(db_novo, unicos, by = colunas[i])
    }

    as.data.frame(db_novo)

    db_novo$unico <- 1:nrow(db_novo)

    nomes_novos <- names(db_novo[,(ncol(db_novo)-length(colunas)): ncol(db_novo)])

    db_novo$indicador_anonimizado <- do.call(
      paste0,
      db_novo[,nomes_novos]
    )

    remove <- c(colunas, nomes_novos)

    db_novo <- db_novo[,-which(names(db_novo) %in% remove)]

    db_novo

  })


  output$downloadData <- downloadHandler(
    filename = function() {
      paste('anonimizada.csv')
    },
    content = function(file) {
      write.csv(
        db_anonimizado(),
        file
      )
    }
  )

})
