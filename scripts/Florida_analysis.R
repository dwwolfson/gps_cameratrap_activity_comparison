# Florida Analysis workflow

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# Create dataframe to store results
overlap_results<-data.frame(state=NA, db1=NA, db2=NA, coef_overlap=NA, CI_lower=NA, CI_upper=NA)

# Comparison 1
# FL Spring GPS data to FL Spring Camera data

# Pre-processing
spring_gps<-pre_process(here("data/BIRSpringGPS.csv"))

# Create activity kernels
spring_gps_kern<-gps2kernel(spring_gps)

spring_cam_kern<-cam2kernel(here("data/BIR_Spring_Cams.csv"))

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

write_csv(overlap_results, here("output/overlap_table.csv"))
##########################################################################
# Comparison 2
# FL Summer GPS to FL Summer Camera data

# Pre-processing
summer_gps<-pre_process(here("data/BIRSummerGPS.csv"))

# Create activity kernels
summer_gps_kern<-gps2kernel(summer_gps)

summer_cam_kern<-cam2kernel(here("data/BIR_Summer_Cams.csv"))

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

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)
##################
# Comparison 3
# FL fall GPS to FL fall Camera data

# Pre-processing
fall_gps<-pre_process(here("data/BIRFallGPS.csv"))

# Create activity kernels
fall_gps_kern<-gps2kernel(fall_gps)

fall_cam_kern<-cam2kernel(here("data/BIR_Fall_Cams.csv"))

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

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)
##################
# Comparison 4
# FL winter GPS to FL winter Camera data

# Pre-processing
winter_gps<-pre_process(here("data/BIRWinterGPS.csv"))

# Create activity kernels
winter_gps_kern<-gps2kernel(winter_gps)

winter_cam_kern<-cam2kernel(here("data/BIR_Winter_Cams.csv"))

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

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

###########
###########
# FL Sex and Season (pooled year) comparisons (GPS/GPS)
# 1 spring comparisons

# Pre-processing
fall_gps_female<-pre_process(here("data/sex_comparisons/BIR_FallGPS_Females.csv"))
fall_gps_male<-pre_process(here("data/sex_comparisons/BIR_FallGPS_Males.csv"))

# Create activity kernels
female_kern<-gps2kernel(fall_gps_female)
male_kern<-gps2kernel(fall_gps_male)

# Calculate overlap
FL_fall_gps_sex<-est_overlap(kernel1=female_kern[["gps_kernel"]],
                               kernel2=male_kern[["gps_kernel"]],
                               bootCI=T,
                               k1="gps",
                               k2="gps", 
                               matrix1=female_kern[["gps_matrix"]],
                               matrix2=male_kern[["gps_matrix"]])

res<-c("FL", "fall_GPS_female", "fall_gps_male", 
       FL_fall_gps_sex[[1]], 
       FL_fall_gps_sex[[2]][1],
       FL_fall_gps_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

##
##
# 2 Spring
# Pre-processing
spring_gps_female<-pre_process(here("data/sex_comparisons/BIR_SpringGPS_Females.csv"))
spring_gps_male<-pre_process(here("data/sex_comparisons/BIR_SpringGPS_Males.csv"))

# Create activity kernels
sp_female_kern<-gps2kernel(spring_gps_female)
sp_male_kern<-gps2kernel(spring_gps_male)

# Calculate overlap
FL_spring_gps_sex<-est_overlap(kernel1=sp_female_kern[["gps_kernel"]],
                             kernel2=sp_male_kern[["gps_kernel"]],
                             bootCI=T,
                             k1="gps",
                             k2="gps", 
                             matrix1=sp_female_kern[["gps_matrix"]],
                             matrix2=sp_male_kern[["gps_matrix"]])

res<-c("FL", "spring_GPS_female", "spring_gps_male", 
       FL_spring_gps_sex[[1]], 
       FL_spring_gps_sex[[2]][1],
       FL_spring_gps_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

##
##
# 3 summer
# Pre-processing
summer_gps_female<-pre_process(here("data/sex_comparisons/BIR_SummerGPS_Females.csv"))
summer_gps_male<-pre_process(here("data/sex_comparisons/BIR_SummerGPS_Males.csv"))

# Create activity kernels
sum_female_kern<-gps2kernel(summer_gps_female)
sum_male_kern<-gps2kernel(summer_gps_male)

# Calculate overlap
FL_summer_gps_sex<-est_overlap(kernel1=sum_female_kern[["gps_kernel"]],
                               kernel2=sum_male_kern[["gps_kernel"]],
                               bootCI=T,
                               k1="gps",
                               k2="gps", 
                               matrix1=sum_female_kern[["gps_matrix"]],
                               matrix2=sum_male_kern[["gps_matrix"]])

res<-c("FL", "summer_GPS_female", "summer_gps_male", 
       FL_summer_gps_sex[[1]], 
       FL_summer_gps_sex[[2]][1],
       FL_summer_gps_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

##
##
# 4 winter
# Pre-processing
winter_gps_female<-pre_process(here("data/sex_comparisons/BIR_WinterGPS_Females.csv"))
winter_gps_male<-pre_process(here("data/sex_comparisons/BIR_WinterGPS_Males.csv"))

# Create activity kernels
win_female_kern<-gps2kernel(winter_gps_female)
win_male_kern<-gps2kernel(winter_gps_male)

# Calculate overlap
FL_winter_gps_sex<-est_overlap(kernel1=win_female_kern[["gps_kernel"]],
                               kernel2=win_male_kern[["gps_kernel"]],
                               bootCI=T,
                               k1="gps",
                               k2="gps", 
                               matrix1=win_female_kern[["gps_matrix"]],
                               matrix2=win_male_kern[["gps_matrix"]])

res<-c("FL", "winter_GPS_female", "winter_gps_male", 
       FL_winter_gps_sex[[1]], 
       FL_winter_gps_sex[[2]][1],
       FL_winter_gps_sex[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)
##############################################################################
###############################################################################
# Pooling sex and year, compare seasons GPS/GPS at FL #######################
###############################################################################
# 1) spring-summer
# 2) spring-fall
# 3) spring-winter
# 4) summer-fall
# 5) summer-winter
# 6) fall-winter


# Pre-processing
spring<-pre_process(here("data/BIRSpringGPS.csv"))
summer<-pre_process(here("data/BIRSummerGPS.csv"))
fall<-pre_process(here("data/BIRFallGPS.csv"))
winter<-pre_process(here("data/BIRWinterGPS.csv"))

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

res<-c("FL", "spring_gps", "summer_gps", 
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

res<-c("FL", "spring_gps", "fall_gps", 
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

res<-c("FL", "spring_gps", "winter_gps", 
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

res<-c("FL", "summer_gps", "fall_gps", 
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

res<-c("FL", "summer_gps", "winter_gps", 
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

res<-c("FL", "fall_gps", "winter_gps", 
       fall_winter[[1]], 
       fall_winter[[2]][1],
       fall_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

################################################################################
###############################################################################
####  Compare seasons, sex, and year; no pooling; for Florida ################
##################################################################################
# Comparisons

# Females
# 1) spring 15 x 16
# 2) spring 16 x 17
# 3) spring 15 x 17
# 4) summer 15 x 16
# 5) summer 15 x 17
# 6) summer 16 x 17
# 7) fall 16 x 17
# 
# # Males
# 8) spring 15 x 16
# 9) spring 16 x 17
# 10) spring 15 x 17
# 11) summer 15 x 16
# 12) summer 16 x 17
# 13) summer 15 x 17

# Pre-process all files
female_spring15<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Females2015.csv"))
female_spring16<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Females2016.csv"))
female_spring17<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Females2017.csv"))
female_summer15<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Females2015.csv"))
female_summer16<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Females2016.csv"))
female_summer17<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Females2017.csv"))
female_fall16<-pre_process(here("data/sexes_by_year/BIR_FallGPS_Females2016.csv"))
female_fall17<-pre_process(here("data/sexes_by_year/BIR_FallGPS_Females2017.csv"))
male_spring15<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Males2015.csv"))
male_spring16<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Males2016.csv"))
male_spring17<-pre_process(here("data/sexes_by_year/BIR_SpringGPS_Males2017.csv"))
male_summer15<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Males2015.csv"))
male_summer16<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Males2016.csv"))
male_summer17<-pre_process(here("data/sexes_by_year/BIR_SummerGPS_Males2017.csv"))

# Create all activity kernels
fem_spr15<-gps2kernel(female_spring15)
fem_spr16<-gps2kernel(female_spring16)
fem_spr17<-gps2kernel(female_spring17)
fem_sum15<-gps2kernel(female_summer15)
fem_sum16<-gps2kernel(female_summer16)
fem_sum17<-gps2kernel(female_summer17)
fem_fall16<-gps2kernel(female_fall16)
fem_fall17<-gps2kernel(female_fall17)
male_spr15<-gps2kernel(male_spring15)
male_spr16<-gps2kernel(male_spring16)
male_spr17<-gps2kernel(male_spring17)
male_sum15<-gps2kernel(male_summer15)
male_sum16<-gps2kernel(male_summer16)
male_sum17<-gps2kernel(male_summer17)

# Females
# 1) spring 15 x 16
# Calculate overlap
female_spring15_16<-est_overlap(kernel1=fem_spr15[["gps_kernel"]],
                         kernel2=fem_spr16[["gps_kernel"]],
                         bootCI=T,
                         k1="gps",
                         k2="gps", 
                         matrix1=fem_spr15[["gps_matrix"]],
                         matrix2=fem_spr16[["gps_matrix"]])

res<-c("FL", "female_spring_2015_gps", "female_spring_2016_gps", 
       female_spring15_16[[1]], 
       female_spring15_16[[2]][1],
       female_spring15_16[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 2) spring 16 x 17
# Calculate overlap
female_spring16_17<-est_overlap(kernel1=fem_spr16[["gps_kernel"]],
                                kernel2=fem_spr17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_spr16[["gps_matrix"]],
                                matrix2=fem_spr17[["gps_matrix"]])

res<-c("FL", "female_spring_2016_gps", "female_spring_2017_gps", 
       female_spring16_17[[1]], 
       female_spring16_17[[2]][1],
       female_spring16_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 3) spring 15 x 17
# Calculate overlap
female_spring15_17<-est_overlap(kernel1=fem_spr15[["gps_kernel"]],
                                kernel2=fem_spr17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_spr15[["gps_matrix"]],
                                matrix2=fem_spr17[["gps_matrix"]])

res<-c("FL", "female_spring_2015_gps", "female_spring_2017_gps", 
       female_spring15_17[[1]], 
       female_spring15_17[[2]][1],
       female_spring15_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 4) summer 15 x 16
# Calculate overlap
female_summer15_16<-est_overlap(kernel1=fem_sum15[["gps_kernel"]],
                                kernel2=fem_sum16[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_sum15[["gps_matrix"]],
                                matrix2=fem_sum16[["gps_matrix"]])

res<-c("FL", "female_summer_2015_gps", "female_summer_2016_gps", 
       female_summer15_16[[1]], 
       female_summer15_16[[2]][1],
       female_summer15_16[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)


# 5) summer 15 x 17
# Calculate overlap
female_summer15_17<-est_overlap(kernel1=fem_sum15[["gps_kernel"]],
                                kernel2=fem_sum17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_sum15[["gps_matrix"]],
                                matrix2=fem_sum17[["gps_matrix"]])

res<-c("FL", "female_summer_2015_gps", "female_summer_2017_gps", 
       female_summer15_17[[1]], 
       female_summer15_17[[2]][1],
       female_summer15_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 6) summer 16 x 17
# Calculate overlap
female_summer16_17<-est_overlap(kernel1=fem_sum16[["gps_kernel"]],
                                kernel2=fem_sum17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_sum16[["gps_matrix"]],
                                matrix2=fem_sum17[["gps_matrix"]])

res<-c("FL", "female_summer_2016_gps", "female_summer_2017_gps", 
       female_summer16_17[[1]], 
       female_summer16_17[[2]][1],
       female_summer16_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 7) fall 16 x 17
# Calculate overlap
female_fall16_17<-est_overlap(kernel1=fem_fall16[["gps_kernel"]],
                                kernel2=fem_fall17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=fem_fall16[["gps_matrix"]],
                                matrix2=fem_fall17[["gps_matrix"]])

res<-c("FL", "female_fall_2016_gps", "female_fall_2017_gps", 
       female_fall16_17[[1]], 
       female_fall16_17[[2]][1],
       female_fall16_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)
# ############################
###############################
# # Males
# 8) spring 15 x 16
# Calculate overlap
male_spring15_16<-est_overlap(kernel1=male_spr15[["gps_kernel"]],
                                kernel2=male_spr16[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=male_spr15[["gps_matrix"]],
                                matrix2=male_spr16[["gps_matrix"]])

res<-c("FL", "male_spring_2015_gps", "male_spring_2016_gps", 
       male_spring15_16[[1]], 
       male_spring15_16[[2]][1],
       male_spring15_16[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 9) spring 16 x 17
# Calculate overlap
male_spring16_17<-est_overlap(kernel1=male_spr16[["gps_kernel"]],
                                kernel2=male_spr17[["gps_kernel"]],
                                bootCI=T,
                                k1="gps",
                                k2="gps", 
                                matrix1=male_spr16[["gps_matrix"]],
                                matrix2=male_spr17[["gps_matrix"]])

res<-c("FL", "male_spring_2016_gps", "male_spring_2017_gps", 
       male_spring16_17[[1]], 
       male_spring16_17[[2]][1],
       male_spring16_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 10) spring 15 x 17
# Calculate overlap
male_spring15_17<-est_overlap(kernel1=male_spr15[["gps_kernel"]],
                              kernel2=male_spr17[["gps_kernel"]],
                              bootCI=T,
                              k1="gps",
                              k2="gps", 
                              matrix1=male_spr15[["gps_matrix"]],
                              matrix2=male_spr17[["gps_matrix"]])

res<-c("FL", "male_spring_2015_gps", "male_spring_2017_gps", 
       male_spring15_17[[1]], 
       male_spring15_17[[2]][1],
       male_spring15_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 11) summer 15 x 16
# Calculate overlap
male_summer15_16<-est_overlap(kernel1=male_sum15[["gps_kernel"]],
                              kernel2=male_sum16[["gps_kernel"]],
                              bootCI=T,
                              k1="gps",
                              k2="gps", 
                              matrix1=male_sum15[["gps_matrix"]],
                              matrix2=male_sum16[["gps_matrix"]])

res<-c("FL", "male_summer_2015_gps", "male_summer_2016_gps", 
       male_summer15_16[[1]], 
       male_summer15_16[[2]][1],
       male_summer15_16[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 12) summer 16 x 17
# Calculate overlap
male_summer16_17<-est_overlap(kernel1=male_sum16[["gps_kernel"]],
                              kernel2=male_sum17[["gps_kernel"]],
                              bootCI=T,
                              k1="gps",
                              k2="gps", 
                              matrix1=male_sum16[["gps_matrix"]],
                              matrix2=male_sum17[["gps_matrix"]])

res<-c("FL", "male_summer_2016_gps", "male_summer_2017_gps", 
       male_summer16_17[[1]], 
       male_summer16_17[[2]][1],
       male_summer16_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

# 13) summer 15 x 17
# Calculate overlap
male_summer15_17<-est_overlap(kernel1=male_sum15[["gps_kernel"]],
                              kernel2=male_sum17[["gps_kernel"]],
                              bootCI=T,
                              k1="gps",
                              k2="gps", 
                              matrix1=male_sum15[["gps_matrix"]],
                              matrix2=male_sum17[["gps_matrix"]])

res<-c("FL", "male_summer_2015_gps", "male_summer_2017_gps", 
       male_summer15_17[[1]], 
       male_summer15_17[[2]][1],
       male_summer15_17[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)

#########################################################################
############################################################################
# Convert to suntime for FL seasonal comparisons pooling years and sexes ###
#########################################################################

# To go from clocktime to suntime you need:
# 1) vector of times in radians from 0-2pi
# 2) dates in POSIXct format with time zone specified
# 3) coordinates as a SpatialPoints object; or a single point for study area (must be in WGS84)

# 1) spring-summer
# 2) spring-fall
# 3) spring-winter
# 4) summer-fall
# 5) summer-winter
# 6) fall-winter



# Pre-processing
spring<-pre_process_suntime_conversion(here("data/BIRSpringGPS.csv"))
summer<-pre_process_suntime_conversion(here("data/BIRSummerGPS.csv"))
fall<-pre_process_suntime_conversion(here("data/BIRFallGPS.csv"))
winter<-pre_process_suntime_conversion(here("data/BIRWinterGPS.csv"))

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

res<-c("FL", "spring_gps_suntime", "summer_gps_suntime", 
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

res<-c("FL", "spring_gps_suntime", "fall_gps_suntime", 
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

res<-c("FL", "spring_gps_suntime", "winter_gps_suntime", 
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

res<-c("FL", "summer_gps_suntime", "fall_gps_suntime", 
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

res<-c("FL", "summer_gps_suntime", "winter_gps_suntime", 
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

res<-c("FL", "fall_gps_suntime", "winter_gps_suntime", 
       fall_winter[[1]], 
       fall_winter[[2]][1],
       fall_winter[[2]][2])

write_csv(as.data.frame(t(res)), here("output/overlap_table.csv"), append = T)


