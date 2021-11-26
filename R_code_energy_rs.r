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


# day 3
# installing new packages 

# for new graphical properties
install.packages("ggplot2")

# for new multiframe properties
install.packages("gridExtra") 

# for managing Copernicus data
install.packages("ncdf4") 

# https://cran.r-project.org/web/packages/RStoolbox/index.html
install.packages("RStoolbox")

# R code for chemical cycling study
# time series of NO2 changed during the lockdown

# setting the workind directory
setwd("C:/Users/Emma/Desktop/lab/en")

library(raster)
en01 <- raster("EN_0001.png")
# what is the range of the data?
en01

# colors that we can use
# https://www.google.com/search?q=R+colours+names&tbm=isch&ved=2ahUKEwiF-77Z1bX0AhULtKQKHQ3WDWYQ2-cCegQIABAA&oq=R+colours+names&gs_lcp=CgNpbWcQAzIECAAQEzoHCCMQ7wMQJzoICAAQCBAeEBNQiQhYnwxgwg1oAHAAeACAAUqIAZYDkgEBNpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=vKKgYYWtOovokgWNrLewBg&bih=526&biw=1056#imgrc=OtMzJfyT_OwIiM


# plot the NO2 values of January 2020 by the cl palette
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(en01, col=cl) 

# plot the NO2 values of March 2020 
en13 <- raster("EN_0013.png")
en13
cl <- colorRampPalette(c("red", "orange", "yellow")) (100) 
plot(en13, col=cl)

# comparing the images with the par function" 
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# importing all the images
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

# plot all the data together 
par(mfrow=c(4,4))
plot(en01, col=cl)
plot(en02, col=cl)
plot(en03, col=cl)
plot(en04, col=cl)
plot(en05, col=cl)
plot(en06, col=cl)
plot(en07, col=cl)
plot(en08, col=cl)
plot(en09, col=cl)
plot(en10, col=cl)
plot(en11, col=cl)
plot(en12, col=cl)
plot(en13, col=cl)

# stack function 

en <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)
plot(en, col=cl)

# plot only the first image from the stack 
en
plot(en$EN_0001, col=cl)

# plot RGB 
plotRGB(en, r=1, g=7, b=13, stretch="Lin") 

# pairs 
