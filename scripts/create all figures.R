# rerun all florida suntime-adjusted


# Create all figures

library(here)
library(ggplot2)
library(readr)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# figure out how to have nice legends to show whether gps or camera and 
# to distinguish each of the two datasets

# where I'm saving them
out_dir<-here("figures/with_CIs")

#  There are a total of 49 comparisons to make: 
#    state, db1, db2
# 1) FL	Spring_GPS	Spring_Cam
db1<-boot_gps(here("output/activity_kernels/BIRSpringGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Spring_Cams.csv"))

ggsave(file="FL_spring_gps_cam.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", plot_title = "Florida Spring GPS x Camera"), 
       path=out_dir, compression="lzw")

# 2) FL	summer_GPS	summer_Cam
db1<-boot_gps(here("output/activity_kernels/BIRSummerGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Summer_Cams.csv"))

ggsave(file="FL_summer_gps_cam.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                                                     plot_title = "Florida Summer GPS x Camera"), 
          path=out_dir, compression="lzw")


# 3) FL	fall_GPS	fall_Cam
db1<-boot_gps(here("output/activity_kernels/BIRFallGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Fall_Cams.csv"))

ggsave(file="FL_fall_gps_cam.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                                                     plot_title = "Florida Fall GPS x Camera"), 
       path=out_dir, compression="lzw")

# 4) FL	winter_GPS	winter_Cam
db1<-boot_gps(here("output/activity_kernels/BIRWinterGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Winter_Cams.csv"))

ggsave(file="FL_winter_gps_cam.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                                                     plot_title = "Florida Winter GPS x Camera"), 
       path=out_dir, compression="lzw")

# 5) FL	fall_GPS_female	fall_gps_male
db1<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Males.csv"))

ggsave(file="FL_Fall_GPS_sex.tiff", plot=my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                                     plot_title = "Florida Fall GPS Male x Female"), 
       path=out_dir, compression="lzw")

# 6) FL	spring_GPS_female	spring_gps_male
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males.csv"))

ggsave(file="FL_Spring_GPS_sex.tiff", plot=my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                                   plot_title = "Florida Spring GPS Male x Female"), 
       path=out_dir, compression="lzw")

# 7) FL	summer_GPS_female	summer_gps_male

db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males.csv"))

ggsave(file="FL_Summer_GPS_sex.tiff", plot=my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                                   plot_title = "Florida Summer GPS Male x Female"), 
       path=out_dir, compression="lzw")

# 8) FL	winter_GPS_female	winter_gps_male

db1<-boot_gps(here("output/activity_kernels/BIR_WinterGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_WinterGPS_Males.csv"))

ggsave(file="FL_Winter_GPS_sex.tiff", plot=my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                                     plot_title = "Florida Winter GPS Male x Female"), 
       path=out_dir, compression="lzw")

# 9) FL	spring_gps	summer_gps
db1<-boot_gps(here("output/activity_kernels/BIRSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRSummerGPS.csv"))

ggsave(file="FL_GPS_spring_summer.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Summer", 
                                                     plot_title = "Florida GPS Spring x Summer"), 
       path=out_dir, compression="lzw")

# 10) FL	spring_gps	fall_gps
db1<-boot_gps(here("output/activity_kernels/BIRSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRFallGPS.csv"))

ggsave(file="FL_GPS_spring_fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Fall", 
                                                        plot_title = "Florida GPS Spring x Fall"), 
       path=out_dir, compression="lzw")

# 11) FL	spring_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/BIRSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_spring_winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Winter", 
                                                        plot_title = "Florida GPS Spring x Winter"), 
       path=out_dir, compression="lzw")

# 12) FL	summer_gps	fall_gps
db1<-boot_gps(here("output/activity_kernels/BIRSummerGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRFallGPS.csv"))

ggsave(file="FL_GPS_summer_fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Fall", 
                                                        plot_title = "Florida GPS Summer x Fall"), 
       path=out_dir, compression="lzw")

# 13) FL	summer_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/BIRSummerGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_summer_winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Winter", 
                                                      plot_title = "Florida GPS Summer x Winter"), 
       path=out_dir, compression="lzw")

# 14) FL	fall_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/BIRFallGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_fall_winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Fall", lab2="Winter", 
                                                      plot_title = "Florida GPS Fall x Winter"), 
       path=out_dir, compression="lzw")

# 15) FL	female_spring_2015_gps	female_spring_2016_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2016.csv"))

ggsave(file="FL_Female_Spring_GPS_2015-2016.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2016", 
                                                      plot_title = "Florida Female Spring GPS 2015 x 2016"), 
       path=out_dir, compression="lzw")

# 16) FL	female_spring_2016_gps	female_spring_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2016.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2017.csv"))

ggsave(file="FL_Female_Spring_GPS_2016-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2016", lab2="2017", 
                                                           plot_title = "Florida Female Spring GPS 2016 x 2017"), 
       path=out_dir, compression="lzw")

# 17) FL	female_spring_2015_gps	female_spring_2017_gps

db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females2017.csv"))

ggsave(file="FL_Female_Spring_GPS_2015-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2017", 
                                                           plot_title = "Florida Female Spring GPS 2015 x 2017"), 
       path=out_dir, compression="lzw")
# 18) FL	female_summer_2015_gps	female_summer_2016_gps

db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2016.csv"))

ggsave(file="FL_Female_Summer_GPS_2015-2016.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2016", 
                                                                  plot_title = "Florida Female Summer GPS 2015 x 2016"), 
       path=out_dir, compression="lzw")
# 19) FL	female_summer_2015_gps	female_summer_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2017.csv"))

ggsave(file="FL_Female_Summer_GPS_2015-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2017", 
                                                                  plot_title = "Florida Female Summer GPS 2015 x 2017"), 
       path=out_dir, compression="lzw")

# 20) FL	female_summer_2016_gps	female_summer_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2016.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females2017.csv"))

ggsave(file="FL_Female_Summer_GPS_2016-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2016", lab2="2017", 
                                                                  plot_title = "Florida Female Summer GPS 2016 x 2017"), 
       path=out_dir, compression="lzw")
# 21) FL	female_fall_2016_gps	female_fall_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Females2016.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Females2017.csv"))

ggsave(file="FL_Female_Fall_GPS_2016-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2016", lab2="2017", 
                                                                  plot_title = "Florida Female Fall GPS 2016 x 2017"), 
       path=out_dir, compression="lzw")
# 22) FL	male_spring_2015_gps	male_spring_2016_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2016.csv"))

ggsave(file="FL_Male_Spring_GPS_2015-2016.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2016", 
                                                                  plot_title = "Florida Male Spring GPS 2015 x 2016"), 
       path=out_dir, compression="lzw")
# 23) FL	male_spring_2016_gps	male_spring_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2016.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2017.csv"))

ggsave(file="FL_Male_Spring_GPS_2016-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2016", lab2="2017", 
                                                                plot_title = "Florida Male Spring GPS 2016 x 2017"), 
       path=out_dir, compression="lzw")
# 24) FL	male_spring_2015_gps	male_spring_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males2017.csv"))

ggsave(file="FL_Male_Spring_GPS_2015-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2017", 
                                                                plot_title = "Florida Male Spring GPS 2015 x 2017"), 
       path=out_dir, compression="lzw")
# 25) FL	male_summer_2015_gps	male_summer_2016_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2016.csv"))

ggsave(file="FL_Male_Summer_GPS_2015-2016.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2016", 
                                                                  plot_title = "Florida Female Summer GPS 2015 x 2016"), 
       path=out_dir, compression="lzw")
# 26) FL	male_summer_2016_gps	male_summer_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2016.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2017.csv"))

ggsave(file="FL_Male_Summer_GPS_2016-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2016", lab2="2017", 
                                                                plot_title = "Florida Female Summer GPS 2016 x 2017"), 
       path=out_dir, compression="lzw")
# 27) FL	male_summer_2015_gps	male_summer_2017_gps
db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2015.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males2017.csv"))

ggsave(file="FL_Male_Summer_GPS_2015-2017.tiff", plot=my_ggplot(db1, db2, lab1 = "2015", lab2="2017", 
                                                                plot_title = "Florida Female Summer GPS 2015 x 2017"), 
       path=out_dir, compression="lzw")

# 28) FL	spring_gps_suntime	summer_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSummerGPS.csv"))

ggsave(file="FL_GPS_suntime_Spring_Summer.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Summer", 
                                                                plot_title = "Florida suntime GPS Spring x Summer"), 
       path=out_dir, compression="lzw")

# 29) FL	spring_gps_suntime	fall_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRFallGPS.csv"))

ggsave(file="FL_GPS_suntime_Spring_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Fall", 
                                                                plot_title = "Florida suntime GPS Spring x Fall"), 
       path=out_dir, compression="lzw")

# 30) FL	spring_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_suntime_Spring_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Winter", 
                                                                plot_title = "Florida suntime GPS Spring x Winter"), 
       path=out_dir, compression="lzw")

# 31) FL	summer_gps_suntime	fall_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSummerGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRFallGPS.csv"))

ggsave(file="FL_GPS_suntime_Summer_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Fall", 
                                                                plot_title = "Florida suntime GPS Summer x Fall"), 
       path=out_dir, compression="lzw")

# 32) FL	summer_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRSummerGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_suntime_Summer_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Winter", 
                                                                plot_title = "Florida suntime GPS Summer x Winter"), 
       path=out_dir, compression="lzw")

# 33) FL	fall_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRFallGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/BIRWinterGPS.csv"))

ggsave(file="FL_GPS_suntime_Fall_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Fall", lab2="Winter", 
                                                                plot_title = "Florida suntime GPS Fall x Winter"), 
       path=out_dir, compression="lzw")

# 34) CA	spring_gps	summer_gps
db1<-boot_gps(here("output/activity_kernels/TejonSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonSummerGPS.csv"))

ggsave(file="CA_GPS_Spring_Summer.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Summer", 
                                                                plot_title = "Tejon GPS Spring x Summer"), 
       path=out_dir, compression="lzw")

# 35) CA	spring_gps	fall_gps
db1<-boot_gps(here("output/activity_kernels/TejonSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonFallGPS.csv"))

ggsave(file="CA_GPS_Spring_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Fall", 
                                                        plot_title = "Tejon GPS Spring x Fall"), 
       path=out_dir, compression="lzw")

# 36) CA	spring_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/TejonSpringGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_Spring_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Winter", 
                                                        plot_title = "Tejon GPS Spring x Winter"), 
       path=out_dir, compression="lzw")

# 37) CA	summer_gps	fall_gps
db1<-boot_gps(here("output/activity_kernels/TejonSummerGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonFallGPS.csv"))

ggsave(file="CA_GPS_Summer_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Fall", 
                                                        plot_title = "Tejon GPS Summer x Fall"), 
       path=out_dir, compression="lzw")
# 38) CA	summer_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/TejonSummerGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_Summer_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Winter", 
                                                      plot_title = "Tejon GPS Summer x Winter"), 
       path=out_dir, compression="lzw")

# 39) CA	fall_gps	winter_gps
db1<-boot_gps(here("output/activity_kernels/TejonFallGPS.csv"))
db2<-boot_gps(here("output/activity_kernels/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_Fall_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Fall", lab2="Winter", 
                                                      plot_title = "Tejon GPS Fall x Winter"), 
       path=out_dir, compression="lzw")

# 40) CA	Spring_GPS	Spring_Cam
db1<-boot_gps(here("output/activity_kernels/TejonSpringGPS.csv"))
db2<-read_csv(here("output/activity_kernels/Spring_15-16_Cams.csv"))

ggsave(file="CA_Spring_GPS_Cams.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                                                      plot_title = "Tejon Spring GPS x Cams"), 
       path=out_dir, compression="lzw")
# 41) CA	summer_GPS	summer_Cam
db1<-boot_gps(here("output/activity_kernels/TejonSummerGPS.csv"))
db2<-read_csv(here("output/activity_kernels/Summer_15-16_Cams.csv"))

ggsave(file="CA_Summer_GPS_Cams.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                                                      plot_title = "Tejon Summer GPS x Cams"), 
       path=out_dir, compression="lzw")

# 42) CA	fall_GPS	fall_Cam
db1<-boot_gps(here("output/activity_kernels/TejonFallGPS.csv"))         # is this right?
db2<-read_csv(here("output/activity_kernels/Fall_15-16_Cams.csv"))

ggsave(file="CA_Fall_GPS_Cams.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                                                      plot_title = "Tejon Fall GPS x Cams"), 
       path=out_dir, compression="lzw")

# 43) CA	winter_GPS	winter_Cam
db1<-boot_gps(here("output/activity_kernels/TejonWinterGPS.csv"))     
db2<-read_csv(here("output/activity_kernels/Winter_15-17_Cams.csv"))

ggsave(file="CA_Winter_GPS_Cams.tiff", plot=my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                                                      plot_title = "Tejon Winter GPS x Cams"), 
       path=out_dir, compression="lzw")

# 44) CA	spring_gps_suntime	summer_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSummerGPS.csv"))

ggsave(file="CA_GPS_suntime_Spring_Summer.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Summer", 
                                                      plot_title = "Tejon suntime GPS Spring x Summer"), 
       path=out_dir, compression="lzw")

# 45) CA	spring_gps_suntime	fall_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonFallGPS.csv"))

ggsave(file="CA_GPS_suntime_Spring_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Fall", 
                                                                plot_title = "Tejon suntime GPS Spring x Fall"), 
       path=out_dir, compression="lzw")

# 46) CA	spring_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSpringGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_suntime_Spring_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Spring", lab2="Winter", 
                                                                plot_title = "Tejon suntime GPS Spring x Winter"), 
       path=out_dir, compression="lzw")

# 47) CA	summer_gps_suntime	fall_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSummerGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonFallGPS.csv"))

ggsave(file="CA_GPS_suntime_Summer_Fall.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Fall", 
                                                                plot_title = "Tejon suntime GPS Summer x Fall"), 
       path=out_dir, compression="lzw")
# 48) CA	summer_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonSummerGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_suntime_Summer_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Summer", lab2="Winter", 
                                                                plot_title = "Tejon suntime GPS Summer x Winter"), 
       path=out_dir, compression="lzw")

# 49) CA	fall_gps_suntime	winter_gps_suntime
db1<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonFallGPS.csv"))     
db2<-boot_gps(here("output/activity_kernels/suntime_adjusted/TejonWinterGPS.csv"))

ggsave(file="CA_GPS_suntime_Fall_Winter.tiff", plot=my_ggplot(db1, db2, lab1 = "Fall", lab2="Winter", 
                                                                plot_title = "Tejon suntime GPS Fall x Winter"), 
       path=out_dir, compression="lzw")
