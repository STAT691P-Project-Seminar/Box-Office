## This helps with library import and avoid duplicate imports

export("getPackages")

getPackges <- function(){
  # read in the list of packages
  listOfPackages <- as.vector ( read.delim2("packages.txt")[, 1] )
  # resolve newly added packages
  newPackages <- listOfPackages[!(listOfPackages %in% installed.packages()[,"Package"])]
  # install new packages if necessary
  if(length(newPackages)) install.packages(newPackages)
  
}
