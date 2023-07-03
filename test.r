# test
# setting the wd and recall the libraries
setwd("C:/Users/Emma/Desktop/exam/")
library(raster) # predictors
library(rgdal) # species
library(ggplot2) 

file <- system.file("fire_archive_M-C61_358736.shp", package="rgdal")
file

install.packages("sf")
# sf package to work with vector data in R
# I use it to import shapfile data in R
# let's import our data
# I use the "st_read()" function 
fire_archive <- st_read("fire_archive_M-C61_358736.shp")

# it doesn't seem to work so I try with rgdal and ggplot2 libraries
# and with the readOGR function

shp = readOGR(dsn = ".", layer = "fire_archive_M-C61_358736")

# doesn't work


#############################

# I have to analyze the vegetation density and extent so do a pre-fire mapping

# trying to import csv files
# csv 
my_csv_file <-"fire_mapping.csv"
my_df2 <- read.csv(file = my_csv_file, header = TRUE, sep = ";" stringsAsFactors = FALSE)
head(my_df2)

# error

# download data from Copernicus 

############ fraction of vegetation cover analysis Attica wildfires (Greece) ############
# FCOVER = fraction of ground covered by green vegetation. Practically, it quantifies the spatial extent of the vegetation.
# using copernicus data: FCOVER 300m V1 - Sentinel-3/OLCI, PROBA-V

# checking how the fcover changed from 2017 to 2019, so before the fires and after the fires

# changed area, couldn't find data before 2020 for Attica zone
# downloaded FCOVER in the year 2022 (01st - 11th June)
# imported into R
# pray for me

june2022 <- raster ("c_gls_FCOVER300-RT1_202206100000_GLOBE_OLCI_V1.1.2.nc") 

# let's plot it
plot(june2022) 
dev.off()

# it's working! :)
# crop the extension of Canada through the "crop()" function

 

###### day 3 #######

# download FCOVER June 2023 (01st - 11th June) 

# ho scaricato questi due file da copernicus 
# c_gls_FCOVER300-RT1_202206100000_GLOBE_OLCI_V1.1.2.nc june 2022
# c_gls_FCOVER300-RT0_202306100000_GLOBE_OLCI_V1.1.2.nc june 2023

june2023 <- raster ("c_gls_FCOVER300-RT0_202306100000_GLOBE_OLCI_V1.1.2.nc")

# I use the crop () function to crop the extension of Canada because I want to analyze the region of British Columbia since it was one of the most affected areas
# longitude from 120 to 130
# latitude from 51 to 55

extBC <- c(125, 129, 51, 55) 
fcover_bc2022 <- crop(june2022, extBC)
plot(fcover_bc2022)

extBC <- c(125, 129, 51, 55)
fcover_bc2023 <- crop(june2023, extBC)
plot(fcover_bc2023)


# I want to plot the two maps  together 
# I use the par() function 

par(mfrow = c(1,2)) # 1 row, 2 columns
plot(fcover_bc2022, main = ("FCOVER in june 2022"))
plot(fcover_bc2023, main = ("FCOVER in june 2023"))
dev.off()

# export in PNG format in the output folder
png(file="outputs/FCOVER_BC_22-23_plot.png", units="cm", width=20, height= 30, res=600) 
par(mfrow = c(2,1)) # 2 rows, 1 column
plot(fcover_bc2022, main = ("FCOVER in june 2022"))
plot(fcover_bc2023, main = ("FCOVER in june 2023"))
dev.off()
# questo passaggio non mi è riuscito
# inoltre, qui mi dava errore per il plot del 2022, per simbolo in atteso
# ho risolto l'errore: su R non avevo chiuso le virgolette su "cm"


# prima però uso il package viridis per cambiare i colori 
# the Viridis package is colorblind firendly




################# day 4 another test ########################
#### download fcover data from 2014 to 2023 ####
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

# recalling the libraries into R 
library(raster) # work with raster file
library(ncdf4) # import the copernicus file in nc
library(viridis) # for the color palette
library(ggplot2) # for graphics ggplot functions
library(patchwork) # multiframe graphics
library(gridExtra) # multiframe ggplot
library(devtools)
library(RStoolbox) # useful for remote sensing image processing. It does not work in the latest version of R (4.3.1)

# recalling the working directory

setwd("C:/Users/Emma/Desktop/exam")

# uploading the images as a list in R through list and lapply functions 

fcover14 <- raster("c_gls_FCOVER300_201406100000_GLOBE_PROBAV_V1.0.1.nc")
fcover15 <- raster("c_gls_FCOVER300_201506100000_GLOBE_PROBAV_V1.0.1.nc")
fcover16 <- raster("c_gls_FCOVER300_201606100000_GLOBE_PROBAV_V1.0.1.nc")
fcover17 <- raster("c_gls_FCOVER300_201706100000_GLOBE_PROBAV_V1.0.1.nc")
fcover18 <- raster("c_gls_FCOVER300_201806100000_GLOBE_PROBAV_V1.0.1.nc")
fcover19 <- raster("c_gls_FCOVER300_201906100000_GLOBE_PROBAV_V1.0.1.nc")
fcover20 <- raster("c_gls_FCOVER300_202006100000_GLOBE_PROBAV_V1.0.1.nc")
fcover21 <- raster("c_gls_FCOVER300-RT0_202106200000_GLOBE_OLCI_V1.1.1.nc")
fcover22 <- raster("c_gls_FCOVER300-RT0_202206200000_GLOBE_OLCI_V1.1.2.nc")
fcover23 <- raster("c_gls_FCOVER300-RT0_202306100000_GLOBE_OLCI_V1.1.2 (1).nc")

par(mfrow=c(5,2)) # 5 rows, 2 columns
plot(fcover14)
plot(fcover15)
plot(fcover16)
plot(fcover17)
plot(fcover18)
plot(fcover19)
plot(fcover20)
plot(fcover21)
plot(fcover22)
plot(fcover23)


fcoverlist <- list.files (pattern = "FCOVER300") 
fcoverlist 
# with this function I have uploaded 10 images of global fraction of ground covered by green vegetation from 2014 to 2023

# use raster function
fcover_rast <- lapply (fcoverlist, raster)
fcover_rast

fcover_stack <- stack(fcover_rast)
fcover_stack


# stack function
fcover_stack <- stack(fcover_rast)
fcover_stack

# since the western part of Canada seems to be the most affected by the 2023 fires, I crop the area to see how the situation changed throughout the years in the province of BC

## domani provo a fare lo stack solo degli ultimi tre file e vedo se funziona ##


#### provo a fare una cosa visto che non funziona la stack function ####
setwd("C:/Users/Emma/Desktop/test")

fcoverlist <- list.files (pattern = "FCOVER300")
fcoverlist

fcover_rast <- lapply (fcoverlist, raster) 
fcover_rast

fcover_stack <- stack(fcover_rast)
fcover_stack

# non funziona


# tentativo con immagini in formato .tif

fcover <- raster(“c_gls_FCOVER300-RT0_QL_202304300000_GLOBE_OLCI_V1.1.2.tif”)

fcover <- raster ("c_gls_FCOVER300-RT0_QL_202304300000_GLOBE_OLCI_V1.1.2.tif")
fcover_names <- "c_gls_FCOVER300-RT0_QL_202304300000_GLOBE_OLCI_V1.1.2.tif"
imported_raster=raster(fcover_names)



# scarico solo 5 file per provare a vedere se è un problema di download, visto che la prima volta il computer si era impallato

fcover14 <- raster("c_gls_FCOVER300_201406100000_GLOBE_PROBAV_V1.0.1.nc")
fcover15 <- raster("c_gls_FCOVER300_201506100000_GLOBE_PROBAV_V1.0.1.nc")
fcover16 <- raster("c_gls_FCOVER300_201606100000_GLOBE_PROBAV_V1.0.1.nc")
fcover17 <- raster("c_gls_FCOVER300_201705310000_GLOBE_PROBAV_V1.0.1.nc")
fcover18 <- raster("c_gls_FCOVER300_201805310000_GLOBE_PROBAV_V1.0.1.nc")

# provo a ritagliare il canada per tre file #fcover14, #fcover15, #fcover16

extcan <- c(100, 110, 50, 60)
fcover_can14 <- crop(fcover14, extcan)
plot(fcover_can14)

extcan <- c(100, 110, 50, 60)
fcover_can15 <- crop(fcover15, extcan)
plot(fcover_can15)

extcan <- c(100, 110, 50, 60)
fcover_can16 <- crop(fcover16, extcan)
plot(fcover_can16)

extcan <- c(100, 110, 50, 60)
fcover_can17 <- crop(fcover17, extcan)
plot(fcover_can17)

extcan <- c(100, 110, 50, 60)
fcover_can18 <- crop(fcover18, extcan)
plot(fcover_can18)

par(mfrow = c(2,3)) # 2 rows, 2 columns
plot(fcover_can14, main = ("FCOVER in june 2014"))
plot(fcover_can15, main = ("FCOVER in june 2015"))
plot(fcover_can16, main = ("FCOVER in june 2016"))
plot(fcover_can17, main = ("FCOVER in june 2017"))
plot(fcover_can18, main = ("FCOVER in june 2018"))
dev.off()

# salvo il plot nella cartella outputs
png(file="outputs/FCOVER_CAN_plot.png", units="cm", width=20, height= 30, res=600) 
par(mfrow = c(1,3))
plot(fcover_can14, main = ("FCOVER in june 2014"))
plot(fcover_can15, main = ("FCOVER in june 2015"))
plot(fcover_can16, main = ("FCOVER in june 2016"))
dev.off()


p1 <- ggplot(data = fcover_can14) + 
geom_raster (data = fcover_can14, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER June 2014 ")

# ggplot 2021 data, assign it to the object p2
p2 <- ggplot(data = fcover_can15) + 
geom_raster (data = fcover_can15, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER June 2015")

p3 <- ggplot(data = fcover_can16) + 
geom_raster (data = fcover_can16, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER June 2016")

p4 <- ggplot(data = fcover_can17) +
geom_raster (data = fcover_can17, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m)) + 
scale_fill_viridis() + ggtitle ("FCOVER June 2017")

p5 <- ggplot(data = fcover_can18) +
geom_raster (data = fcover_can18, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m)) + 
scale_fill_viridis() + ggtitle ("FCOVER June 2018")

# plot the 2 maps together into 2 rows and 1 column using Patchwork
p1/p2/p3/p4/p5

# export this image in PNG format in the output folder
png(file="outputs/FCOVER_CAN_14-25-16.png", units="cm", width=25, height=30, res=600)
p1 / p2 / p3
dev.off()



## ho dovuto installare la versione più recente di R (4.3.1): con questa la funzione stack() non mi dà più errore, ma non è disponibile il pacchetto RStoolbox
# senza RStoolbox non si vedevano i ggplot con dati raster
# ho cercato come installarlo in maniera alternativa (non da CRAN, visto che è stato tolto)
# ho trovato la soluzione qui: https://www.rdocumentation.org/packages/RStoolbox/versions/0.3.0 # rdocumentation
install.packages(devtools)
library(devtools)
install_github("bleutner/RStoolbox")

# installato senza errori e si vedono i plot!
