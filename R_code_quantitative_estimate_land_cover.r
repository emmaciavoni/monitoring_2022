# R_code_quantitative_estimate_land_cover.r

# we are going to use the raster package
library(raster) 
library(RStoolbox)
# and setting the working directory
setwd("C:/Users/Emma/Desktop/lab/")

# let's import the images using lapply function
# first, list the files available
rlist <- list.files(pattern="defor")
rlist

# second, let's use lapply: apply a function to a list
list_rast <- lapply(rlist, brick)
list_rast

plot(list_rast[[1]])

# let's plot RGB function
# NIR 1, red 2, green 3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="Lin")

# let's call the function in a simpler way
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")

# let's do it with the other file, too
l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# unsupervised classification procedure of the images
# use unsuperClass function
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c

# plot of the map
plot(l1992c$map)
# values in the map are only 1 and 2 
# value 1= forests
# value 2= agricultural areas
# percentage of forest and agricultural areas? 
# let's count the amount of pixels through "freq" function

freq(l1992c$map)
# for the first value (forest) 305923
# for the second value (agricultural areas) 35369

total <- 341292
propagri <- 35369/total
propforest <- 305923/total 

# agriculture and water = 0.1036327 ~ 0.10
# forests = 0.8963673 ~ 0,90 



# build a dataframe
cover <- c("Forest", "Agriculture") 
prop1992 <- c(0.8963673, 0.1036327)
proportion1992 <- data.frame(cover, prop1992)

library(ggplot2)

ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")


# day 2
# recap of day 1
# set the library and working directory
# let's apply the functions again 


rlist <- list.files(pattern="defor")
rlist

list_rast <- lapply(rlist, brick)
list_rast

# plot the images 
# use of unsuperClass function 


# classification of 2006
# unsuperClass function 
l2006c <- unsuperClass(l2006, nClasses=2) 
l2006c

plot(l2006c$map)
# forest value 1
# agricultural areas value 2

freq(l2006c$map)

# proportions

total <- 342726
propforest2006 <- 178620/total
propagri2006 <- 164106/total

# propforest 0.5211743
# propagri 0.4788257

cover <- c("Forest", "Agriculture")
prop1992 <- c(propforest, propagri)
prop2006 <- c(propforest2006, propagri2006)

proportion2006 <- data.frame(cover, prop2006)

proportion <- data.frame(cover, prop1992, prop2006)

ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# plotting altogether 

p1 <- ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")


library(gridExtra) 
# miscellaneous functions for "grid" graphics
# this package can be used for multiframe plot, instead of the "par" function

# grid.arrange function puts several graphs in the same multiframe
grid.arrange(p1, p2, nrow=1)

# we expect that the agriculture data will rise up, while the forest data will go down

# installing another package
install.packages("patchwork")
library(patchwork)
# it makes it simple to combine separate ggplots into the same graphic
# it tries to solve the same problem as gridExtra::grid.arrange()
p1+p2 # use this to put them in rows
p1/p2 # use this to put them in columns 

# patchwork works even with raster program
# instead of using plotRGB, we are using ggRGB
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="Lin")

ggRGB(l1992, r=1, g=2, b=3)
ggRGB(l1992, r=1, g=2, b=3, stretch="Lin")
ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
ggRGB(l1992, r=1, g=2, b=3, stretch="log")

# we assign the functions to an object and plot them with patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="Lin")
gp2 <- ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch="log")

gp1+gp2+gp3+gp4

gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)

gp1+gp5
