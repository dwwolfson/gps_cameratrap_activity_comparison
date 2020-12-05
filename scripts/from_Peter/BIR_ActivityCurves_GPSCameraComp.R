##Set working directory
setwd("F:/Documents/ASU/ActivityPatterns/R/ForDavid/GPSCameraComp")

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

#Camera Trap Data Analyses
fall <-read_csv("BIR_Fall_Cams.csv") #imports datasets
spring <-read_csv("BIR_Spring_Cams.csv") #imports datasets
summer <-read_csv("BIR_Summer_Cams.csv") #imports datasets
winter <-read_csv("BIR_Winter_Cams.csv") #imports datasets

##########################################################################################################################################
#Now we want to look at activity patters based on the collar data
SpringGPS <- read.csv("BIRSpringGPS.csv") 
dadata_Spring <- as.character(SpringGPS$Fix_DateTime)
dadata_Spring <- as.POSIXct(strptime(as.character(SpringGPS$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj_Spring <- as.ltraj(xy = SpringGPS[,c("X","Y")], date = dadata_Spring, id = SpringGPS$Indiv_ID, typeII= TRUE, burst = SpringGPS$Indiv_ID)

data.ld_Spring <- ld(data.traj_Spring) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
data.tibble_Spring <- as.tibble(data.ld_Spring) #converts back to tibble format for use of piping
data.tibble_Spring %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub_Spring #selects columns of interest

gen_rand_times.mod <- function(N, st, et) {
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand_Spring<-gen_rand_times.mod(N=data.sub_Spring$meterph[1], st=data.sub_Spring$date[1], et = data.sub_Spring$date[2])
results <- list() #sets up list for storing results
for(i in 1:nrow(data.sub_Spring)){
  if(data.sub_Spring$dtmin[i]>19 & data.sub_Spring$dtmin[i]<41 & is.na(data.sub_Spring$dtmin[i])==FALSE){
  results[[i]]<-gen_rand_times.mod(N=data.sub_Spring$meterph[i], st=data.sub_Spring$date[i], et = data.sub_Spring$date[i+1])
  }
}

randTimesdf_Spring <-plyr::ldply(results, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf_Spring)

randTimesdf_Spring <-as.tibble(randTimesdf_Spring) #makes dataframe into a tibble for reformatting

randTimesdf_Spring %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf_Spring)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf_Spring #extracts just the time of each observation from the datetime

randTimesdf_Spring %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf_Spring #multiplies to get radians to make data circular

SummerGPS <- read.csv("BIRSummerGPS.csv") 
dadata_Summer <- as.character(SummerGPS$Fix_DateTime)
dadata_Summer <- as.POSIXct(strptime(as.character(SummerGPS$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj_Summer <- as.ltraj(xy = SummerGPS[,c("X","Y")], date = dadata_Summer, id = SummerGPS$Indiv_ID, typeII= TRUE, burst = SummerGPS$Indiv_ID)

data.ld_Summer <- ld(data.traj_Summer) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
data.tibble_Summer <- as.tibble(data.ld_Summer) #converts back to tibble format for use of piping
data.tibble_Summer %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub_Summer #selects columns of interest

gen_rand_times.mod <- function(N, st, et) {
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand_Summer<-gen_rand_times.mod(N=data.sub_Summer$meterph[1], st=data.sub_Summer$date[1], et = data.sub_Summer$date[2])
results <- list() #sets up list for storing results
for(i in 1:nrow(data.sub_Summer)){
  if(data.sub_Summer$dtmin[i]>19 & data.sub_Summer$dtmin[i]<41 & is.na(data.sub_Summer$dtmin[i])==FALSE){
  results[[i]]<-gen_rand_times.mod(N=data.sub_Summer$meterph[i], st=data.sub_Summer$date[i], et = data.sub_Summer$date[i+1])
  }
}

randTimesdf_Summer <-plyr::ldply(results, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf_Summer)

randTimesdf_Summer <-as.tibble(randTimesdf_Summer) #makes dataframe into a tibble for reformatting

randTimesdf_Summer %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf_Summer)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf_Summer #extracts just the time of each observation from the datetime

randTimesdf_Summer %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf_Summer #multiplies to get radians to make data circular

FallGPS <- read.csv("BIRFallGPS.csv") 
dadata_Fall <- as.character(FallGPS$Fix_DateTime)
dadata_Fall <- as.POSIXct(strptime(as.character(FallGPS$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj_Fall <- as.ltraj(xy = FallGPS[,c("X","Y")], date = dadata_Fall, id = FallGPS$Indiv_ID, typeII= TRUE, burst = FallGPS$Indiv_ID)

data.ld_Fall <- ld(data.traj_Fall) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
data.tibble_Fall <- as.tibble(data.ld_Fall) #converts back to tibble format for use of piping
data.tibble_Fall %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub_Fall #selects columns of interest

gen_rand_times.mod <- function(N, st, et) {
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand_Fall<-gen_rand_times.mod(N=data.sub_Fall$meterph[1], st=data.sub_Fall$date[1], et = data.sub_Fall$date[2])
results <- list() #sets up list for storing results
for(i in 1:nrow(data.sub_Fall)){
  if(data.sub_Fall$dtmin[i]>19 & data.sub_Fall$dtmin[i]<41 & is.na(data.sub_Fall$dtmin[i])==FALSE){
  results[[i]]<-gen_rand_times.mod(N=data.sub_Fall$meterph[i], st=data.sub_Fall$date[i], et = data.sub_Fall$date[i+1])
  }
}

randTimesdf_Fall <-plyr::ldply(results, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf_Fall)

randTimesdf_Fall <-as.tibble(randTimesdf_Fall) #makes dataframe into a tibble for reformatting

randTimesdf_Fall %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf_Fall)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf_Fall #extracts just the time of each observation from the datetime

randTimesdf_Fall %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf_Fall #multiplies to get radians to make data circular

WinterGPS <- read.csv("BIRWinterGPS.csv") 
dadata_Winter <- as.character(WinterGPS$Fix_DateTime)
dadata_Winter <- as.POSIXct(strptime(as.character(WinterGPS$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj_Winter <- as.ltraj(xy = WinterGPS[,c("X","Y")], date = dadata_Winter, id = WinterGPS$Indiv_ID, typeII= TRUE, burst = WinterGPS$Indiv_ID)

data.ld_Winter <- ld(data.traj_Winter) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
data.tibble_Winter <- as.tibble(data.ld_Winter) #converts back to tibble format for use of piping
data.tibble_Winter %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub_Winter #selects columns of interest

gen_rand_times.mod <- function(N, st, et) {
     dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
     ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
     rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

rand_Winter<-gen_rand_times.mod(N=data.sub_Winter$meterph[1], st=data.sub_Winter$date[1], et = data.sub_Winter$date[2])
results <- list() #sets up list for storing results
for(i in 1:nrow(data.sub_Winter)){
  if(data.sub_Winter$dtmin[i]>19 & data.sub_Winter$dtmin[i]<41 & is.na(data.sub_Winter$dtmin[i])==FALSE){
  results[[i]]<-gen_rand_times.mod(N=data.sub_Winter$meterph[i], st=data.sub_Winter$date[i], et = data.sub_Winter$date[i+1])
  }
}

randTimesdf_Winter <-plyr::ldply(results, data.frame) #takes all the results from the list and binds them into a single dataframe
head(randTimesdf_Winter)

randTimesdf_Winter <-as.tibble(randTimesdf_Winter) #makes dataframe into a tibble for reformatting

randTimesdf_Winter %>% 
   rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf_Winter)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf_Winter #extracts just the time of each observation from the datetime

randTimesdf_Winter %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf_Winter #multiplies to get radians to make data circular

##########################################################################################################################################
##Estimating temporal overlap
spring_overlap<-overlapEst(spring$timeRad, randTimesdf_Spring$timeRad, type = "Dhat4") 
spring_overlap

summer_overlap<-overlapEst(summer$timeRad, randTimesdf_Summer$timeRad, type = "Dhat4") 
summer_overlap

fall_overlap<-overlapEst(fall$timeRad, randTimesdf_Fall$timeRad, type = "Dhat4") 
fall_overlap

winter_overlap<-overlapEst(winter$timeRad, randTimesdf_Winter$timeRad, type = "Dhat4") 
winter_overlap

##########################################################################################################################################
##Making plots
tiff("BIRSpring.tiff", width = 6, height = 6, units = 'in', res = 300)
overlapPlot(springboth$timeRad, randTimesdf$timeRad, main="Spring Wild Pig Activity Curves", linecol = c("black", "black"),linewidth = c(2, 2), olapcol = "lightgrey")
legend("top", c("Cameras (n=1,692)", "GPS (n=48)", "Overlap=0.XX"), lty=c(1,2), col = c(1,1), bty="n") #creates density plot showing activity patterns
dev.off()

tiff("BIRSummer.tiff", width = 6, height = 6, units = 'in', res = 300)
overlapPlot(summerboth$timeRad, randTimesdf$timeRad, main="Summer Wild Pig Activity Curves", linecol = c("black", "black"),linewidth = c(2, 2), olapcol = "lightgrey")
legend("top", c("Cameras (n=1,156)", "GPS (n=42)", "Overlap=0.XX"), lty=c(1,2), col = c(1,1), bty="n") #creates density plot showing activity patterns
dev.off()

tiff("BIRFall.tiff", width = 6, height = 6, units = 'in', res = 300)
overlapPlot(fallboth$timeRad, randTimesdf$timeRad, main="Fall Wild Pig Activity Curves", linecol = c("black", "black"),linewidth = c(2, 2), olapcol = "lightgrey")
legend("top", c("Cameras (n=1,804)", "GPS (n=25)", "Overlap=0.XX"), lty=c(1,2), col = c(1,1), bty="n") #creates density plot showing activity patterns
dev.off()

tiff("BIRWinter.tiff", width = 6, height = 6, units = 'in', res = 300)
overlapPlot(winterboth$timeRad, randTimesdf$timeRad, main="Winter Wild Pig Activity Curves", linecol = c("black", "black"),linewidth = c(2, 2), olapcol = "lightgrey")
legend("top", c("Cameras (n=1,429)", "GPS (n=26)", "Overlap=0.XX"), lty=c(1,2), col = c(1,1), bty="n") #creates density plot showing activity patterns
dev.off()
