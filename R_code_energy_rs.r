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
plotRGB(l1992, r=2 , g=3, b=1, stretch="Lin")

# day 2
# brick the data from 1992 again
l1992 <- brick("defor1_.jpg")
l1992
# and we make a RGB plot
plotRGB(l1992, r=1 , g=2, b=3, stretch="Lin")

# let's import the other image using the brick function
# defor2

l2006 <- brick("defor2_.jpg")
l2006
# we are going to plot the image 
plotRGB(l2006, r=1 , g=2, b=3, stretch="Lin")

# let's use the par function 
par(mfrow=c(2,1)) # 2 rows and 1 column
plotRGB(l1992, r=1 , g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1 , g=2, b=3, stretch="Lin")

# we are going to calculate the energy 
# if vegetation is cut, the reflectance of the NIR is lower 
# we use the red and the NIR bands
# NIR - red 

dev.off()

# let's calculate energy in 1992
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1992, col= cl)

# we can see in the image that the red is the highest component and the yellow is the medium one

# let's calculate energy in 2006 
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2006, col= cl)

# difference from one time to another 
dvidif <- dvi1992 - dvi2006
# plot the results
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)
# we have seen the amount of energy that has been lost

# final plot for this area: original images, dvis, final dvi differences
par(mfrow=c(3,2))
plotRGB(l1992, r=1 , g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1 , g=2, b=3, stretch="Lin")
plot(dvi1992, col= cl)
plot(dvi2006, col= cl)
plot(dvidif, col=cld)

# pdf function saves all the plots in a pdf file
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1 , g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1 , g=2, b=3, stretch="Lin")
plot(dvi1992, col= cl)
plot(dvi2006, col= cl)
plot(dvidif, col=cld)
dev.off()

pdf("dvi.pdf")
par(mfrow=c(3,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off() 
