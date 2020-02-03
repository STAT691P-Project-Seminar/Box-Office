## This is the master file for tying together all the helper functions

lib <- module::use("R")

## Run this anytime you imports a new library
lib$libs$getPackages("packges.txt")

## To start a new section, add this signature

####################################################
####
##   Section Name and Brief Description
####
####################################################

## Example is as below

####################################################
####
##   Munging ... data cleanning
####
####################################################

dat <- read.csv("path to data")

dat <- lib$munging$clean(dat)
dat <- lib$munging$recode(dat)



####################################################
####
##   Generate results
####
####################################################


# gene

lib$graphics$barplot(dat)
lib$graphics$lineplot(dat)




