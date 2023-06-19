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


----------- #day2 ------------------
# let's try again with baby steps
# I have to analyze the vegetation density and extent so do a pre-fire mapping

# provo a importare dei dati in csv delle date degli incendi
# csv 
my_csv_file <-"fire_mapping.csv"
my_df2 <- read.csv(file = my_csv_file, header = TRUE, sep = ";" stringsAsFactors = FALSE)
head(my_df2)

# ovviamente non funziona 
