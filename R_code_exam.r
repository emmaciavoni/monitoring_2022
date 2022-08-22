setwd("C:/Users/Emma/Desktop/lab/exam")
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)

fire20210831 <- raster("c_gls_BA300_202108310000_GLOBE_S3_V1.2.1.nc")
fire20210831

plot(fire20210831)

cl <- colorRampPalette (c('red','orange','yellow'))(100)
plot(fire20210831, col=cl)


rlist <- list.files (pattern="BA300")
rlist


list_rast <- lapply(rlist, raster)
list_rast

cl <- colorRampPalette (c('black','red','white'))(100)
plot(fire20210831, col=cl)
