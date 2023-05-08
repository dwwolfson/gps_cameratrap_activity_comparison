# Overlap statistics with suntime-corrected datasets

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# Create dataframe to store results
overlap_results<-data.frame(state=NA, db1=NA, db2=NA, coef_overlap=NA, CI_lower=NA, CI_upper=NA)

######################################################
#####################################################

# This script is for all overlap analyses:

# Florida

# GPS to Cam
# 1) FL Spring GPS data to FL Spring Camera data
# 2) FL Summer GPS data to FL Summer Camera data
# 3) FL Fall GPS data to FL Fall Camera data
# 4) FL Winter GPS data to FL Winter Camera data

# Seasonal comparisons
# 5) spring-summer FL GPS
# 6) spring-fall FL GPS
# 7) spring-winter FL GPS
# 8) summer-fall FL GPS
# 9) summer-winter FL GPS
# 10) fall-winter FL GPS

# Sex comparisons
# 11) FL GPS spring M vs F
# 12) FL GPS summer M vs F
# 13) FL GPS fall M vs F
# 14) FL GPS winter M vs F

##
# California
# 15) CA Spring GPS data to CA Spring Camera data
# 16) CA Summer GPS data to CA Summer Camera data
# 17) CA Fall GPS data to CA Fall Camera data
# 18) CA Winter GPS data to CA Winter Camera data

# Seasonal comparisons
# 19) spring-summer CA GPS
# 20) spring-fall CA GPS
# 21) spring-winter CA GPS
# 22) summer-fall CA GPS
# 23) summer-winter CA GPS
# 24) fall-winter CA GPS

# Insufficient samples sizes to compare CA GPS datasets by sex

######################################################
#####################################################

# 1) FL Spring GPS data to FL Spring Camera data
spring_gps<-readRDS(here("output/suntime_datasets/gps/BIRSpringGPS.Rda"))
spring_cam<-readRDS(here("output/suntime_datasets/cameras/BIR_Spring_Cams.Rda"))

# Create activity kernels
spring_gps_kern<-gps2kernel(spring_gps)
spring_cam_kern<-cam2kern(spring_cam)

# Calculate overlap
FL_spring_gps_cam<-est_overlap(kernel1=spring_gps_kern[["gps_kernel"]],
                               kernel2=spring_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=spring_gps_kern[["gps_matrix"]])

overlap_results[1,]<-c("FL", "Spring_GPS", "Spring_Cam", 
                       FL_spring_gps_cam[[1]], 
                       FL_spring_gps_cam[[2]][1],
                       FL_spring_gps_cam[[2]][2])

write_csv(overlap_results, here("output/all_suntimes_overlap_table.csv"))


# 2) FL Summer GPS data to FL Summer Camera data
summer_gps<-readRDS(here("output/suntime_datasets/gps/BIRSummerGPS.Rda"))
summer_cam<-readRDS(here("output/suntime_datasets/cameras/BIR_Summer_Cams.Rda"))


# Create activity kernels
summer_gps_kern<-gps2kernel(summer_gps)
summer_cam_kern<-cam2kern(summer_cam)

# Calculate overlap
FL_summer_gps_cam<-est_overlap(kernel1=summer_gps_kern[["gps_kernel"]],
                               kernel2=summer_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=summer_gps_kern[["gps_matrix"]])

res<-c("FL", "summer_GPS", "summer_Cam", 
       FL_summer_gps_cam[[1]], 
       FL_summer_gps_cam[[2]][1],
       FL_summer_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)


# 3) FL Fall GPS data to FL Fall Camera data
fall_gps<-readRDS(here("output/suntime_datasets/gps/BIRFallGPS.Rda"))
fall_cam<-readRDS(here("output/suntime_datasets/cameras/BIR_Fall_Cams.Rda"))


# Create activity kernels
fall_gps_kern<-gps2kernel(fall_gps)
fall_cam_kern<-cam2kern(fall_cam)

# Calculate overlap
FL_fall_gps_cam<-est_overlap(kernel1=fall_gps_kern[["gps_kernel"]],
                               kernel2=fall_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=fall_gps_kern[["gps_matrix"]])

res<-c("FL", "fall_GPS", "fall_Cam", 
       FL_fall_gps_cam[[1]], 
       FL_fall_gps_cam[[2]][1],
       FL_fall_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)


# 4) FL Winter GPS data to FL Winter Camera data
winter_gps<-readRDS(here("output/suntime_datasets/gps/BIRWinterGPS.Rda"))
winter_cam<-readRDS(here("output/suntime_datasets/cameras/BIR_Winter_Cams.Rda"))

# Create activity kernels
winter_gps_kern<-gps2kernel(winter_gps)

winter_cam_kern<-cam2kern(winter_cam)

# Calculate overlap
FL_winter_gps_cam<-est_overlap(kernel1=winter_gps_kern[["gps_kernel"]],
                               kernel2=winter_cam_kern,
                               bootCI=T,
                               k1="gps",
                               k2="cam", 
                               matrix1=winter_gps_kern[["gps_matrix"]])

res<-c("FL", "winter_GPS", "winter_Cam", 
       FL_winter_gps_cam[[1]], 
       FL_winter_gps_cam[[2]][1],
       FL_winter_gps_cam[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# Seasonal comparisons
# ** All kernels already made in the first section (#1-4)

# 5) spring-summer FL GPS
spring_summer<-est_overlap(kernel1=spring_gps_kern[["gps_kernel"]],
                           kernel2=summer_gps_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_gps_kern[["gps_matrix"]],
                           matrix2=summer_gps_kern[["gps_matrix"]])

res<-c("FL", "spring_gps", "summer_gps", 
       spring_summer[[1]], 
       spring_summer[[2]][1],
       spring_summer[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)



# 6) spring-fall FL GPS
spring_fall<-est_overlap(kernel1=spring_gps_kern[["gps_kernel"]],
                         kernel2=fall_gps_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=spring_gps_kern[["gps_matrix"]],
                         matrix2=fall_gps_kern[["gps_matrix"]])

res<-c("FL", "spring_gps", "fall_gps", 
       spring_fall[[1]], 
       spring_fall[[2]][1],
       spring_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 7) spring-winter FL GPS
spring_winter<-est_overlap(kernel1=spring_gps_kern[["gps_kernel"]],
                           kernel2=winter_gps_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=spring_gps_kern[["gps_matrix"]],
                           matrix2=winter_gps_kern[["gps_matrix"]])

res<-c("FL", "spring_gps", "winter_gps", 
       spring_winter[[1]], 
       spring_winter[[2]][1],
       spring_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 8) summer-fall FL GPS
summer_fall<-est_overlap(kernel1=summer_gps_kern[["gps_kernel"]],
                         kernel2=fall_gps_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=summer_gps_kern[["gps_matrix"]],
                         matrix2=fall_gps_kern[["gps_matrix"]])

res<-c("FL", "summer_gps", "fall_gps", 
       summer_fall[[1]], 
       summer_fall[[2]][1],
       summer_fall[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 9) summer-winter FL GPS
summer_winter<-est_overlap(kernel1=summer_gps_kern[["gps_kernel"]],
                           kernel2=winter_gps_kern[["gps_kernel"]],
                           bootCI=T,
                           k1="gps",
                           k2="gps", 
                           matrix1=summer_gps_kern[["gps_matrix"]],
                           matrix2=winter_gps_kern[["gps_matrix"]])

res<-c("FL", "summer_gps", "winter_gps", 
       summer_winter[[1]], 
       summer_winter[[2]][1],
       summer_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 10) fall-winter FL GPS
fall_winter<-est_overlap(kernel1=fall_gps_kern[["gps_kernel"]],
                         kernel2=winter_gps_kern[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=fall_gps_kern[["gps_matrix"]],
                         matrix2=winter_gps_kern[["gps_matrix"]])

res<-c("FL", "fall_gps", "winter_gps", 
       fall_winter[[1]], 
       fall_winter[[2]][1],
       fall_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)
###################################################################################################
# Sex comparisons
# 11) FL GPS spring M vs F
spring_female<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_SpringGPS_Females.csv"))
spring_male<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_SpringGPS_Males.csv"))

spring_female_kern<-gps2kernel(spring_female)
spring_male_kern<-gps2kernel(spring_male)

spring_sex<-est_overlap(kernel1=spring_female_kern[["gps_kernel"]],
                        kernel2=spring_male_kern[["gps_kernel"]],
                        bootCI=T,
                        k1="gps",
                        k2="gps", 
                        matrix1=spring_female_kern[["gps_matrix"]],
                        matrix2=spring_male_kern[["gps_matrix"]])

res<-c("FL", "spring_female_gps", "spring_male_gps", 
       spring_sex[[1]], 
       spring_sex[[2]][1],
       spring_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 12) FL GPS summer M vs F
summer_female<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_SummerGPS_Females.csv"))
summer_male<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_SummerGPS_Males.csv"))

summer_female_kern<-gps2kernel(summer_female)
summer_male_kern<-gps2kernel(summer_male)

summer_sex<-est_overlap(kernel1=summer_female_kern[["gps_kernel"]],
                        kernel2=summer_male_kern[["gps_kernel"]],
                        bootCI=T,
                        k1="gps",
                        k2="gps", 
                        matrix1=summer_female_kern[["gps_matrix"]],
                        matrix2=summer_male_kern[["gps_matrix"]])

res<-c("FL", "summer_female_gps", "summer_male_gps", 
       summer_sex[[1]], 
       summer_sex[[2]][1],
       summer_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 13) FL GPS fall M vs F
fall_female<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_FallGPS_Females.csv"))
fall_male<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_FallGPS_Males.csv"))

fall_female_kern<-gps2kernel(fall_female)
fall_male_kern<-gps2kernel(fall_male)

fall_sex<-est_overlap(kernel1=fall_female_kern[["gps_kernel"]],
                        kernel2=fall_male_kern[["gps_kernel"]],
                        bootCI=T,
                        k1="gps",
                        k2="gps", 
                        matrix1=fall_female_kern[["gps_matrix"]],
                        matrix2=fall_male_kern[["gps_matrix"]])

res<-c("FL", "fall_female_gps", "fall_male_gps", 
       fall_sex[[1]], 
       fall_sex[[2]][1],
       fall_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 14) FL GPS winter M vs F
winter_female<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_WinterGPS_Females.csv"))
winter_male<-pre_process_suntime_conversion(here("data/sex_comparisons/BIR_WinterGPS_Males.csv"))

winter_female_kern<-gps2kernel(winter_female)
winter_male_kern<-gps2kernel(winter_male)

winter_sex<-est_overlap(kernel1=winter_female_kern[["gps_kernel"]],
                        kernel2=winter_male_kern[["gps_kernel"]],
                        bootCI=T,
                        k1="gps",
                        k2="gps", 
                        matrix1=winter_female_kern[["gps_matrix"]],
                        matrix2=winter_male_kern[["gps_matrix"]])

res<-c("FL", "winter_female_gps", "winter_male_gps", 
       winter_sex[[1]], 
       winter_sex[[2]][1],
       winter_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)




###################################################################################################
###################################################################################################
##
# California
# 15) CA Spring GPS data to CA Spring Camera data
spring_gps<-readRDS(here("output/suntime_datasets/gps/TejonSpringGPS.Rda"))
spring_cam<-readRDS(here("output/suntime_datasets/cameras/Spring_15-16_Cams.Rda"))

# Create activity kernels
spring_kern<-gps2kernel(spring_gps)
spring_cam_kern<-cam2kern(spring_cam)

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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 16) CA Summer GPS data to CA Summer Camera data
summer_gps<-readRDS(here("output/suntime_datasets/gps/TejonSummerGPS.Rda"))
summer_cam<-readRDS(here("output/suntime_datasets/cameras/Summer_15-16_Cams.Rda"))

summer_kern<-gps2kernel(summer_gps)
summer_cam_kern<-cam2kern(summer_cam)

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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 17) CA Fall GPS data to CA Fall Camera data
fall_gps<-readRDS(here("output/suntime_datasets/gps/TejonFallGPS.Rda"))
fall_cam<-readRDS(here("output/suntime_datasets/cameras/Fall_15-16_Cams.Rda"))

fall_kern<-gps2kernel(fall_gps)
fall_cam_kern<-cam2kern(fall_cam)

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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 18) CA Winter GPS data to CA Winter Camera data
winter_gps<-readRDS(here("output/suntime_datasets/gps/TejonWinterGPS.Rda"))
winter_cam<-readRDS(here("output/suntime_datasets/cameras/Winter_15-17_Cams.Rda"))

winter_kern<-gps2kernel(winter_gps)
winter_cam_kern<-cam2kern(winter_cam)

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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)
###############################################################################################
# Seasonal comparisons
# 19) spring-summer CA GPS
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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 20) spring-fall CA GPS
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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 21) spring-winter CA GPS
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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 22) summer-fall CA GPS
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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 23) summer-winter CA GPS
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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)

# 24) fall-winter CA GPS

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

write_csv(as.data.frame(t(res)), here("output/all_suntimes_overlap_table.csv"), append = T)











































