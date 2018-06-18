#' Record a session
#' 
#' @param session the session object
#' 
#' @importFrom attempt attempt
#' @export

record <- function(session){
  attempt(session$chock(), 
          "Unable to save the state.\nDid you call `record` from outside a Frankenstein instance?")
}

#' Monitor a Shiny App 
#' 
#' @param session the session object 
#' @param intervalMs interval in millisecond between each monitoring 
#' @param dispose wether or not to dispose of the non-last states
#' @param folder the folder where the states are kept
#' 
#' @importFrom shiny reactiveTimer observe
#' @importFrom attempt attempt
#' @importFrom shiny reactiveTimer observe
#' 
#' @export
monitor <- function(session, intervalMs, dispose = TRUE, folder = "shiny_bookmarks"){
  autoInvalidate <- reactiveTimer(intervalMs)
  observe({
    autoInvalidate()
    attempt(session$chock(), 
            "Unable to save the state.\nDid you call `record` from outside a Frankenstein instance?")
    if (dispose){
      last_state <- get_last_state(folder)
      a <- list.files(folder, full.names = TRUE)
      a <- a[!grepl(last_state, a)]
      x <- lapply(a, unlink, recursive = TRUE)
      invisible(x)
    }
  })
}

#' @importFrom crayon green
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

