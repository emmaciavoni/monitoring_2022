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

# create a list 
fcover_list <- list.files(pattern = "FCOVER300") 

# apply raster function to all the files in the list 
fcover_raster <- lapply(fcover_list, raster) 

# make a stack with the raster
# A RasterStack is a collection of RasterLayer objects with the same spatial extent and resolution
fcover_stack <- stack(fcover_raster)

# recalling the coordinates of British Columbia to crop the stack
extbc <- c(125, 129, 51, 55)
fcover_bc <- crop(fcover_stack, extbc)
fcover_bc 

# rename the layers 
names(fcover_bc) <- c("JUL_2021", "JUL_2022", "JUL_2020")


# plot the stack with custom palette
cl <- colorRampPalette (c("brown", "yellow", "#009900"))(100)
plot(fcover_bc, col = cl, main = c("JUL 2021", "JUL 2022", "JUL 2020"))


cl <- colorRampPalette (c("#006a2e", "#d4ec62", "#e5ebbf"))(100)




# plot the three maps together through the par() function
par(mfrow = c(1, 3)) # 1 row, 3 columns
plot(fcover_bc2020, main = ("FCOVER in July 2020"))
plot(fcover_bc2021, main = ("FCOVER in July 2021"))
plot(fcover_bc2022, main = ("FCOVER in July 2022"))
dev.off()

# export the image as PNG file in the outputs folder 
png(file="outputs/FCOVER_BC_plot.png", units="cm", width=20, height= 30, res=600) 
par(mfrow = c(1,3)) # 1 row, 3 columns
plot(fcover_bc2020, main = ("FCOVER in July 2020"))
plot(fcover_bc2021, main = ("FCOVER in July 2021"))
plot(fcover_bc2022, main = ("FCOVER in July 2022"))
dev.off()

# the difference in fcover between 2020 and 2021 is quite evident
# plot the two maps together with ggplot function using the viridis color scale that ranges from yellow to green and blue

p1 <- ggplot(data = fcover_bc2020) + 
geom_raster (data = fcover_bc2020, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER July 2020 ")

p2 <- ggplot(data = fcover_bc2021) + 
geom_raster (data = fcover_bc2021, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m)) +
scale_fill_viridis() + ggtitle ("FCOVER July 2021")

p1/p2
dev.off()

# export the image as PNG file in the outputs folder
png(file="outputs/FCOVER_BC_20-21plot.png", units="cm", width=20, height= 30, res=600)
p1/p2
dev.off()

# calculate the difference of fcover in 2020-2021
fcover_diff <- fcover_bc2020 - fcover_bc2021
fcover_diff
##### se faccio il plot di questa esce fuori la mappa del 2021. ho controllato se fossero compatibili e dovrebbero esserlo. non capisco #####

fcover_diff2 <- fcover_bc2022 - fcover_bc2021
fcover_diff2
##### qui invece un po' di differenza si vede, ma non so come interpetarlo #####

# using colorramppalette to customize the colors
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff, col = coldiff)

cols <- rev(c("#006a2e", "#d4ec62", "#e5ebbf"))
color_diff <- colorRampPalette(cols)(100)

# difference between 2022 - 2021
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff2, col = color_diff)

# export the images
png(file="outputs/FCOVER_DIFF_21-20_plot.png", units="cm", width=20, height= 30, res=600)
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff, col = coldiff)
dev.off()

png(file="outputs/FCOVER_DIFF_22-21_plot.png", units="cm", width=20, height= 30, res=600)
coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff2, col = coldiff)
dev.off()

fcover_diff3 <- fcover_bc2021 - fcover_bc2022
fcover_diff

coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff3, col = coldiff)

fcover_diff4 <- fcover_bc2021 - fcover_bc2020
fcover_diff4

coldiff <- colorRampPalette(c("green", "yellow", "red"))(100)
plot(fcover_diff4, col = coldiff)

