# R code for ecosystem monitoring for remote sensing
# First of all we need to insall additional packagings

# https://cran.r-project.org/web/packages/raster/raster.pdf

install.packages("raster")

library(raster)

setwd("C:/lab/"C:/Users/Emma/Desktop)  

# we are going to import satellite data 
brick(
