#' @importFrom crayon green red
#' @importFrom glue glue
#' @importFrom shiny withLogErrors isolate getShinyOption

chock <- function(scenario =  NULL){
  function ()
  {
    tryCatch(withLogErrors({
      saveState <- ShinySaveState$new(input = self$input, exclude = self$getBookmarkExclude(),
                                      onSave = function(state) {
                                        private$bookmarkCallbacks$invoke(state)
                                      })
      
      url <- saveShinySaveState(saveState)
      id <- gsub("_state_id_=(.*)", "\\1", url)
      
      clientData <- self$clientData
      url <- paste0(clientData$url_protocol, "//", clientData$url_hostname,
                    if (nzchar(clientData$url_port))
                      paste0(":", clientData$url_port), clientData$url_pathname,
                    "?", url)
      
      if (private$bookmarkedCallbacks$count() > 0) {
        private$bookmarkedCallbacks$invoke(url)
      }
      else {
        cat(green(glue("Saving state {id} at {Sys.time()}")), sep = "\n")
      }
    }), error = function(e) {
      cat(red(glue("Unabled to save the state")), sep = "\n")
    })
  }
}