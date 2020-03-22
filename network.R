export("getDataFile")


getDataFile <- function(url){
  import("RCurl")
  download <- getURL(url)
  
  data <- utils::read.csv (text = download, na.strings=c("","NA", "#N/A", "[]")) 
    
}