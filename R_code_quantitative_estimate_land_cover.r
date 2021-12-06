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

freq(l1992c$map)

total <- 342726
propagri <- 35369/total
propforest <- 305923/total

cover <- c("Forest", "Agriculture")
prop2006 <- c( 0.8926168, 0.1031991)
proportion2006 <- data.frame(cover, prop2006)

proportion <- data.frame(cover, prop1992, prop2006)

ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")
