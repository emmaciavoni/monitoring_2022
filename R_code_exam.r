### Hello! This is my code for the Monitoring Ecosystem exam ###
# In this project I want to analyze the effects of wildfires that occurred in Canada in the summer of 2021
# It was stated that the 2021 season became the third worst wildfire season on record, in terms of area burned 

# I start by analyzing the fraction of vegetation cover in the year 2020, 2021, and 2022 to see how the differences in the vegetation before, during, and after the fire events 

### FCOVER ANALYSIS ###

# recalling the libraries into R

library(raster) # work with raster file
library(ncdf4) # import the copernicus file in nc
library(viridis) # for the color palette
library(ggplot2) # for graphics ggplot functions
library(patchwork) # multiframe graphics
library(gridExtra) # multiframe ggplot
library(devtools) #  provides functions for package development, installation, and management
library(RStoolbox) # useful for remote sensing image processing

# recalling the working directory

setwd("C:/Users/Emma/Desktop/exam")

# I downloaded these three files from Copernicus: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
# c_gls_FCOVER300-RT6_202007310000_GLOBE_OLCI_V1.1.1 # from 21st to 31st July 2020 
# c_gls_FCOVER300-RT0_202107310000_GLOBE_OLCI_V1.1.2 # from 21st to 31st July 2021
# c_gls_FCOVER300-RT0_202207310000_GLOBE_OLCI_V1.1.2 # from 21st to 31st July 2022

# I upload them into R through raster() function 
july20 <- raster ("c_gls_FCOVER300-RT6_202007310000_GLOBE_OLCI_V1.1.1.nc")
july21 <- raster ("c_gls_FCOVER300-RT0_202107310000_GLOBE_OLCI_V1.1.2.nc")
july22 <- raster ("c_gls_FCOVER300-RT0_202207310000_GLOBE_OLCI_V1.1.2.nc")

# I plot them to see the images 
plot(july20)
dev.off()
plot(july21)
dev.off()
plot(july22)
dev.off()
# they all represent the fcover at the global scale

# through the crop() function I crop the extension of British Columbia region in Canada, since it was one of the most affected areas 
# British Columbia coordinates 53,7267° N, 127,6476° W
# longitude from 120 to 130 
# latitude from 51 to 55

extBC <- c(125, 129, 51, 55) 
fcover_bc2020 <- crop(july20, extBC)
plot(fcover_bc2020)

extBC <- c(125, 129, 51, 55)
fcover_bc2021 <- crop(july21, extBC)
plot(fcover_bc2021)

extBC <- c(125, 129, 51, 55)
fcover_bc2022 <- crop(july22, extBC)
plot(fcover_bc2022)

# plot the three maps together through the par() function
par(mfrow = c(1, 3)) # 1 row, 3 columns
plot(fcover_bc2020, main = ("FCOVER in July 2020"))
plot(fcover_bc2021, main = ("FCOVER in July 2021"))
plot(fcover_bc2022, main = ("FCOVER in July 2022"))
dev.off()
