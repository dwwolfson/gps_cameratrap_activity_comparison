library(lubridate)
library(tidyverse)
library(overlap)
library(circular)
library(CircStats)
library(adehabitatLT)
library(here)

# Import camera data from spring
spring_cams <-read_csv(here("data/BIR_Spring_Cams.csv")) 

#Import gps data from spring
spring_gps <- read.csv(here("data/BIRSpringGPS.csv")) 

dates <- as.POSIXct(strptime(as.character(spring_gps$Fix_DateTime),"%Y/%m/%d %H:%M", tz="America/New_York"))
traj_spring <- as.ltraj(xy = spring_gps[,c("X","Y")], date = dates,
                        id = spring_gps$Indiv_ID, typeII= TRUE, burst = spring_gps$Indiv_ID)

ld_spring <- ld(traj_spring) #ld is a function from the adehabitatlt package that converts from ltraj object back to dataframe

spring_df<-ld_spring %>% 
  mutate(dtmin=dt/60,       #creates a new column for amount of time between points in minutes
         dthr=dt/3600,      #creates a new column for time between points in hours
         meterph=round(dist/dthr, digits=0))%>% #calculates movement rate in meters per hour, rounds to nearest
  dplyr::select(id, x, y, date, dist,dt, dtmin, dthr, meterph)

gen_rand_times.mod <- function(N, st, et) {
  dt <- as.numeric(difftime(et, st, unit="sec")) #calculates the interval in seconds between the start time and end time of the interval
  ev <- sort(runif(N, 0, dt)) #generates N random values within that interval and sorts them from least to greatest
  rt <- st + ev } # adds the generate times in seconds to the start value to create a vector of times between the start and the end

# save a list of all the speed/activity-converted pig datasets

ids<-unique(spring_df$id)
pig_dat<-list()
for(i in seq_along(ids)){
  tmp_res<-list()
  tmp<-spring_df %>% filter(id==ids[[i]])
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
  
  pig_dat[[i]]<-tmp_df$timeRad
}

# create a matrix to store the activity info for each pig
pigMat<-matrix(data = NA, nrow = 256, ncol = length(ids))


### Step 1
# now fit an activity density curve for each pig
for(i in seq_along(ids)){
  tmp_dens<-densityPlot(pig_dat[[i]], xscale=1, n.grid=256, extend=NULL)
  pigMat[,i]<-tmp_dens$y
}


### Step 2
# The first and last rows both refer to midnight: needed for plotting but otherwise leads to double counting. 
# Discard one of them, last is easiest:
pigMat <- pigMat[1:255, ]

#That messes up the area under the curve, but we need to fix the columns to add to 1 for the overlap calculation, so do that now:
pigMat <- sweep(pigMat, 2, colSums(pigMat), "/")
colSums(pigMat)  # should all be 1.


### Step 3
# Get an "average" activity curve with all pigs equally weighted with
pigAve <- rowMeans(pigMat)
#This is a length 255 vector which sums to 1.

### Step 4
# Convert camera data to a vector summing to 1 in the same way as steps 1-3
cam_dens<-densityPlot(spring_cams$timeRad, xscale=1, n.grid = 256, extend=NULL)
camVec<-cam_dens$y
camVec<-camVec[1:255]

#normalize to sum to 1
camVec<-camVec/sum(camVec)


### Step 5
# Estimate overlap with sum(pmin(pigAve, camVec)). This is scalar in (0,1), hopefully close to 1. 
# Strictly speaking this is Dhat1, but with large data sets it makes little difference, and Dhat4 would be unwieldy.
sum(pmin(pigAve, camVec))
#  0.9074561

### Step 6
# For the bootstrap, sample columns from pigMat with replacement:
iter<-10000
for(i in 1:iter) {
  bsCols <- sample(1:length(ids), length(ids), replace=TRUE)
  bsMat <- pigMat[, bsCols]
  bsAve <- rowMeans(bsMat)
  bs[i] <- sum(pmin(bsAve, camVec))
}

### Step 7
# Extract the 95% bootstrap confidence intervals
stats::quantile(bs, probs=c(0.025, 0.975)) 

#      2.5%     97.5% 
#    0.8876061 0.9249048 


## If uncertainty in the camera estimate is included
cam_boot_samples<-overlap::resample(spring_cams$timeRad, 100)
camMat<-matrix(data = NA, nrow = 256, ncol = ncol(cam_boot_samples))
for(i in 1:ncol(cam_boot_samples)){
  tmp<-densityPlot(cam_boot_samples[,i], xscale=1, n.grid=256, extend=NULL)
  camMat[,i]<-tmp$y
}

camMat<-camMat[1:255,]
camMat <- sweep(camMat, 2, colSums(camMat), "/")
colSums(camMat) 
camAve<-rowMeans(camMat)
sum(pmin(pigAve, camAve))
#  0.9089487

iter<-10000
for(i in 1:iter) {
  bsCols <- sample(1:length(ids), length(ids), replace=TRUE)
  bsMat <- pigMat[, bsCols]
  bsAve <- rowMeans(bsMat)
  bs[i] <- sum(pmin(bsAve, camAve))
}
quantile(bs, probs=c(0.025, 0.975)) 
#      2.5%     97.5% 
#    0.8885831 0.9252420 


# Now bootstrap
# 
# bootstrap_overlap<-vector()
# iter=1000
# 
# for(i in 1:iter){
#   ptm<-proc.time()
#   tmp_id<-sample(1:length(pig_dat), 1)
#   tmp<-pig_dat[[tmp_id]]
#   
#   # produce overlap coefficient and store in vector
#   tmp_overlap<-overlapEst(spring_cams$timeRad, tmp, type = "Dhat4") 
#   bootstrap_overlap[[i]]<-tmp_overlap
#   
#   time_minutes<-(proc.time()-ptm)/60
#   time_minutes<-round(time_minutes[["elapsed"]], 1)
#   cat(paste("Last estimate took", time_minutes, "minutes, working on ", i, "out of ", iter," \n "))
# } 
# 
# write_csv(as.data.frame(bootstrap_overlaps), here("output/bootstrap_overlap_example.csv"))