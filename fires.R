#Setting your working directory & loading data
setwd("D:/data/fires") #Copy and paste your own pathfile
fires <- read.csv("fires.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE) #Give an easy name

#Installing libraries and geocoding
library(ggplot2)
library(ggmap)
lonlat <- geocode(fires$town_name) #Generate lon/lat values for each town
fires_lonlat <- merge(fires, lonlat) #Join lonlat with fires dataset

#Looking for outliers
library(maps) 
map("world", col="#f2f2f2", fill=TRUE, bg="white", lwd=0.05) #Plot a worldmap
points(fires_lonlat$lon, fires_lonlat$lat, pch=19, col="red", cex=0.5) #Plot dots