# This script gives the entire code needed to calculate Kolgorov-Smirnov test and bootstrap for p-values
#on all activity comparisons. It pulls on several helper files for functions used.

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

source(here("scripts/ks_workflow/ks_workflow.R"))

#  There are a total of 49 comparisons to make: 
#    state, db1, db2
# 1) FL	Spring_GPS	Spring_Cam
# 2) FL	summer_GPS	summer_Cam
# 3) FL	fall_GPS	fall_Cam
# 4) FL	winter_GPS	winter_Cam
# 5) FL	fall_GPS_female	fall_gps_male
# 6) FL	spring_GPS_female	spring_gps_male
# 7) FL	summer_GPS_female	summer_gps_male
# 8) FL	winter_GPS_female	winter_gps_male
# 9) FL	spring_gps	summer_gps
# 10) FL	spring_gps	fall_gps
# 11) FL	spring_gps	winter_gps
# 12) FL	summer_gps	fall_gps
# 13) FL	summer_gps	winter_gps
# 14) FL	fall_gps	winter_gps
# 15) FL	female_spring_2015_gps	female_spring_2016_gps
# 16) FL	female_spring_2016_gps	female_spring_2017_gps
# 17) FL	female_spring_2015_gps	female_spring_2017_gps
# 18) FL	female_spring_2015_gps	female_spring_2016_gps
# 19) FL	female_spring_2015_gps	female_spring_2017_gps
# 20) FL	female_summer_2016_gps	female_summer_2017_gps
# 21) FL	female_fall_2016_gps	female_fall_2017_gps
# 22) FL	male_spring_2015_gps	male_spring_2016_gps
# 23) FL	male_spring_2016_gps	male_spring_2017_gps
# 24) FL	male_spring_2015_gps	male_spring_2017_gps
# 25) FL	male_summer_2015_gps	male_summer_2016_gps
# 26) FL	male_summer_2016_gps	male_summer_2017_gps
# 27) FL	male_summer_2015_gps	male_summer_2017_gps
# 28) FL	spring_gps_suntime	summer_gps_suntime
# 29) FL	spring_gps_suntime	fall_gps_suntime
# 30) FL	spring_gps_suntime	winter_gps_suntime
# 31) FL	summer_gps_suntime	fall_gps_suntime
# 32) FL	summer_gps_suntime	winter_gps_suntime
# 33) FL	fall_gps_suntime	winter_gps_suntime
# 34) CA	spring_gps	summer_gps
# 35) CA	spring_gps	fall_gps
# 36) CA	spring_gps	winter_gps
# 37) CA	summer_gps	fall_gps
# 38) CA	summer_gps	winter_gps
# 39) CA	fall_gps	winter_gps
# 40) CA	Spring_GPS	Spring_Cam
# 41) CA	summer_GPS	summer_Cam
# 42) CA	fall_GPS	fall_Cam
# 43) CA	winter_GPS	winter_Cam
# 44) CA	spring_gps_suntime	summer_gps_suntime
# 45) CA	spring_gps_suntime	fall_gps_suntime
# 46) CA	spring_gps_suntime	winter_gps_suntime
# 47) CA	summer_gps_suntime	fall_gps_suntime
# 48) CA	summer_gps_suntime	winter_gps_suntime
# 49) CA	fall_gps_suntime	winter_gps_suntime



# Create object to store test statistic numbers
ks_output<-data.frame(state=NA, 
                          db1=NA, 
                          db2=NA, 
                          suntime=NA,
                          ks_test_stat=NA, 
                          ks_p_val=NA)

# 1) FL	Spring_GPS	Spring_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIR_Spring_Cams.csv"),
                          db1_name = "FL_Spring_GPS",
                          db2_name = "FL_Spring_Cam",
                          k1 = "gps",
                          k2 = "cam")
ks_output[1,]<-unlist(tmp)
write_csv(ks_output, here("output/ks_table.csv"))

# 2) FL	summer_GPS	summer_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIR_Summer_GPS.csv"),
                          path_to_dataset2 = here("data/BIR_Summer_Cams.csv"),
                          db1_name = "FL_Summer_GPS",
                          db2_name = "FL_Summer_Cam",
                          k1 = "gps",
                          k2 = "cam")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 3) FL	fall_GPS	fall_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIR_Fall_GPS.csv"),
                          path_to_dataset2 = here("data/BIR_Fall_Cams.csv"),
                          db1_name = "FL_Fall_GPS",
                          db2_name = "FL_Fall_Cam",
                          k1 = "gps",
                          k2 = "cam")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 4) FL	winter_GPS	winter_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIR_Winter_GPS.csv"),
                          path_to_dataset2 = here("data/BIR_Winter_Cams.csv"),
                          db1_name = "FL_Winter_GPS",
                          db2_name = "FL_Winter_Cam",
                          k1 = "gps",
                          k2 = "cam")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 5) FL	fall_GPS_female	fall_gps_male
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sex_comparisons/BIR_FallGPS_Females.csv"),
                          path_to_dataset2 = here("data/sex_comparisons/BIR_FallGPS_Males.csv"),
                          db1_name = "FL_Fall_GPS_Female",
                          db2_name = "FL_Fall_GPS_Male",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 6) FL	spring_GPS_female	spring_gps_male
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sex_comparisons/BIR_SpringGPS_Females.csv"),
                          path_to_dataset2 = here("data/sex_comparisons/BIR_SpringGPS_Males.csv"),
                          db1_name = "FL_Spring_GPS_Female",
                          db2_name = "FL_Spring_GPS_Male",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 7) FL	summer_GPS_female	summer_gps_male
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sex_comparisons/BIR_SummerGPS_Females.csv"),
                          path_to_dataset2 = here("data/sex_comparisons/BIR_SummerGPS_Males.csv"),
                          db1_name = "FL_Summer_GPS_Female",
                          db2_name = "FL_Summer_GPS_Male",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 8) FL	winter_GPS_female	winter_gps_male
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sex_comparisons/BIR_WinterGPS_Females.csv"),
                          path_to_dataset2 = here("data/sex_comparisons/BIR_WinterGPS_Males.csv"),
                          db1_name = "FL_Winter_GPS_Female",
                          db2_name = "FL_Winter_GPS_Male",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 9) FL	spring_gps	summer_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRSummerGPS.csv"),
                          db1_name = "FL_Spring_GPS",
                          db2_name = "FL_Summer_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 10) FL	spring_gps	fall_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRFallGPS.csv"),
                          db1_name = "FL_Spring_GPS",
                          db2_name = "FL_Fall_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 11) FL	spring_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Spring_GPS",
                          db2_name = "FL_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 12) FL	summer_gps	fall_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSummerGPS.csv"),
                          path_to_dataset2 = here("data/BIRFallGPS.csv"),
                          db1_name = "FL_Summer_GPS",
                          db2_name = "FL_Fall_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 13) FL	summer_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSummerGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Summer_GPS",
                          db2_name = "FL_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 14) FL	fall_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRFallGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Fall_GPS",
                          db2_name = "FL_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 15) FL	female_spring_2015_gps	female_spring_2016_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Females2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Females2016.csv"),
                          db1_name = "FL_Spring_GPS_Female_2015",
                          db2_name = "FL_Spring_GPS_Female_2016",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 16) FL	female_spring_2016_gps	female_spring_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Females2016.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Females2017.csv"),
                          db1_name = "FL_Spring_GPS_Female_2016",
                          db2_name = "FL_Spring_GPS_Female_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 17) FL	female_spring_2015_gps	female_spring_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Females2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Females2017.csv"),
                          db1_name = "FL_Spring_GPS_Female_2015",
                          db2_name = "FL_Spring_GPS_Female_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 18) FL	female_summer_2015_gps	female_summer_2016_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Females2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Females2016.csv"),
                          db1_name = "FL_Summer_GPS_Female_2015",
                          db2_name = "FL_Summer_GPS_Female_2016",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 19) FL	female_summer_2015_gps	female_summer_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Females2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Females2017.csv"),
                          db1_name = "FL_Summer_GPS_Female_2015",
                          db2_name = "FL_Summer_GPS_Female_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 20) FL	female_summer_2016_gps	female_summer_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Females2016.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Females2017.csv"),
                          db1_name = "FL_Summer_GPS_Female_2016",
                          db2_name = "FL_Summer_GPS_Female_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 21) FL	female_fall_2016_gps	female_fall_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_FallGPS_Females2016.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_FallGPS_Females2017.csv"),
                          db1_name = "FL_Fall_GPS_Female_2016",
                          db2_name = "FL_Fall_GPS_Female_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 22) FL	male_spring_2015_gps	male_spring_2016_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Males2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Males2016.csv"),
                          db1_name = "FL_Spring_GPS_Male_2015",
                          db2_name = "FL_Spring_GPS_Male_2016",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 23) FL	male_spring_2016_gps	male_spring_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Males2016.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Males2017.csv"),
                          db1_name = "FL_Spring_GPS_Male_2016",
                          db2_name = "FL_Spring_GPS_Male_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 24) FL	male_spring_2015_gps	male_spring_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SpringGPS_Males2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SpringGPS_Males2017.csv"),
                          db1_name = "FL_Spring_GPS_Male_2015",
                          db2_name = "FL_Spring_GPS_Male_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 25) FL	male_summer_2015_gps	male_summer_2016_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Males2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Males2016.csv"),
                          db1_name = "FL_Summer_GPS_Male_2015",
                          db2_name = "FL_Summer_GPS_Male_2016",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 26) FL	male_summer_2016_gps	male_summer_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Males2016.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Males2017.csv"),
                          db1_name = "FL_Summer_GPS_Male_2016",
                          db2_name = "FL_Summer_GPS_Male_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 27) FL	male_summer_2015_gps	male_summer_2017_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/sexes_by_year/BIR_SummerGPS_Males2015.csv"),
                          path_to_dataset2 = here("data/sexes_by_year/BIR_SummerGPS_Males2017.csv"),
                          db1_name = "FL_Summer_GPS_Male_2015",
                          db2_name = "FL_Summer_GPS_Male_2017",
                          k1 = "gps",
                          k2 = "gps")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 28) FL	spring_gps_suntime	summer_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRSummerGPS.csv"),
                          db1_name = "FL_Spring_GPS_suntime",
                          db2_name = "FL_Summer_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 29) FL	spring_gps_suntime	fall_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRFallGPS.csv"),
                          db1_name = "FL_Spring_GPS_suntime",
                          db2_name = "FL_Fall_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 30) FL	spring_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSpringGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Spring_GPS_suntime",
                          db2_name = "FL_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 31) FL	summer_gps_suntime	fall_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSummerGPS.csv"),
                          path_to_dataset2 = here("data/BIRFallGPS.csv"),
                          db1_name = "FL_Summer_GPS_suntime",
                          db2_name = "FL_Fall_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 32) FL	summer_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRSummerGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Summer_GPS_suntime",
                          db2_name = "FL_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 33) FL	fall_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/BIRFallGPS.csv"),
                          path_to_dataset2 = here("data/BIRWinterGPS.csv"),
                          db1_name = "FL_Fall_GPS_suntime",
                          db2_name = "FL_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          suntime_conversion = T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 34) CA	spring_gps	summer_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          db1_name = "CA_Spring_GPS",
                          db2_name = "CA_Summer_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 35) CA	spring_gps	fall_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          db1_name = "CA_Spring_GPS",
                          db2_name = "CA_Fall_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 36) CA	spring_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Spring_GPS",
                          db2_name = "CA_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 37) CA	summer_gps	fall_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          db1_name = "CA_Summer_GPS",
                          db2_name = "CA_Fall_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 38) CA	summer_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Summer_GPS",
                          db2_name = "CA_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 39) CA	fall_gps	winter_gps
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Fall_GPS",
                          db2_name = "CA_Winter_GPS",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)


# 40) CA	Spring_GPS	Spring_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/Tejon/Spring_15-16_Cams.csv"),
                          db1_name = "CA_Spring_GPS",
                          db2_name = "CA_Spring_Cam",
                          k1 = "gps",
                          k2 = "cam",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 41) CA	summer_GPS	summer_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          path_to_dataset2 = here("data/Tejon/Summer_15-16_Cams.csv"),
                          db1_name = "CA_Summer_GPS",
                          db2_name = "CA_Summer_Cam",
                          k1 = "gps",
                          k2 = "cam",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 42) CA	fall_GPS	fall_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          path_to_dataset2 = here("data/Tejon/Fall_15-16_Cams.csv"),
                          db1_name = "CA_Fall_GPS",
                          db2_name = "CA_Fall_Cam",
                          k1 = "gps",
                          k2 = "cam",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 43) CA	winter_GPS	winter_Cam
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          path_to_dataset2 = here("data/Tejon/Winter_15-17_Cams.csv"),
                          db1_name = "CA_Winter_GPS",
                          db2_name = "CA_Winter_Cam",
                          k1 = "gps",
                          k2 = "cam",
                          site="CA")
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 44) CA	spring_gps_suntime	summer_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          db1_name = "CA_Spring_GPS_suntime",
                          db2_name = "CA_Summer_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)


# 45) CA	spring_gps_suntime	fall_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          db1_name = "CA_Spring_GPS_suntime",
                          db2_name = "CA_Fall_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 46) CA	spring_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSpringGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Spring_GPS_suntime",
                          db2_name = "CA_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 47) CA	summer_gps_suntime	fall_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          db1_name = "CA_Summer_GPS_suntime",
                          db2_name = "CA_Fall_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 48) CA	summer_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonSummerGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Summer_GPS_suntime",
                          db2_name = "CA_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)

# 49) CA	fall_gps_suntime	winter_gps_suntime
tmp<-full_ks_workflow(path_to_dataset1 = here("data/tejon_date_fixed/TejonFallGPS.csv"),
                          path_to_dataset2 = here("data/tejon_date_fixed/TejonWinterGPS.csv"),
                          db1_name = "CA_Fall_GPS_suntime",
                          db2_name = "CA_Winter_GPS_suntime",
                          k1 = "gps",
                          k2 = "gps",
                          site="CA",
                          suntime_conversion=T)
res<-unlist(tmp)
write_csv(as.data.frame(t(res)), here("output/ks_table.csv"), append=T)



