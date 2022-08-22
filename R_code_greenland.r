# Ice melt in Greenland
# Proxy: LST
# Proxy is a variable that substitutes another variable
# the higher the temperature the higher the melting
# LST means land surface temperature
# setting the working directory
setwd("C:/Users/Emma/Desktop/lab/greenland")
# recalling the libraries
library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

# importing data 
rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist,raster)
import

# making a stack
# TGr = temperature greenland
TGr <- stack(import)
TGr
# plotting the images
plot(TGr)

cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(TGr, col=cl)
# yellow represents the highest temperature

# ggplot of first and final images 
# 2000 vs 2015
p1 <- ggplot() + 
geom_raster(TGr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") + 
ggtitle("LST in 2000")

p2 <- ggplot() +
geom_raster(TGr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

# let's plot them together 
p1+p2

# plotting frequency distributions of data
par(mfrow=c(1, 2))
hist(TGr$lst_2000)
hist(TGr$lst_2015)


par(mfrow=c(2, 2))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)

plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

plot(TGr$lst_2000, TGr$lst_2005, xlim=c(13000,15000), ylim=c(13000,15000))
abline(0,1,col="red")

# make a plot with all the histograms and all the regressions
par(mfrow=c(4,4))
hist(TGr$lst_2000)
hist(TGr$lst_2005)
hist(TGr$lst_2010)
hist(TGr$lst_2015)
plot(TGr$lst_2010, TGr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(TGr$lst_2000, TGr$lst_2005, xlim=c(13000,15000), ylim=c(13000,15000))

# we can do this also through the "pair" function
pairs(TGr)
