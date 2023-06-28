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

# I downloaded these three files from Copernicus: https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home in my directory
# c_gls_FCOVER300-RT6_202007310000_GLOBE_OLCI_V1.1.1 # from 21st to 31st July 2020 
# c_gls_FCOVER300-RT0_202107310000_GLOBE_OLCI_V1.1.2 # from 21st to 31st July 2021
# c_gls_FCOVER300-RT0_202207310000_GLOBE_OLCI_V1.1.2 # from 21st to 31st July 2022

# First, I analyze the years 2020 and 2021
# I upload them into R through raster() function 
july20 <- raster ("c_gls_FCOVER300-RT6_202007310000_GLOBE_OLCI_V1.1.1.nc")
july21 <- raster ("c_gls_FCOVER300-RT0_202107310000_GLOBE_OLCI_V1.1.2.nc")

# I plot them to see the images 
plot(july20)
dev.off()
plot(july21)
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

# plot the two maps together through the par() function
par(mfrow = c(2, 2)) # 2 rows, 2 columns
plot(fcover_bc2020, main = ("FCOVER in July 2020"))
plot(fcover_bc2021, main = ("FCOVER in July 2021"))
dev.off()

# export the image as PNG file in the outputs folder 
png(file="outputs/FCOVER_BC_plot.png", units="cm", width=20, height= 30, res=600) 
par(mfrow = c(2,2)) # 2 rows, 2 columns
plot(fcover_bc2020, main = ("FCOVER in July 2020"))
plot(fcover_bc2021, main = ("FCOVER in July 2021"))
dev.off()

# plot the two maps together with ggplot function using the viridis color scale that ranges from yellow to green and blue

p1 <- ggplot(data = fcover_bc2020) + 
geom_raster (data = fcover_bc2020, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER in July 2020 ")

p2 <- ggplot(data = fcover_bc2021) + 
geom_raster (data = fcover_bc2021, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m)) +
scale_fill_viridis() + ggtitle ("FCOVER in July 2021")

p1/p2
dev.off()

# export the image as PNG file in the outputs folder
png(file="outputs/FCOVER_BC_20-21plot.png", units="cm", width=20, height= 30, res=600)
p1/p2
dev.off()

# calculate the difference of fcover in 2020-2021
fcover_diff <- fcover_bc2020 - fcover_bc2021
fcover_diff
############ se faccio il plot di questa esce fuori la mappa del 2021. ho controllato se fossero compatibili e dovrebbero esserlo. non capisco ###############

# using colorramppalette to customize the colors
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff, col = coldiff)
dev.off()

# export the images
png(file="outputs/FCOVER_DIFF_20-21_plot.png", units="cm", width=20, height= 30, res=600)
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff, col = coldiff)
dev.off()

# to costumize the color palette see this website https://gka.github.io/palettes/#/8|s|214b1e,4f7c10,e8dec1|ffffe0,ff005e,93003a|1|1

# now I want to see how the situation was in 2022 (post-fire)
# I upload the file through the lapply function
# first let's create a list of the files with the common pattern
fcover_list <- list.files(pattern = "FCOVER300") 
fcover_list # to check it

# let's apply raster function to all the files in the list 
fcover_raster <- lapply(fcover_list, raster) 
fcover_raster

# let's make a stack with the raster
# A RasterStack is a collection of RasterLayer objects with the same spatial extent and resolution
fcover_stack <- stack(fcover_raster)
fcover_stack 

# recalling the coordinates of British Columbia to crop the stack
extbc <- c(125, 129, 51, 55)
fcover_bc <- crop(fcover_stack, extbc)
fcover_bc 

# rename the layers 
names(fcover_bc) <- c("JUL_2021", "JUL_2022", "JUL_2020")

# plot the stack with custom palette
green_palette <- colorRampPalette(c("lightgreen", "green", "darkgreen"))(100)
plot(fcover_bc, col = green_palette, main = c("JUL 2021", "JUL 2022", "JUL 2020"))
dev.off()

# in 2022 the wildfire season was not as destructive as the previous year, some vegetation recovered from 2021

# export the plots in the outputs folder
png(file="outputs/FCOVER_20-21-22_plot.png", units="cm", width=20, height= 30, res=600)
green_palette <- colorRampPalette(c("lightgreen", "green", "darkgreen"))(100)
plot(fcover_bc, col = green_palette, main = c("JUL 2021", "JUL 2022", "JUL 2020"))
dev.off()

# plotting the frequency distribution of FCOVER values in 2020 and 2021 using histograms
par(mfrow=c(1,2))
hist(fcover_bc$JUL_2020,            
  xlab = "FCOVER values in 2020", 
  ylab = "frequency", 
  xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_bc$JUL_2021, 
  xlab = "FCOVER values in 2021", 
  ylab = "frequency", 
  xlim = c(0, 1), ylim = c(0, 20000))
dev.off()

# export as PNG in the outputs folder
png(file="outputs/FCOVER_frequencies_2020-2021.png", units="cm", width=40, height=40, res=600)
par(mfrow=c(1,2))
hist(fcover_bc$JUL_2020, xlab = "FCOVER values in 2020", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_bc$JUL_2021, xlab = "FCOVER values in 2021", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
dev.off()

# 2020 vs 2022
par(mfrow=c(1,2))
hist(fcover_bc$JUL_2020,
     xlab = "FCOVER values in 2020",
     ylab = "frequency",
     xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_bc$JUL_2022,
     xlab = "FCOVER values in 2022",
     ylab = "frequency",
     xlim = c(0, 1), ylim = c(0, 20000))
dev.off()

# export as PNG in outputs folder
png(file="outputs/FCOVER_frequencies_2020-2022.png", units="cm", width=40, height=40, res=600)
par(mfrow=c(1,2))
hist(fcover_bc$JUL_2020, xlab = "FCOVER values in 2020", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_bc$JUL_2022, xlab = "FCOVER values in 2022", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
dev.off()


# make a scatterplot 
plot(fcover_bc$JUL_2020, fcover_bc$JUL_2021, 
    pch =20, col = "blue", 
    xlab = "FCOVER in 2020", ylab = "FCOVER in 2021")
dev.off()

#export as PNG
png(file="outputs/FCOVER_scatterplot_2020-2021.png", units="cm", width=40, height=40, res=600)
plot(fcover_or$AUG_2020, fcover_or$AUG_2021, pch =20, col = "blue", xlab = "FCOVER in 2020", ylab = "FCOVER in 2021")
dev.off()

# we can have the frequency and regression lines all together automatically with the function pairs()
pairs(fcover_bc)





















