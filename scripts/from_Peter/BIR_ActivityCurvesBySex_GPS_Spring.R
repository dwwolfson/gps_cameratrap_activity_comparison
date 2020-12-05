
##Set working directory
setwd("F:/Documents/ASU/ActivityPatterns/R/ForDavid/SexComps")

#Load necessary packages
library(lubridate)
library(tidyverse)
library(overlap)
library(circular)
library(CircStats)
library(adehabitatLT)
library(sp)
library(rgdal)
library(maptools)

##########################################################################################################################################
data <- read.csv("BIR_SpringGPS_Females.csv") 
head(data)
dadata <- as.character(data$Fix_DateTime)
dadata <- as.POSIXct(strptime(as.character(data$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj <- as.ltraj(xy = data[,c("X","Y")], date = dadata, id = data$Indiv_ID, typeII= TRUE, burst = data$Indiv_ID)
head(data.traj[[1]])

#Calculating rates
data.ld <- ld(data.traj) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
head(data.ld)

data.tibble <- as.tibble(data.ld) #converts back to tibble format for use of piping

data.tibble %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub #selects columns of interest
  
head(data.sub)

gen_rand_times.mod <- function(N, st, et) {
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand<-gen_rand_times.mod(N=data.sub$meterph[1], st=data.sub$date[1], et = data.sub$date[2])
rand

results <- list() #sets up list for storing results

for(i in 1:nrow(data.sub)){
  if(data.sub$dtmin[i]>19 & data.sub$dtmin[i]<41 & is.na(data.sub$dtmin[i])==FALSE){
  results[[i]]<-gen_rand_times.mod(N=data.sub$meterph[i], st=data.sub$date[i], et = data.sub$date[i+1])
  }
}

randTimesdf<-plyr::ldply(results, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf)

randTimesdf<-as.tibble(randTimesdf) #makes dataframe into a tibble for reformatting

randTimesdf %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf #extracts just the time of each observation from the datetime

randTimesdf %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf #multiplies to get radians to make data circular

##########################################################################################################################################
#Now we want to look at activity patters based on the collar data and compare males and females

data2 <- read.csv("BIR_SpringGPS_Males.csv") 
head(data2)
dadata2 <- as.character(data2$Fix_DateTime)
dadata2 <- as.POSIXct(strptime(as.character(data2$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data2.traj <- as.ltraj(xy = data2[,c("X","Y")], date = dadata2, id = data2$Indiv_ID, typeII= TRUE, burst = data2$Indiv_ID)
head(data2.traj[[1]])

#Calculating rates
data2.ld <- ld(data2.traj) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
head(data2.ld)

data2.tibble <- as.tibble(data2.ld) #converts back to tibble format for use of piping

data2.tibble %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data2.sub #selects columns of interest
  
head(data2.sub)

gen_rand_times2.mod <- function(N, st, et) {
  #  st <- as.POSIXct(as.Date(st))
  #  et <- as.POSIXct(as.Date(et))
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand2<-gen_rand_times2.mod(N=data2.sub$meterph[1], st=data2.sub$date[1], et = data2.sub$date[2])
rand2

results2 <- list() #sets up list for storing results

for(i in 1:nrow(data2.sub)){
  if(data2.sub$dtmin[i]>19 & data2.sub$dtmin[i]<41 & is.na(data2.sub$dtmin[i])==FALSE){
  results2[[i]]<-gen_rand_times2.mod(N=data2.sub$meterph[i], st=data2.sub$date[i], et = data2.sub$date[i+1])
  }
}

randTimesdf2<-plyr::ldply(results2, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf2)

randTimesdf2<-as.tibble(randTimesdf2) #makes dataframe into a tibble for reformatting

randTimesdf2 %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data2", times=nrow(randTimesdf2)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf2 #extracts just the time of each observation from the datetime

randTimesdf2 %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf2 #multiplies to get radians to make data circular

##########################################################################################################################################
#estimates the coefficient of temporal overlap
MaleFemale_Spring_overlap<-overlapEst(randTimesdf$timeRad, randTimesdf2$timeRad, type = "Dhat4") 
MaleFemale_Spring_overlap

##########################################################################################################################################
tiff("BIR_MaleFemale_Spring_Overlap.tiff", width = 6, height = 6, units = 'in', res = 300)
overlapPlot(randTimesdf$timeRad, randTimesdf2$timeRad, main="Spring Wild Pig Activity Curves Florida", linetype = c(2, 1), 
linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("Females (n=23)", "Males (n=25)"), "Overlap=0.XX"), lty=c(1,2,0), col = c(1,1,0), bty="n")
dev.off()
