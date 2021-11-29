# R code for chemical cycling study
# time series of NO2 changed during the lockdown

# setting the workind directory
setwd("C:/Users/Emma/Desktop/lab/en")

library(raster)
en01 <- raster("EN_0001.png")
# what is the range of the data?
en01

# colors that we can use
# https://www.google.com/search?q=R+colours+names&tbm=isch&ved=2ahUKEwiF-77Z1bX0AhULtKQKHQ3WDWYQ2-cCegQIABAA&oq=R+colours+names&gs_lcp=CgNpbWcQAzIECAAQEzoHCCMQ7wMQJzoICAAQCBAeEBNQiQhYnwxgwg1oAHAAeACAAUqIAZYDkgEBNpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=vKKgYYWtOovokgWNrLewBg&bih=526&biw=1056#imgrc=OtMzJfyT_OwIiM


# plot the NO2 values of January 2020 by the cl palette
cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(en01, col=cl) 

# plot the NO2 values of March 2020 
en13 <- raster("EN_0013.png")
en13
cl <- colorRampPalette(c("red", "orange", "yellow")) (100) 
plot(en13, col=cl)

# comparing the images with the par function" 
par(mfrow=c(2,1))
plot(en01, col=cl)
plot(en13, col=cl)

# importing all the images
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

# plot all the data together 
par(mfrow=c(4,4))
plot(en01, col=cl)
plot(en02, col=cl)
plot(en03, col=cl)
plot(en04, col=cl)
plot(en05, col=cl)
plot(en06, col=cl)
plot(en07, col=cl)
plot(en08, col=cl)
plot(en09, col=cl)
plot(en10, col=cl)
plot(en11, col=cl)
plot(en12, col=cl)
plot(en13, col=cl)

# stack function 

en <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)
plot(en, col=cl)

# plot only the first image from the stack 
en
plot(en$EN_0001, col=cl)

# plot RGB 
plotRGB(en, r=1, g=7, b=13, stretch="Lin") 



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
