# R code for uploading and visualizing copernicus data in R
# install ncdf4 package and raster
library(ncdf4) 
library(raster)
# set the working directory
setwd("C:/Users/Emma/Desktop/lab/copernicus")


snow20211214 <- raster("c_gls_SCE500_202112140000_CEURO_MODIS_V1.0.1.nc")
snow20211214

plot(snow20211214)
