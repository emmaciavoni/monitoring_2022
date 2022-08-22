setwd("C:/Users/Emma/Desktop/lab/exam")
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)

fire2022043 <- raster("c_gls_BA300_202204300000_GLOBE_S3_V1.2.1.nc")
fire2022043

plot(fire2022043)

cl <- colorRampPalette (c('red','orange','yellow'))(100)
plot(fire2022043, col=cl)


rlist <- list.files (pattern="BA300")
rlist


list_rast <- lapply(rlist, raster)
list_rast
