# R code for species distribution modelling, namely the ditribution of individuals
install.packages("sdm")
library(sdm)
# sdm = species distribution modelling 
# An extensible framework for developing species distribution models using individual and community-based approaches
# generate ensembles of models, evaluate the models, and predict species potential distributions in space and time

# recalling the libraries 
library(raster)
library(rgdal)

# system.file function shows all the files in a certain package 

file <- system.file("external/species.shp", package="sdm")

species <- shapefile(file)

plot(species, pch=19, col="red")
