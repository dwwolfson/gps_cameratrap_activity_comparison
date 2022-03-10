
# Create all 4-panel plots

library(here)
library(ggplot2)
library(readr)
library(patchwork)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# FL methods
# 1) FL	Spring_GPS	Spring_Cam
db1<-boot_gps(here("output/activity_kernels/BIRSpringGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Spring_Cams.csv"))

spring<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                  plot_title = "Spring")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.91, CI=(0.89-0.93)')),
           size=6)

# 2) FL	summer_GPS	summer_Cam
db1<-boot_gps(here("output/activity_kernels/BIRSummerGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Summer_Cams.csv"))

summer<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                  plot_title = "Summer")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.93, CI=(0.90-0.94)')),
           size=6)

# 3) FL	fall_GPS	fall_Cam
db1<-boot_gps(here("output/activity_kernels/BIRFallGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Fall_Cams.csv"))

fall<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                plot_title = "Fall")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.90, CI=(0.85-0.93)')),
           size=6)
  
# 4) FL	winter_GPS	winter_Cam
db1<-boot_gps(here("output/activity_kernels/BIRWinterGPS.csv"))
db2<-read_csv(here("output/activity_kernels/BIR_Winter_Cams.csv"))

winter<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Camera", 
                  plot_title = "Winter")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.94, CI=(0.91-0.95)')),
           size=6)

fl_methods_comparison<-winter+fall+summer+spring+
  plot_annotation(title="Activity patterns at Buck Island Ranch, FL using GPS and camera traps",
                  theme=theme(plot.title=element_text(hjust = 0.5,
                                margin=margin(0,0,15,0),
                                size = 20,
                                face = "bold",
                                family = "serif")))


ggsave(filename = here("figures/multipanel_plots/fl_methods_comparison.tiff"),
       plot=fl_methods_comparison, compression="lzw")

###########
# Tejon methods
# 40) CA	Spring_GPS	Spring_Cam
db1<-boot_gps(here("output/activity_kernels/TejonSpringGPS.csv"))
db2<-read_csv(here("output/activity_kernels/Spring_15-16_Cams.csv"))

spring<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                    plot_title = "Spring")+
  annotate("text", x=12, y=0.45, 
           label=expression(paste(Delta,'=0.86, CI=(0.78-0.90)')),
           size=6)

# 41) CA	summer_GPS	summer_Cam
db1<-boot_gps(here("output/activity_kernels/TejonSummerGPS.csv"))
db2<-read_csv(here("output/activity_kernels/Summer_15-16_Cams.csv"))

summer<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                    plot_title = "Summer")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.86, CI=(0.78-0.91)')),
           size=6)

# 42) CA	fall_GPS	fall_Cam
db1<-boot_gps(here("output/activity_kernels/TejonFallGPS.csv"))         
db2<-read_csv(here("output/activity_kernels/Fall_15-16_Cams.csv"))

fall<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                    plot_title = "Fall")+
  annotate("text", x=12, y=0.4, 
           label=expression(paste(Delta,'=0.75, CI=(0.66-0.84)')),
           size=6)
    

# 43) CA	winter_GPS	winter_Cam
db1<-boot_gps(here("output/activity_kernels/TejonWinterGPS.csv"))     
db2<-read_csv(here("output/activity_kernels/Winter_15-17_Cams.csv"))

winter<-my_ggplot(db1, db2, lab1 = "GPS", lab2="Cams", 
                        plot_title = "Winter")+
          annotate("text", x=12, y=0.45, 
                   label=expression(paste(Delta,'=0.83, CI=(0.73-0.89)')),
                   size=6)

tejon_methods_comparison<-winter+fall+summer+spring+
              plot_annotation(title="Activity patterns at Tejon Ranch, CA using GPS and camera traps",
                          theme=theme(plot.title=element_text(hjust = 0.5,
                                                    margin=margin(0,0,15,0),
                                                    size = 20,
                                                    face = "bold",
                                                    family = "serif")))


ggsave(filename = here("figures/multipanel_plots/tejon_methods_comparison.tiff"),
       plot=tejon_methods_comparison, compression="lzw")

##########################
# Sex comparison for GPS at Florida


# 8) FL	winter_GPS_female	winter_gps_male

db1<-boot_gps(here("output/activity_kernels/BIR_WinterGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_WinterGPS_Males.csv"))

winter<-my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                  plot_title = "Winter")+
  annotate("text", x=12, y=0.45, 
           label=expression(paste(Delta,'=0.89, CI=(0.80-0.93)')),
           size=6)

# 5) FL	fall_GPS_female	fall_gps_male
db1<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_FallGPS_Males.csv"))

fall<-my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                              plot_title = "Fall")+
  annotate("text", x=12, y=0.45, 
           label=expression(paste(Delta,'=0.92, CI=(0.83-0.95)')),
           size=6)
       
# 7) FL	summer_GPS_female	summer_gps_male

db1<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SummerGPS_Males.csv"))

summer<-my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                      plot_title = "Summer")+
  annotate("text", x=12, y=0.45, 
           label=expression(paste(Delta,'=0.93, CI=(0.87-0.95)')),
           size=6)

# 6) FL	spring_GPS_female	spring_gps_male
db1<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Females.csv"))
db2<-boot_gps(here("output/activity_kernels/BIR_SpringGPS_Males.csv"))

spring<-my_ggplot(db1, db2, lab1 = "Female", lab2="Male", 
                                        plot_title = "Spring")+
  annotate("text", x=12, y=0.45, 
           label=expression(paste(Delta,'=0.92, CI=(0.87-0.95)')),
           size=6)

fl_sex_comparison<-winter+fall+summer+spring+
  plot_annotation(title="Activity patterns at Buck Island Ranch, FL for males and females",
                  theme=theme(plot.title=element_text(hjust = 0.5,
                                                      margin=margin(0,0,15,0),
                                                      size = 20,
                                                      face = "bold",
                                                      family = "serif")))


ggsave(filename = here("figures/multipanel_plots/fl_sex_comparison.tiff"),
       plot=fl_sex_comparison, compression="lzw")




