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

spring_cams <-read_csv("data/BIR_Spring_Cams.csv") #imports datasets

#Now we want to look at activity patters based on the collar data
SpringGPS <- read.csv("data/BIRSpringGPS.csv") 

# Look at just one animal first
SpringGPS<-SpringGPS %>% filter(Indiv_ID=="F108")

dadata_Spring <- as.character(SpringGPS$Fix_DateTime)
dadata_Spring <- as.POSIXct(strptime(as.character(SpringGPS$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
data.traj_Spring <- as.ltraj(xy = SpringGPS[,c("X","Y")], date = dadata_Spring,
                             id = SpringGPS$Indiv_ID, typeII= TRUE, burst = SpringGPS$Indiv_ID)

data.ld_Spring <- ld(data.traj_Spring) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
data.tibble_Spring <- as_tibble(data.ld_Spring) #converts back to tibble format for use of piping
data.tibble_Spring %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(x, y, date, dist,dt, dtmin, dthr, meterph)-> data.sub_Spring #selects columns of interest


# Function to generate pseudo-observations 
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

randTimesdf_Spring <-as_tibble(randTimesdf_Spring) #makes dataframe into a tibble for reformatting

randTimesdf_Spring %>% 
  rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
  mutate(Indiv_ID=rep("data", times=nrow(randTimesdf_Spring)), #creates a new column for the animal ID repeated for the length of the dataframe
         time=format(ymd_hms(datetime), "%H:%M:%S"))->randTimesdf_Spring #extracts just the time of each observation from the datetime

randTimesdf_Spring %>% 
  mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
         timeRad=fractime*2*pi)->randTimesdf_Spring #multiplies to get radians to make data circular

#########################
##Estimating temporal overlap
spring_overlap<-overlapEst(spring_cams$timeRad, randTimesdf_Spring$timeRad, type = "Dhat4") 
spring_overlap

#####

over_dat<-overlapPlot(spring_cams$timeRad, randTimesdf_Spring$timeRad, main="Spring Wild Pig Activity Curves", linecol = c("black", "black"),linewidth = c(2, 2), olapcol = "lightgrey")
over_dat
legend("top", c("Cameras (n=1,692)", "GPS (n=48)", paste("Overlap=",spring_overlap)), lty=c(1,2), col = c(1,1), bty="n") #creates density plot showing activity patterns

       