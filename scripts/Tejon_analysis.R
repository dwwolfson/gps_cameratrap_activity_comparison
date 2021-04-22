# Tejon analyses

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# There are 3 sets of comparisons in this script
# 1) Pooling sex and year, compare seasons using GPS datasets and clocktime
# 2) Pooling sex and year, compare seasons using GPS datasets and sunTime
# 3) Pooling sex and year, compare seasons using GPS datasets (clocktime) and camera datasets 

###############################################################################
# Pooling sex and year, compare seasons GPS/GPS with clocktime at Tejon #######
###############################################################################
# 1) spring-summer
# 2) spring-fall
# 3) spring-winter
# 4) summer-fall
# 5) summer-winter
# 6) fall-winter

# Pre-processing
spring<-pre_process(here("data/tejon_date_fixed/TejonSpringGPS.csv"), tz ="America/Los_Angeles")
summer<-pre_process(here("data/tejon_date_fixed/TejonSummerGPS.csv"), tz ="America/Los_Angeles")
fall<-pre_process(here("data/tejon_date_fixed/TejonFallGPS.csv"), tz ="America/Los_Angeles")
winter<-pre_process(here("data/tejon_date_fixed/TejonWinterGPS.csv"), tz ="America/Los_Angeles")

# Create activity kernels
spring_kern<-gps2kernel(spring)
summer_kern<-gps2kernel(summer)
fall_kern<-gps2kernel(fall)
winter_kern<-gps2kernel(winter)

## 1) spring-summer

# Calculate overlap
spring_summer<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                           kernel2=summer_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_kern[["gps_matrix"]],
                           matrix2=summer_kern[["gps_matrix"]])

res<-c("CA", "spring_gps", "summer_gps", 
       spring_summer[[1]], 
       spring_summer[[2]][1],
       spring_summer[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 2) spring-fall

# Calculate overlap
spring_fall<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                         kernel2=fall_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=spring_kern[["gps_matrix"]],
                         matrix2=fall_kern[["gps_matrix"]])

res<-c("CA", "spring_gps", "fall_gps", 
       spring_fall[[1]], 
       spring_fall[[2]][1],
       spring_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 3) spring-winter

# Calculate overlap
spring_winter<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                           kernel2=winter_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_kern[["gps_matrix"]],
                           matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "spring_gps", "winter_gps", 
       spring_winter[[1]], 
       spring_winter[[2]][1],
       spring_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 4) summer-fall

# Calculate overlap
summer_fall<-est_overlap(kernel1=summer_kern[["gps_kernel"]],
                         kernel2=fall_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=summer_kern[["gps_matrix"]],
                         matrix2=fall_kern[["gps_matrix"]])

res<-c("CA", "summer_gps", "fall_gps", 
       summer_fall[[1]], 
       summer_fall[[2]][1],
       summer_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 5) summer-winter

# Calculate overlap
summer_winter<-est_overlap(kernel1=summer_kern[["gps_kernel"]],
                           kernel2=winter_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=summer_kern[["gps_matrix"]],
                           matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "summer_gps", "winter_gps", 
       summer_winter[[1]], 
       summer_winter[[2]][1],
       summer_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 6) fall-winter

# Calculate overlap
fall_winter<-est_overlap(kernel1=fall_kern[["gps_kernel"]],
                         kernel2=winter_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=fall_kern[["gps_matrix"]],
                         matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "fall_gps", "winter_gps", 
       fall_winter[[1]], 
       fall_winter[[2]][1],
       fall_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

#######################################################################################
##### Compare GPS (clocktime) vs camera for Tejon between seasons (yrs, sex pooled) ###
#######################################################################################

# All the GPS datasets are already pre-processed and have activity kernels from previous code above.

# Activity kernels for camera datasets
spring_cam_kern<-cam2kernel(here("data/Tejon/Spring_15-16_Cams.csv"))
summer_cam_kern<-cam2kernel(here("data/Tejon/Summer_15-16_Cams.csv"))
fall_cam_kern<-cam2kernel(here("data/Tejon/Fall_15-16_Cams.csv"))
winter_cam_kern<-cam2kernel(here("data/Tejon/Winter_15-17_Cams.csv"))


# Calculate overlap spring
CA_spring_gps_cam<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                               kernel2=spring_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=spring_kern[["gps_matrix"]])

res<-c("CA", "Spring_GPS", "Spring_Cam", 
                       CA_spring_gps_cam[[1]], 
                       CA_spring_gps_cam[[2]][1],
                       CA_spring_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)


# Calculate overlap summer
CA_summer_gps_cam<-est_overlap(kernel1=summer_kern[["gps_kernel"]],
                               kernel2=summer_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=summer_kern[["gps_matrix"]])

res<-c("CA", "summer_GPS", "summer_Cam", 
       CA_summer_gps_cam[[1]], 
       CA_summer_gps_cam[[2]][1],
       CA_summer_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# Calculate overlap fall
CA_fall_gps_cam<-est_overlap(kernel1=fall_kern[["gps_kernel"]],
                               kernel2=fall_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=fall_kern[["gps_matrix"]])

res<-c("CA", "fall_GPS", "fall_Cam", 
       CA_fall_gps_cam[[1]], 
       CA_fall_gps_cam[[2]][1],
       CA_fall_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# Calculate overlap winter
CA_winter_gps_cam<-est_overlap(kernel1=winter_kern[["gps_kernel"]],
                               kernel2=winter_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=winter_kern[["gps_matrix"]])

res<-c("CA", "winter_GPS", "winter_Cam", 
       CA_winter_gps_cam[[1]], 
       CA_winter_gps_cam[[2]][1],
       CA_winter_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)


#########################################################################
############################################################################
# Convert to suntime for FL seasonal comparisons pooling years and sexes ###
#########################################################################
# 1) spring-summer
# 2) spring-fall
# 3) spring-winter
# 4) summer-fall
# 5) summer-winter
# 6) fall-winter



# Pre-processing
spring<-pre_process_suntime_conversion(here("data/BIRSpringGPS.csv"), tz ="America/Los_Angeles", site = "CA")
summer<-pre_process_suntime_conversion(here("data/BIRSummerGPS.csv"), tz ="America/Los_Angeles", site = "CA")
fall<-pre_process_suntime_conversion(here("data/BIRFallGPS.csv"), tz ="America/Los_Angeles", site = "CA")
winter<-pre_process_suntime_conversion(here("data/BIRWinterGPS.csv"), tz ="America/Los_Angeles", site = "CA")

# Create activity kernels
spring_kern<-gps2kernel(spring)
summer_kern<-gps2kernel(summer)
fall_kern<-gps2kernel(fall)
winter_kern<-gps2kernel(winter)

## 1) spring-summer

# Calculate overlap
spring_summer<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                           kernel2=summer_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_kern[["gps_matrix"]],
                           matrix2=summer_kern[["gps_matrix"]])

res<-c("CA", "spring_gps_suntime", "summer_gps_suntime", 
       spring_summer[[1]], 
       spring_summer[[2]][1],
       spring_summer[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 2) spring-fall

# Calculate overlap
spring_fall<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                         kernel2=fall_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=spring_kern[["gps_matrix"]],
                         matrix2=fall_kern[["gps_matrix"]])

res<-c("CA", "spring_gps_suntime", "fall_gps_suntime", 
       spring_fall[[1]], 
       spring_fall[[2]][1],
       spring_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 3) spring-winter

# Calculate overlap
spring_winter<-est_overlap(kernel1=spring_kern[["gps_kernel"]],
                           kernel2=winter_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_kern[["gps_matrix"]],
                           matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "spring_gps_suntime", "winter_gps_suntime", 
       spring_winter[[1]], 
       spring_winter[[2]][1],
       spring_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 4) summer-fall

# Calculate overlap
summer_fall<-est_overlap(kernel1=summer_kern[["gps_kernel"]],
                         kernel2=fall_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=summer_kern[["gps_matrix"]],
                         matrix2=fall_kern[["gps_matrix"]])

res<-c("CA", "summer_gps_suntime", "fall_gps_suntime", 
       summer_fall[[1]], 
       summer_fall[[2]][1],
       summer_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 5) summer-winter

# Calculate overlap
summer_winter<-est_overlap(kernel1=summer_kern[["gps_kernel"]],
                           kernel2=winter_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=summer_kern[["gps_matrix"]],
                           matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "summer_gps_suntime", "winter_gps_suntime", 
       summer_winter[[1]], 
       summer_winter[[2]][1],
       summer_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

####
## 6) fall-winter

# Calculate overlap
fall_winter<-est_overlap(kernel1=fall_kern[["gps_kernel"]],
                         kernel2=winter_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=fall_kern[["gps_matrix"]],
                         matrix2=winter_kern[["gps_matrix"]])

res<-c("CA", "fall_gps_suntime", "winter_gps_suntime", 
       fall_winter[[1]], 
       fall_winter[[2]][1],
       fall_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)



