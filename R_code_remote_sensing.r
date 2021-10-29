# R code for ecosystem monitoring for remote sensing
# First of all we need to insall additional packagings

# https://cran.r-project.org/web/packages/raster/raster.pdf

install.packages("raster")

library(raster)

setwd("C:/Users/Emma/Desktop/lab/")

# we are going to import satellite data 
l2011 <- brick("p224r63_2011.grd") 
# objects cannot be numbers


l2011

plot(l2011)
# B1 is the reflectance in the blue band 
# B2 is the reftlectance in the green band
# B3 is the reflectance in the red band

cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl)


plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") 
