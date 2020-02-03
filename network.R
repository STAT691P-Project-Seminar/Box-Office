export("getDataFile")


getDataFile <- function(url){
  
  download <- getURL(url)
  
  data <- read.csv (text = download) 
    
}