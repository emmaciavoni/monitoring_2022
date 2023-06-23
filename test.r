# prova per capire delle cose
# dovrei inserire la working directory e poi inserire le library che mi servono
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

# non funziona niente, ciao
# end of fucking day 1


############# day2 ################
# let's try again with baby steps
# I have to analyze the vegetation density and extent so do a pre-fire mapping

# provo a importare dei dati in csv delle date degli incendi
# csv 
my_csv_file <-"fire_mapping.csv"
my_df2 <- read.csv(file = my_csv_file, header = TRUE, sep = ";" stringsAsFactors = FALSE)
head(my_df2)

# ovviamente non funziona 

# provo a prendere i dati da coprenicus che forse è l'unico sito affidabile che non ti dà i dati in formati strani
# ho creato un nuovo folder quindi metto la nuova wd (sperando che funzioni,lol)


############ analisi della fraction of vegetation cover ############
# FCOVER = fraction of ground covered by green vegetation. Practically, it quantifies the spatial extent of the vegetation.
# using copernicus data: FCOVER 300m V1 - Sentinel-3/OLCI, PROBA-V

# cheching how the fcover changed from 2017 to 2019, so before the fires and after the fires

# ho cambiato zona perché su Copernicus non c'erano dati prima del 2020
# quindi sto analizzando gli incendi del Canada di quest'anno 
# prima però ho scaricato i dati della FCOVER nel giugno 2022 (01 - 11 giugno)
# provo ad importarlo su R 
# pray for me 

june2022 <- raster ("c_gls_FCOVER300-RT1_202206100000_GLOBE_OLCI_V1.1.2.nc") 

# vediamo com'è l'immagine importata su R facendo un plot
plot(june2022) 
dev.off()

# ok, ha funzionato e vediamo il plot a livello globale
# adesso mi serve vedere la situazione in Canada e devo usare la funzione "crop()"
# ora il quesito è: mi conviene croppare tutto il Canada o solo la regione che mi interessa?
# a questo quesito risponderò domani, che oggi è stata una giornata faticosa 

###### day 3 #######

# scaricare FCOVER di giugno 2023 (01 - 11 giugno) 

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

# hanno funzionato ma non so bene come interpetarle 
# sicuramente nel 2022 c'era più verde, nel 2023 mancano dei pezzi. Detta proprio in gergo 

# I want to plot the two maps  together 
# I use the par() function 

par(mfrow = c(1,2)) # 2 rows, 1 column
plot(fcover_bc2022, main = ("FCOVER in june 2022"))
plot(fcover_bc2023, main = ("FCOVER in june 2023"))
dev.off()

# si vedono ma male, è un formato strano
# devo verificare se ho sbagliato qualcosa nelle coordinate 

# provo comunque a caricare l'immagine, giusto per impostare la funzione
# export in PNG format in the output folder
png(file="outputs/FCOVER_BC_22-23_plot.png", units="cm, width=20, height= 30, res=600) 
par(mfrow = c(2,1)) # 2 rows, 1 column
plot(fcover_bc2022, main = ("FCOVER in june 2022"))
plot(fcover_bc2023, main = ("FCOVER in june 2023"))
dev.off()
# questo passaggio non mi è riuscito. ho salvato l'immagine dei plot "manualmente", ma dovrei farlo con la funzione png()
# inoltre, qui mi dava errore per il plot del 2022, per simbolo in atteso





# prima però uso il package viridis per cambiare i colori 
# the Viridis package is colorblind firendly


### oggi è stata una giornata complicata e mi sono bloccata
### devo capire cosa mi conviene fare e partire da lì 
### l'ultima idea è la seguente: prendere i dati del mese di giugno negli ultimi 9 anni (2014-2023) e valutare la fcover e l'ndvi
### domani comincio con il prendere i dati del fcover e vediamo come va





################# DATA DI OGGI 22/06/2023 ########################
#### bonjour, comincio a prendere i dati della fcover dal 2014 al 2023 ####
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

# recalling the libraries into R 
library(raster) # work with raster file
library(ncdf4) # import the copernicus file in nc
library(viridis) # for the color palette
library(RStoolbox) # useful for remote sensing image processing
library(ggplot2) # for graphics ggplot functions
library(grid.Extra) # multiframe ggplot
library(patchwork) # multiframe graphics

# recalling the working directory

setwd("C:/Users/Emma/Desktop/exam")

# uploading the images as a list on r through list and lapply functions 

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
