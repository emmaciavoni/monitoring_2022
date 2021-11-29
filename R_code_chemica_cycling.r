













# day 2
# function list.files 
# lets' build the list importing all the data together 
# we have to recall library(raster)
library(raster) 

# set the working directory
setwd("C:/Users/Emma/Desktop/lab/en")

rlist <- list.files(pattern="EN")
rlist

# lapply function 
list_rast <- lapply(rlist, raster)
list_rast

# we are going to stack the data 
EN_stack <- stack(list_rast)
EN_stack

cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(EN_stack, col=cl)

# let's plot only the first image of the stack
