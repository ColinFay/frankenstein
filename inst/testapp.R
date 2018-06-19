library(shiny)


ui_req <- function(request) {
  fluidPage(
    textInput("txt", "Enter text"),
    checkboxInput("caps", "Capitalize"),
    verbatimTextOutput("out"),
    actionButton("fo","fo")
  )
}

server <- function(input, output, session) {
  observeEvent(input$fo, {
    record(session)
  })
  
  output$out <- renderText({
    if (input$caps)
      toupper(input$txt)
    else
      input$txt
  })
}

library(frankenstein)
johndoe <- Creature$new(ui_req, server)
johndoe$as_fresh()
johndoe$revive()

