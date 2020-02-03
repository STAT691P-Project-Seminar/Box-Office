# This is the master file for tying together all the helper functions
library(modules) ## mandatory install

# expose the modules here
packages.Self <- modules::use("libs.R")
graphics.Self <- modules::use("graphics.R")
munging.Self <- modules::use("munging.R")
network.Self <- modules::use("network.R")


# load libraries
pkg$getPackages()

# get data from network
dat <- network$getDataFile("https://sixtusdakurah.com/projects/box-office/acting_credits.csv")


View(dat)






