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
# c_gls_FCOVER300-RT6_202007310000_GLOBE_OLCI_V1.1.1 July 2020
# c_gls_FCOVER300-RT0_202107310000_GLOBE_OLCI_V1.1.2 July 2021
# c_gls_FCOVER300-RT0_202207310000_GLOBE_OLCI_V1.1.2 July 2022

# I upload them into R through raster() function 
