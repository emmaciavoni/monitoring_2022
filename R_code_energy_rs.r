# setting the working directory
setwd("C:/Users/Emma/Desktop/lab/")
# R code for estimating energy in ecosystems
# again we are going to install library raster on R 
# we are going to discover in what way bands are disposed 
# first we are going to upload the data using the "brick" function

# install.packages("rgdal")
library(rgdal)
l1992 <- brick("defor1_.jpg") 
# image of 1992
l1992
# we have only three bands: defor1_.1, defor1_.2, defor1_.3 
# let's make a RGB plot
plotRGB(l1992, r=1 , g=2, b=3, stretch="Lin")
# defor1_.1 is the NIR 
# defor1_.2 is red
# defor1_.3 is green 


plotRGB(l1992, r=2 , g=1, b=3, stretch="Lin")
plotRGB(l1992, r=3 , g=2, b=1, stretch="Lin")
