# Create a table summarizing sample sizes and proportion diurnal/nocturnal/crepuscular

# For this table I'll want to know the sample sizes (either in collared pigs or number of camera detections) 
# for each season and study site combination

# I'm going to save out the suntime-corrected output for both the gps and camera datasets so I won't need to rerun

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

gps_out<-here("output/suntime_datasets/gps")
cam_out<-here("output/suntime_datasets/cameras")

gps_paths<-NA
cam_paths<-NA

# for storing in table
seasons<-rep(c("spring", "summer", "fall", "winter"),2)

# store info for table
diel_table<-data.frame(site=NA, method=NA, season=NA, sample_size=NA,
                       prop_nocturnal=NA, prop_diurnal=NA, prop_crepuscular=NA)

# write blank table to file
write_csv(diel_table, here("output/diel_table.csv"))

# Tejon GPS
gps_paths[1]<-here("data/tejon_date_fixed/TejonSpringGPS.csv")
gps_paths[2]<-here("data/tejon_date_fixed/TejonSummerGPS.csv")
gps_paths[3]<-here("data/tejon_date_fixed/TejonFallGPS.csv")
gps_paths[4]<-here("data/tejon_date_fixed/TejonWinterGPS.csv")

# Florida GPS
gps_paths[5]<-here("data/BIRSpringGPS.csv")
gps_paths[6]<-here("data/BIRSummerGPS.csv")
gps_paths[7]<-here("data/BIRFallGPS.csv")
gps_paths[8]<-here("data/BIRWinterGPS.csv")

for(i in seq_along(gps_paths)){
  if(grepl("tejon", gps_paths[i])){
    # pre-process gps telemetry data with suntime correction
    tmp<-pre_process_suntime_conversion(gps_paths[i], tz="America/Los_Angeles", site="CA")
    
    saveRDS(tmp, paste0(gps_out, "/",substr(basename(gps_paths[i]),1,nchar(basename(gps_paths[i]))-4), ".Rda"))
    
    # sample size
    n<-length(tmp)
    
    # unlist and pool all individuals
    tmp_vec<-unlist(tmp)
    
    # convert from radians to hours
    tmp_hrs<-tmp_vec*(24/(2*pi))
    
    # daily categories
    tmp_nocturnal<-sum(tmp_hrs<5 | tmp_hrs>19)/length(tmp_hrs)
    tmp_diurnal<-sum(tmp_hrs > 7 & tmp_hrs < 17)/length(tmp_hrs)
    tmp_crepuscular<-sum(tmp_hrs >5 & tmp_hrs < 7 | tmp_hrs > 17 & tmp_hrs < 19)/length(tmp_hrs)

    
    # write out sample size and diel categories
    tmp_row<-as.data.frame(t(c("CA", "GPS", seasons[i], n, tmp_nocturnal,
                      tmp_diurnal, tmp_crepuscular)))
    write_csv(tmp_row, here("output/diel_table.csv"), append = T)
    
    }
  else{
    # pre-process gps telemetry data with suntime correction
    tmp<-pre_process_suntime_conversion(gps_paths[i]) # Florida time zone is the default argument
    saveRDS(tmp, paste0(gps_out, "/",substr(basename(gps_paths[i]),1,nchar(basename(gps_paths[i]))-4), ".Rda"))
    
    # sample size
    n<-length(tmp)
    
    # unlist and pool all individuals
    tmp_vec<-unlist(tmp)
    
    # convert from radians to hours
    tmp_hrs<-tmp_vec*(24/(2*pi))
    
    # daily categories
    tmp_nocturnal<-sum(tmp_hrs<5 | tmp_hrs>19)/length(tmp_hrs)
    tmp_diurnal<-sum(tmp_hrs > 7 & tmp_hrs < 17)/length(tmp_hrs)
    tmp_crepuscular<-sum(tmp_hrs >5 & tmp_hrs < 7 | tmp_hrs > 17 & tmp_hrs < 19)/length(tmp_hrs)
    
    # write out sample size and diel categories
    tmp_row<-as.data.frame(t(c("FL", "GPS", seasons[i], n, tmp_nocturnal,
                               tmp_diurnal, tmp_crepuscular)))
    write_csv(tmp_row, here("output/diel_table.csv"), append = T)
  }
}



#Cameras
cam_paths[1]<-here("data/BIR_Spring_Cams.csv")
cam_paths[2]<-here("data/BIR_Summer_Cams.csv")
cam_paths[3]<-here("data/BIR_Fall_Cams.csv")
cam_paths[4]<-here("data/BIR_Winter_Cams.csv")

#Cameras
cam_paths[5]<-here("data/Tejon/Spring_15-16_Cams.csv")
cam_paths[6]<-here("data/Tejon/Summer_15-16_Cams.csv")
cam_paths[7]<-here("data/Tejon/Fall_15-16_Cams.csv")
cam_paths[8]<-here("data/Tejon/Winter_15-17_Cams.csv")

# Note! I changed csv's from paths 3 and 7 to have consistent date format for parsing


for(i in seq_along(cam_paths)){
  if(grepl("Tejon", cam_paths[i])){
    tmp<-read_csv(cam_paths[[i]])
    site_locs<-sp::SpatialPoints(cbind(-118.7832222, 34.898505), proj4string=sp::CRS("+proj=longlat +datum=WGS84"))
    tmp$ImageDate<-as.POSIXct(strptime(as.character(tmp$ImageDate), "%m/%d/%Y", tz="America/Los_Angeles"))
    tmp$suntime<-overlap::sunTime(clockTime = tmp$timeRad, Dates = tmp$ImageDate, Coords = site_locs)
    
    saveRDS(tmp, paste0(cam_out, "/",substr(basename(cam_paths[i]),1,nchar(basename(cam_paths[i]))-4), ".Rda"))
    
    # convert from radians to hours
    tmp_hrs<-tmp$suntime*(24/(2*pi))
    
    # sample size
    n<-length(unique(tmp$LocationName))
    
    # daily categories
    tmp_nocturnal<-sum(tmp_hrs<5 | tmp_hrs>19)/length(tmp_hrs)
    tmp_diurnal<-sum(tmp_hrs > 7 & tmp_hrs < 17)/length(tmp_hrs)
    tmp_crepuscular<-sum(tmp_hrs >5 & tmp_hrs < 7 | tmp_hrs > 17 & tmp_hrs < 19)/length(tmp_hrs)
    
    # write out sample size and diel categories
    tmp_row<-as.data.frame(t(c("CA", "cam", seasons[i], n, tmp_nocturnal,
                               tmp_diurnal, tmp_crepuscular)))
    write_csv(tmp_row, here("output/diel_table.csv"), append = T)
  }else{
    tmp<-read_csv(cam_paths[[i]])
    site_locs<-sp::SpatialPoints(cbind(-81.195665, 27.168992), proj4string=sp::CRS("+proj=longlat +datum=WGS84")) 
    
  
    tmp$ImageDate<-as.POSIXct(strptime(as.character(tmp$ImageDate), "%m/%d/%Y", tz="America/New_York"))
    
    
    tmp$suntime<-overlap::sunTime(clockTime = tmp$timeRad, Dates = tmp$ImageDate, Coords = site_locs)
    
    saveRDS(tmp, paste0(cam_out, "/",substr(basename(cam_paths[i]),1,nchar(basename(cam_paths[i]))-4), ".Rda"))
    
    # convert from radians to hours
    tmp_hrs<-tmp$suntime*(24/(2*pi))
    
    # sample size
    n<-length(unique(tmp$LocationName))
    
    # daily categories
    tmp_nocturnal<-sum(tmp_hrs < 5 | tmp_hrs > 19)/length(tmp_hrs)
    tmp_diurnal<-sum(tmp_hrs > 7 & tmp_hrs < 17)/length(tmp_hrs)
    tmp_crepuscular<-sum(tmp_hrs > 5 & tmp_hrs < 7 | tmp_hrs > 17 & tmp_hrs < 19)/length(tmp_hrs)
    
    # write out sample size and diel categories
    tmp_row<-as.data.frame(t(c("FL", "cam", seasons[i], n, tmp_nocturnal,
                               tmp_diurnal, tmp_crepuscular)))
    write_csv(tmp_row, here("output/diel_table.csv"), append = T)
    }
}
    
# Try to make a decent table
# table<-read_csv(here("output/diel_table.csv"))
# 
# my_tab<-knitr::kable(
#   table,
#   format = "simple",
#   escape = FALSE,
#   booktabs = TRUE,
#   caption = "caption text here",
#   col.names = c("Study Site", "Method", "Season", "Sample Size",
#                 "Proportion Nocturnal", "Proportion Diurnal", "Proportion Crepuscular"),
#   align = c("l", "c")
# )
# 
# kableExtra::save_kable(my_tab, here("table1.pdf"))  
# looks good in r but doesn't render well to pdf

