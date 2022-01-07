# Function for pre-processing GPS dataset with suntime adjustment


library(lubridate)
library(tidyverse)
library(overlap)
library(circular)
library(CircStats)
library(adehabitatLT)
library(here)
library(sp)


# Function to create pseudo-observations based on speed in gps
gen_rand_times.mod <- function(N, st, et) {
  dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
  ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
  rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end


# Function for entire pre-processing
# Starts with taking import dataset csv and ends with returning a list with each item a speed/converted dataset ready for overlap functions
# customized for the format of gps datasets with the following variables

# ..   Indiv_ID = col_character(),
# ..   Sex = col_logical(),
# ..   Season = col_character(),
# ..   Season2 = col_character(),
# ..   Fix_DateTime = col_character(),
# ..   X = col_double(),
# ..   Y = col_double(),
# ..   Month = col_double(),
# ..   Day = col_double(),
# ..   Year = col_double()


pre_process_suntime_conversion<-function(path_to_gps_dataset, tz="America/New_York", site="FL"){
  ptm<-proc.time()
  gps_dataset<-read.csv(path_to_gps_dataset)
  
  dates <- as.POSIXct(strptime(as.character(gps_dataset$Fix_DateTime),"%Y/%m/%d %H:%M", tz=tz))
  traj_df <- as.ltraj(xy = gps_dataset[,c("X","Y")], date = dates,
                      id = gps_dataset$Indiv_ID, typeII= TRUE, burst = gps_dataset$Indiv_ID)
  
  df <- ld(traj_df) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe
  
  df<-df %>% 
    mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
           dthr=dt/3600,      #creates a new column for time between points in hours
           meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
    dplyr::select(id, x, y, date, dist,dt, dtmin, dthr, meterph)
  
  # now create a list of all the speed/activity-converted pig datasets
  
  ids<-unique(df$id)
  pig_dat<-list()
  
  for(i in seq_along(ids)){
    tmp_res<-list()
    tmp<-df %>% filter(id==ids[[i]])
    
    # Add in something here to conserve the coordinates after psuedoobservations are created for sunTime function
    
    
    # use time intervals between 20 and 40 minutes
    for(j in 1:nrow(tmp)){
      if(tmp$dtmin[j]>19 & tmp$dtmin[j]<41 & is.na(tmp$dtmin[j])==FALSE){
        tmp_res[[j]]<-gen_rand_times.mod(N=tmp$meterph[j], st=tmp$date[j], et = tmp$date[j+1])
      }
    }
    
    tmp_df <-plyr::ldply(tmp_res, data.frame) #takes all the results from the list and binds them into a single dataframe
    
    tmp_df<-tmp_df %>% 
      rename(datetime=`X..i..`) %>%  #renames default name with "datetime"
      mutate(Indiv_ID=rep("data", times=nrow(tmp_df)), #creates a new column for the animal ID repeated for the length of the dataframe
             time=format(ymd_hms(datetime), "%H:%M:%S")) #extracts just the time of each observation from the datetime
    
    tmp_df<-tmp_df %>% 
      mutate(fractime=hms(time)/hms("24:00:00"), #calculates the fraction of the diel cycle based on the time
             timeRad=fractime*2*pi)#multiplies to get radians to make data circular
    
    if(site=="FL"){
    site_locs<-sp::SpatialPoints(cbind(-81.195665, 27.168992), proj4string=sp::CRS("+proj=longlat +datum=WGS84"))    
    } else {site_locs<-sp::SpatialPoints(cbind(-118.7832222, 34.898505), proj4string=sp::CRS("+proj=longlat +datum=WGS84"))      
    }
    tmp_df$suntime<-overlap::sunTime(clockTime = tmp_df$timeRad, Dates = tmp_df$datetime, site_locs)
    
    pig_dat[[i]]<-tmp_df$suntime
    cat("Working on pig number", i, "out of", length(ids), "\n")
  }
  time_minutes<-(proc.time()-ptm)/60
  time_minutes<-round(time_minutes[["elapsed"]], 1)
  cat("This pre-processing function took", time_minutes, "minutes")
  return(pig_dat)
}
    
    
    
    