#Setting your working directory & loading data
setwd("D:/data/") #Copy and paste your own pathfile
fires <- read.csv("fires.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE) #Give an easy name

#Installing libraries and geocoding
library(ggplot2)
library(ggmap)
lonlat <- geocode(fires$town_name) #Generate lon/lat values for each town

#Merging both datasets
lonlat$id <- seq.int(nrow(lonlat))
write.csv(lonlat, "lonlat.csv")
fires$id <- seq.int(nrow(fires))
write.csv(fires, "fires.csv")
fires_lonlat <- merge(fires, lonlat, by.x = "id") #Join lonlat with fires dataset
write.csv(fires_lonlat, "fires_lonlat.csv")

#Looking for outliers
library(maps) 
map("world", col="#f2f2f2", fill=TRUE, bg="white", lwd=0.05) #Plot a worldmap
points(fires_lonlat$lon, fires_lonlat$lat, pch=19, col="red", cex=0.5) #Plot dots