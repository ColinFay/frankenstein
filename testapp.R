library(shiny)

ui <- function(request) {
  fluidPage(
    textInput("txt", "Enter text"),
    checkboxInput("caps", "Capitalize"),
    verbatimTextOutput("out"),
    actionButton("fo","fo")
  )
}

# ui <- fluidPage(
#     textInput("txt", "Enter text"),
#     checkboxInput("caps", "Capitalize"),
#     verbatimTextOutput("out"),
#     actionButton("fo","fo")
# )


server <- function(input, output, session) {
  observeEvent(input$fo, {
    session$chock()
  })

  output$out <- renderText({
    if (input$caps)
      toupper(input$txt)
    else
      input$txt
  })
}

frankenstein(ui, server)
