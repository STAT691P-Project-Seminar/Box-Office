## This helps with library import and avoid duplicate imports

export("getPackages")

getPackages <- function(){
  # read in the list of packages
  listOfPackages <- as.vector ( utils::read.delim2("packages.txt")[, 1] )
  # resolve newly added packages
  newPackages <- listOfPackages[!(listOfPackages %in% utils::installed.packages()[,"Package"])]
  # install new packages if necessary
  if(length(newPackages)) utils::install.packages(newPackages)
  # now load the libraries
  lapply(listOfPackages, require, character.only = TRUE)
  
}
