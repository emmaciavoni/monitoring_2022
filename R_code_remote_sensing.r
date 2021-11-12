# R code for ecosystem monitoring for remote sensing
# First of all we need to insall additional packagings

# https://cran.r-project.org/web/packages/raster/raster.pdf

install.packages("raster")

library(raster)

setwd("C:/Users/Emma/Desktop/lab/")

# we are going to import satellite data 
# to do that we use the "brick" function, which imports the layers all together
# we assign an object to the function
l2011 <- brick("p224r63_2011.grd") 
# objects cannot be numbers (I made a mistake, calling the object "12011")
# l2011 is our satellite image
# landsat has seven layers


l2011

plot(l2011)
# B1 is the reflectance in the blue band 
# B2 is the reftlectance in the green band
# B3 is the reflectance in the red band

cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl)


plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") 

# B1 is the reflectance in the blue band 
# B2 is the reftlectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the NIR band
# NIR means near infra-red

#sre means spectrum reflectance
# let's plot the green band
# plot is the function 
# l2011$B2_sre is the argument
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011$B2_sre, col=cl)

# let's change the colorRampPalette with dark green, green and light green e.g. clg

clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col=clg)

# let's do the same with the blue band using dark blue, blue and light blue
# we have to plot B1, instead of B2
# B1_sre

clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)


# plot both images in just one multiframe graph
# one row and two columns
# number of rows on the left 
# number of columns on the right

par(mfrow=c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot both images in two rows and just one column

par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)


# let's plot only the blue band
plot(l2011$B1_sre)
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)


# excercise: plot the first four bands
# we have to make the colorRampPalette for the red band and nir

clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
plot(l2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(l2011$B4_sre, col=clnir)

par(mfrow=c(2,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
plot(l2011$B4_sre, col=clnir)

# close the plot with dev.off
dev.off()

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") # natural colors
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") # false colors
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") # false colors
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") # false colors

par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin") # natural colors
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") # false colors
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin") # false colors
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin") # false colors


# final day on this tropical forest reserve
 
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") # false colors

# histogram stretching will show the differences
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# importing past data through the "brick" function like we did for the other file
l1988 <- brick("p224r63_1988.grd")

l1988

# we can plot the two images through "par" function
# two rows and one column
par(mfrow=c(2,1))
plotRGB(l1988, r= 4, g= 3, b=2, stretch="Lin") 
# the forest in 1988 was there and they started to build small agricultural areas
plotRGB(l2011, r= 4, g= 3, b=2, stretch="Lin") 
# we can see, in 2011, a complete opening of the forest dedicated to agriculture

# Put the NIR in the blue channel 
par(mfrow=c(2,1))
plotRGB(l1988, r= 2, g= 3, b=4, stretch="Lin")
plotRGB(l2011, r= 2, g= 3, b=4, stretch="Lin") 
