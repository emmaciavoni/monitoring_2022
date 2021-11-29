













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
plot(EN_stack$EN_0001, col=cl)

# difference
ENdif <-EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(ENdif, col=cldif)

# the highest change in the sets are in red 
# the blue part mantain the same amount of NO2 

# automated processing Source Function 
source("R_code_automatic_script.txt")
