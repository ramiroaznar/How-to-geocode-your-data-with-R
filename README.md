# How-to-geocode-your-data-with-R

In my first post I would like to introduce you one of the easiest ways to geocode your data. Geocoding is one of the most essential functionalities within the spatial analysis. It allow us to transform a description of a location, generally an address, postcode or similar, into a pair of coordinates -longitude and latitude, X and Y or another-. Then we can map our data.

There are an increasing wide diversity of alternatives to geocode your datasets. From websites to programming applications. Here I will show you how to do it using R. First, it is necessary to download and install R (I used RStudio a more friendly desktop IDE). Then it is necessary to set up your working environment and to load your data. For this tutorial I have already scraped and clean a dataset of the 100 Spanish towns with more fires from 2001 to 2013 from the España en Llamas website. You can download it here (also I have created a GitHub repository with all the material covered in this post).

#Setting your working directory & loading data

setwd("D:/data/fires") #Copy and paste your own pathfile

fires <- read.csv("fires.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE) #Load and name it

Now it is turn of the funny stuff. In order to geocode our data, we are going to use the geocode() function from the ggmap package which uses the Google Maps API. So, first install the libraries needed and then call the function as this:

#Installing libraries and geocoding

library(ggplot2)

library(ggmap)

lonlat <- geocode(fires$town_name) #Generate lon/lat values for each town

fires_lonlat <- merge(fires, lonlat) #Join lonlat with fires dataset

write.csv(fires_lonlat, "fires_lonlat.csv") #Save the new dataset

We can stop here. But it is more than advisable to explore your data in order to look for outliers. For this task, we plot our towns as dots over a simple worldmap. Any point outside the Spanish borders will be considered as a outlier. And we will need to correct our data again.

#Looking for outliers

library(maps) 

map("world", col="#f2f2f2", fill=TRUE, bg="white", lwd=0.05) #Plot a worldmap

points(fires_lonlat$lon, fires_lonlat$lat, pch=19, col="red", cex=0.5) #Plot dots

This is the result.

worldmap.jpeg

As you can observe there are plenty of outliers. In the next post I will explain how to select these rebel dots and correct them.
