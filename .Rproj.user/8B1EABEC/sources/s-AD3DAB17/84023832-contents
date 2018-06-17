#' @importFrom attempt attempt
#' @export

record <- function(session){
  attempt(session$chock(), 
          "Unable to save the state.\nDid you call `record` from outside a Frankenstein instance?")
}

#' @importFrom shiny reactiveTimer observe
#' @importFrom attempt attempt
#' @importFrom shiny reactiveTimer observe
#' 
#' @export
monitor <- function(session, intervalMs){
  autoInvalidate <- reactiveTimer(intervalMs)
  observe({
    autoInvalidate()
    attempt(session$chock(), 
            "Unable to save the state.\nDid you call `record` from outside a Frankenstein instance?")
  })
}

#' @importFrom crayon green
#' 
#' 
get_last_state <- function(folder = "shiny_bookmarks"){
  a <- list.files(folder, full.names = TRUE)
  if (length(a) == 0){
    cat(green("No previous state found"), "\n")
    Sys.sleep(1)
    return(0)
  }  else {
    last_state <- do.call(rbind, lapply(a, file.info))
    last_state$name <- basename(a)
    last_state <- last_state[rev(order(last_state$mtime)), ]
    last_state <- last_state$name[1]
    return(last_state)
  }
  
}

