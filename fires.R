#Setting your working directory & loading data
setwd("D:/data/") #Set wd with your own pathfile
fires <- read.csv("fires.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE) #Give an easy name

#Installing libraries and geocoding
library(ggplot2)
library(ggmap)
lonlat <- geocode(fires$town_name) #Generate lon/lat values for each town

#Merging and saving both datasets
lonlat$id <- seq.int(nrow(lonlat)) #Add an id column
write.csv(lonlat, "lonlat.csv") #Save dataset
fires$id <- seq.int(nrow(fires)) #Add an id column
write.csv(fires, "fires.csv") #Save dataset
fires_lonlat <- merge(fires, lonlat, by.x = "id") #Merge datasets with id column
write.csv(fires_lonlat, "fires_lonlat.csv") #Save dataset

#Looking for outliers
library(maps) 
map("world", col="#1ABC9C", fill=TRUE, bg="white", lwd=0.05) #Plot a worldmap
points(fires_lonlat$lon, fires_lonlat$lat, pch=19, col="#CA99CE", cex=0.5) #Plot dots