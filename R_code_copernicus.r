# R code for uploading and visualizing copernicus data in R
# install ncdf4 package and raster
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)
# set the working directory
setwd("C:/Users/Emma/Desktop/lab/copernicus")


snow20211214 <- raster("c_gls_SCE500_202112140000_CEURO_MODIS_V1.0.1.nc")
snow20211214

plot(snow20211214)


-----# day 2
# recalling the libraries in R and setting the working directory 


# colorRampPalette to see the snow coverage at higher latitues 
cl <- colorRampPalette (c('dark blue','blue','light blue'))(100)
plot(snow20211214, col=cl)


# viridis package used to change the colour
# it directly uses a series of colours 
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties
install.packages("viridis")
library(viridis)
library(RStoolbox) 
library(ggplot2)

# ggplot and add geom raster, the geometry we want to use (e.g. histograms) 
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent))
# ggplot with viridis
# scale_fill_viridis function is the function we use to change the colours 

ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) +
scale_fill_viridis(option="cividis") +
ggtitle("cividis palette")
