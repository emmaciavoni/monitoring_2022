# This is my first code in github 
# Here are the input data
# Costanza data on streams 
water <- c(100, 200, 300, 400, 500)
water

# Marta data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes


# plot the diversity of fishes (y) versus the amount of water (x)
plot(water, fishes) 

# The data we developed can e stored in a table
# a table in R is called data frame

streams <- data.frame(water, fishes)

# from now on, we are going to import and/or export data
setwd("C:/Users/Emma/Desktop/lab/")

# Let's export our table 
write.table(streams, file="my_first_table.txt")

# Some colleagues did send us a table How to import it in R?
read.table("my_first_table.txt")
# let's assign it to an object inside R 
emmatable <- read.table("my_first_table.txt")
# the first statistics for lazy beautiful people
summary(emmatable) 

# Marta does not like water 
# Marta only wants to get info on fishes 
summary(emmatable$fishes)

# histograms
hist(emmatable$fishes)
hist(emmatable$water)
