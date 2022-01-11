# R code for species distribution modelling, namely the ditribution of individuals
install.packages("sdm")
library(sdm)
# sdm = species distribution modelling 
# An extensible framework for developing species distribution models using individual and community-based approaches
# generate ensembles of models, evaluate the models, and predict species potential distributions in space and time

# recalling the libraries 
library(raster) # predictors
library(rgdal) # species

# system.file function shows all the files in a certain package 

# species data 
file <- system.file("external/species.shp", package="sdm")
file
species <- shapefile(file) 
species
# is the correspondant function of raster

plot(species, pch=19, col="red")
# The pch in R defines the point symbols in the functions plot() and lines()
# The pch stands for plot character. The pch contains numeric values rangers from 0 to 25 or character symbols (“+”, “.”, “;”, etc.) specifying in symbols (or shapes)

---------# day 2 
# SQL is a database query language - a language designed specifically for interacting with a database
# how many occurrences are there?
# we want to see how many "ones" there are
presences <- species[species$Occurrence == 1,]
# the comma in SQL language means "stop the query"
# there are 94 occurrences 
absences <- species[species$Occurrence == 0,]
# 106 absences 

# let's plot the data
plot(species, pch=19)
plot(presences, pch=19, col="blue")
# we want to make a single plot with presences and absence 
# how to add? we use the "points" function
points(absences, pch=19, col="red")

# plot the probability to find a species 
# let's look at the predictors
# predicotrs: look at the path
path <- system.file("external", package="sdm")
path

# list the predictors 
lst <- list.files(path, pattern="asc")
lst

# use lapply function with the raster function 

lst <- list.files(path, pattern="asc$", full.names=T)
lst

# stack
preds <- stack(lst)
preds

# plot preds 
cl <- colorRampPalette(c("blue", "orange", "red", "yellow")) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(presences, pch=19)

plot(preds$temperature, col=cl)
points(presences, pch=19)

plot(preds$vegetation, col=cl)
points(presences, pch=19)

plot(preds$precipitation, col=cl)
points(presences, pch=19)

# model 




#------- day 3
# setting the working directory
setwd("C:/Users/Emma/Desktop/lab/")
source("R_code_source_sdm.r")

preds
# these are the predictors: elevation, temperature, precipitation, vegetation

# sdmData function
# creates a sdmdata objects that holds species (single or multiple) and explanatory variates
# model
# let's explain tot he model what are the training and predictors
datasdm <- sdmData(train=species, predictors=preds)
datasdm

# this function includes the formula, the data and the methods
m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, methods="glm") 
m1
