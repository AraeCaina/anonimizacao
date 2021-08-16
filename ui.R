library(shiny)

fluidPage(

  titlePanel("Anonimizador"),

  sidebarLayout(
    sidebarPanel(
      fileInput(
        'file_input',
        'Escolha a base de dados para anonimização',
        accept = c(
          'text/csv',
          'text/comma-separated-values',
          '.csv'
        )
      ),
      radioButtons(
        "separador",
        "Separador: ",
        choices = c(";",",",":")
      ),
      radioButtons(
        "encoding",
        "Encoding: ",
        choices = c("UTF-8", "latin1")
      )
    ),

    mainPanel(
      fluidRow(
        dataTableOutput("table_output")
      ),
      hr(),
      fluidRow(
        column(
          6,
          checkboxGroupInput(
            "colunas",
            "Selecione as colunas para anonimizar:",
            choices = NULL
          )
        ),
        column(
          6,
          downloadButton(
            'downloadData',
            'Baixe a base anonimizada'
          )
        )
      )
    )
  )
)
