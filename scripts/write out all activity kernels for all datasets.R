library(here)
library(readr)
library(dplyr)
library(activity)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

out_dir<-here("output/activity_kernels")

# Collect all file paths
paths<-NA

# Tejon datasets
#GPS
paths[1]<-here("data/tejon_date_fixed/TejonSpringGPS.csv")
paths[2]<-here("data/tejon_date_fixed/TejonSummerGPS.csv")
paths[3]<-here("data/tejon_date_fixed/TejonFallGPS.csv")
paths[4]<-here("data/tejon_date_fixed/TejonWinterGPS.csv")

# Florida datasets
#GPS
paths[5]<-here("data/BIRSpringGPS.csv")
paths[6]<-here("data/BIRSummerGPS.csv")
paths[7]<-here("data/BIRFallGPS.csv")
paths[8]<-here("data/BIRWinterGPS.csv")

#Sex-specific
paths[9]<- here("data/sex_comparisons/BIR_SpringGPS_Females.csv")
paths[10]<-here("data/sex_comparisons/BIR_SpringGPS_Males.csv")
paths[11]<-here("data/sex_comparisons/BIR_SummerGPS_Females.csv")
paths[12]<-here("data/sex_comparisons/BIR_SummerGPS_Males.csv")
paths[13]<-here("data/sex_comparisons/BIR_FallGPS_Females.csv")
paths[14]<-here("data/sex_comparisons/BIR_FallGPS_Males.csv")
paths[15]<-here("data/sex_comparisons/BIR_WinterGPS_Females.csv")
paths[16]<-here("data/sex_comparisons/BIR_WinterGPS_Males.csv")

#Sex and year specific
paths[17]<-here("data/sexes_by_year/BIR_SpringGPS_Females2015.csv")
paths[18]<-here("data/sexes_by_year/BIR_SpringGPS_Females2016.csv")
paths[19]<-here("data/sexes_by_year/BIR_SpringGPS_Females2017.csv")
paths[20]<-here("data/sexes_by_year/BIR_SpringGPS_Males2015.csv")
paths[21]<-here("data/sexes_by_year/BIR_SpringGPS_Males2016.csv")
paths[22]<-here("data/sexes_by_year/BIR_SpringGPS_Males2017.csv")
paths[23]<-here("data/sexes_by_year/BIR_SummerGPS_Females2015.csv")
paths[24]<-here("data/sexes_by_year/BIR_SummerGPS_Females2016.csv")
paths[25]<-here("data/sexes_by_year/BIR_SummerGPS_Females2017.csv")
paths[26]<-here("data/sexes_by_year/BIR_SummerGPS_Males2015.csv")
paths[27]<-here("data/sexes_by_year/BIR_SummerGPS_Males2016.csv")
paths[28]<-here("data/sexes_by_year/BIR_SummerGPS_Males2017.csv")
paths[29]<-here("data/sexes_by_year/BIR_FallGPS_Females2016.csv")
paths[30]<-here("data/sexes_by_year/BIR_FallGPS_Females2017.csv")

# plus 12 comparisons using suntime-corrected datasets (6 from each study site)
# those use 4 datasets to do 6 comparison for each site, the pooled (year and sex) gps season datasets
# so need 8 more datasets with the separate suntime-correction function
# should be 38 gps datasets in total to write out to the output/activity_kernels folder

tmp<-NA


for(i in 1:length(paths)){
  cat("Creating activity kernel for dataset", i, "out of", length(paths), "\n")
  tmp<-pre_process(paths[i])
  num_pigs<-length(tmp)
  # create a matrix to store the activity info for each pig
  gps_mat<-matrix(data = NA, nrow = 513, ncol = num_pigs)
  
  # Create activity kernels
  for(j in 1:num_pigs){
      ptm<-proc.time()
      cat("Creating activity kernel for pig", j, "out of", num_pigs, "\n")
      tmp_dens<-densityPlot(tmp[[j]], xscale=2*pi, n.grid=513, extend=NULL)
      gps_mat[,j]<-tmp_dens$y
      time_minutes<-(proc.time()-ptm)/60
      time_minutes<-round(time_minutes[["elapsed"]], 2)
      cat("The activity kernel for this individual took", time_minutes, "minutes", "\n")
  }
  # Save output to file
  write_csv(as.data.frame(gps_mat), paste(out_dir, basename(paths[i]), sep="/"))
}


# Now I'll create the suntime-corrected kernels
sun_paths<-paths[c(5:8)]
tmp<-NA
i<-NA
j<-NA

for(i in 1:length(sun_paths)){
  cat("Creating activity kernel for dataset", i, "out of", length(sun_paths), "\n")
  
  if(grepl("tejon", sun_paths[i])){
  tmp<-pre_process_suntime_conversion(sun_paths[i], tz="America/Los_Angeles", site="CA")}
  else{
    tmp<-pre_process_suntime_conversion(sun_paths[i]) # Florida time zone is the default argument
  }
  num_pigs<-length(tmp)
  # create a matrix to store the activity info for each pig
  gps_mat<-matrix(data = NA, nrow = 513, ncol = num_pigs)
  
  # Create activity kernels
  for(j in 1:num_pigs){
    ptm<-proc.time()
    cat("Creating activity kernel for pig", j, "out of", num_pigs, "\n")
    tmp_dens<-densityPlot(tmp[[j]], xscale=2*pi, n.grid=513, extend=NULL)
    gps_mat[,j]<-tmp_dens$y
    time_minutes<-(proc.time()-ptm)/60
    time_minutes<-round(time_minutes[["elapsed"]], 2)
    cat("The activity kernel for this individual took", time_minutes, "minutes", "\n")
  }
  # Save output to file
  write_csv(as.data.frame(gps_mat), paste(out_dir, "suntime_adjusted", basename(sun_paths[i]), sep="/"))
}








# Now I'll do the cameras separately
# These will be fit with activity::fitact because it's easier to get CIs in one line
cam_paths<-NA

#Tejon
# Cams
cam_paths[1]<-here("data/tejon/Spring_15-16_Cams.csv")
cam_paths[2]<-here("data/tejon/Summer_15-16_Cams.csv")
cam_paths[3]<-here("data/tejon/Fall_15-16_Cams.csv")
cam_paths[4]<-here("data/tejon/Winter_15-17_Cams.csv")

#Florida
#Cams
cam_paths[5]<-here("data/BIR_Spring_Cams.csv")
cam_paths[6]<-here("data/BIR_Summer_Cams.csv")
cam_paths[7]<-here("data/BIR_Fall_Cams.csv")
cam_paths[8]<-here("data/BIR_Winter_Cams.csv")


for(i in 1:length(cam_paths)){
  tmp_db<-read_csv(cam_paths[[i]])
  tmp_kernel<-fitact(tmp_db$timeRad, reps=1000, sample="data")
  out<-as.data.frame(tmp_kernel@pdf)
  write_csv(out, paste(out_dir, basename(cam_paths[i]), sep="/"))
  }

