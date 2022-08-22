setwd("C:/Users/Emma/Desktop/lab/exam")
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)

fire2022043 <- raster("c_gls_BA300_202204300000_GLOBE_S3_V1.2.1.nc")
fire2022043
