#' Launch web-based interface for configuring and running citrus
#' 
#' Launches shiny-based interface to configuring and running Citrus. Creates runCitrus.R that can be used to run analysis
#' in data directory. 
#' 
#' @param dataDirectory If specified, launches configuration UI with files in data directory. If \code{NULL}, 
#' prompts user to select a single FCS file in data directory. 
#' 
#' @author Robert Bruggner (AZK)
#' @export
#' 
#' @examples
#' # Uncomment to run
#' # citrus.launchUI(file.path(system.file(package = "citrus"),"extdata","example1"))
citrus.launchHackedUI = function(dataDirectory=NULL){  
  
#   library("shiny")
#   library("brew")
#   library("citrus")
  
  if (!is.null(dataDirectory)){
    dataDir <<-dataDirectory
  }
  
  #sapply(list.files(file.path(system.file(package = "citrus"),"shinyGUI","guiFunctions"),pattern=".R",full.names=T),source)
  
  res = tryCatch({
    runApp(appDir=file.path(system.file(package = "hacked.citrus.ui"),"shinyGUI"),launch.browser=T)
  }, warning = function(w){
    cat(paste(w,"\n"));
  },error = function(e){
    stop(paste("Unexpected Error:",e))
  }, finally = {
    
  })
  
  outputPath = file.path(dataDir,"citrusOutput")
  if (runCitrus){
    setwd(outputPath)
    runFile = file.path(outputPath,"runCitrus.R")
    cat(paste("Running Citrus File:",runFile,"\n"))
    logFilePath = file.path(outputPath,"citrusOutput.log")
    cat(paste("Logging output to:",logFilePath,"\n"))
    logFile = .logOn(logFilePath)
    
    source(runFile)
    
    .logOff(logFile=logFile)
  }
  return(paste("Citrus Output in:",outputPath))  
}

.logOn = function(filePath,messages=F){
  logFile = file(filePath,open = "wt")
  sink(logFile,split=T)
  if (messages){
    sink(logFile,type="message")
  }
  return(logFile)
}

.logOff = function(logFile,messages=F){
  if (messages){
    sink(type="messsage")
  }
  sink()
  close(logFile)
}
