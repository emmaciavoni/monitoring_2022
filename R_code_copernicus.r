# R code for uploading and visualizing copernicus data in R
# install ncdf4 package and raster
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)
# set the working directory
setwd("C:/Users/Emma/Desktop/lab/copernicus")


snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
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

-----# day 3
library(ncdf4) 
library(raster)
library(viridis)
library(RStoolbox) 
library(ggplot2)
library(patchwork)
# set the working directory
setwd("C:/Users/Emma/Desktop/lab/copernicus")

# lapply function for uploading both data at the same time
# the pattern "SCE" is the one in common between the two files
rlist <- list.files (pattern="SCE")
rlist

list_rast <- lapply(rlist, raster)
list_rast

snowstack <- stack(list_rast)
snowstack

ssummer <- snowstack$Snow.Cover.Extent.1
ssummer
swinter <- snowstack$Snow.Cover.Extent.2
swinter

p1 <- ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during summer")

p2 <- ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter")

# let's patchwork them together
p1/p2

# crop function
# you can crop an image on a certain area 
# longitude from 0 to 20 
# latitude from 30 to 50 

ext <- c(0, 20, 30, 50) 
# stack_cropped, this will crop the whole stack, and then 
ssummer_cropped <- crop(ssummer, ext)
summer_cropped
swinter_cropped <- crop(swinter, ext)

p1 <- ggplot() +
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.1)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during summer")

p2 <- ggplot() +
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent.2)) +
scale_fill_viridis(option="viridis") +
ggtitle("Snow cover during freezing winter")

p1/p2
