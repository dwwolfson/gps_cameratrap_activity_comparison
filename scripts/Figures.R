# Produce figures for manuscript


library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))


# Tejon figure
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

# Activity kernels for camera datasets
spring_cam_kern<-cam2kernel(here("data/Tejon/Spring_15-16_Cams.csv"))
summer_cam_kern<-cam2kernel(here("data/Tejon/Summer_15-16_Cams.csv"))
fall_cam_kern<-cam2kernel(here("data/Tejon/Fall_15-16_Cams.csv"))
winter_cam_kern<-cam2kernel(here("data/Tejon/Winter_15-17_Cams.csv"))

###########################################
##GPS vs. Camera Figures, Tejon, Figure 3##
###########################################
tiff(here("figures/Tejon_GPS_Camera/TejonSpring.tiff"), width = 6, height = 6, units = 'in', res = 300)

my_overlapPlot(spring_cam_kern, spring_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=9)","Cameras (n=840)", "Overlap=0.86", "(0.78-0.90)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()


tiff(here("figures/Tejon_GPS_Camera/TejonSummer.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(summer_cam_kern, summer_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=12)", "Cameras (n=1,305)" , "Overlap=0.86", "(0.78-0.91)"), 
       lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()

tiff(here("figures/Tejon_GPS_Camera/TejonFall.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(fall_cam_kern, fall_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=14)", "Cameras (n=2,053)" , "Overlap=0.75", "(0.66-0.84)"), 
       lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/Tejon_GPS_Camera/TejonWinter.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(winter_cam_kern, winter_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=10)", "Cameras (n=1,090)" , "Overlap=0.83", "(0.73-0.89)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()
###############################################################################
###############################################################################
# GPS vs Cameras at Florida


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

# Cameras
spring_cam_kern<-cam2kernel(here("data/BIR_Spring_Cams.csv"))
summer_cam_kern<-cam2kernel(here("data/BIR_Summer_Cams.csv"))
fall_cam_kern<-cam2kernel(here("data/BIR_Fall_Cams.csv"))
winter_cam_kern<-cam2kernel(here("data/BIR_Winter_Cams.csv"))

tiff(here("figures/BIR_GPS_Camera/BIRSpring.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(spring_cam_kern, spring_kern$gps_kernel, main="Spring Wild Pig Activity Curves", 
            linetype = c(2, 1), linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", 
            olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=48)","Cameras (n=1,692)", "Overlap=0.91", "(0.89-0.93)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") 
dev.off()

tiff(here("figures/BIR_GPS_Camera/BIRSummer.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(summer_cam_kern, summer_kern$gps_kernel, main="Summer Wild Pig Activity Curves", 
            linetype = c(2, 1), linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", 
            olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=42)","Cameras (n=1,156)", "Overlap=0.93", "(0.90-0.94)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") 
dev.off()

tiff(here("figures/BIR_GPS_Camera/BIRFall.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(fall_cam_kern, fall_kern$gps_kernel, main="Fall Wild Pig Activity Curves Tejon", 
            linetype = c(2, 1), linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", 
            olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=25)","Cameras (n=1,804)", "Overlap=0.90", "(0.85-0.93)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/BIR_GPS_Camera/BIRWinter.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(winter_cam_kern, winter_kern$gps_kernel, main="Winter Wild Pig Activity Curves", 
            linetype = c(2, 1), linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity",
            olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("GPS (n=26)", "Cameras (n=1,429)", "Overlap=0.94", "(0.91-0.95)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") 
dev.off()

#####################################################################
#####################################################################

############################################
##Male vs. Female Figures, BIR, Appendix 3##
############################################

# Pre-process
fall_gps_female<-pre_process(here("data/sex_comparisons/BIR_FallGPS_Females.csv"))
fall_gps_male<-pre_process(here("data/sex_comparisons/BIR_FallGPS_Males.csv"))

spring_gps_female<-pre_process(here("data/sex_comparisons/BIR_SpringGPS_Females.csv"))
spring_gps_male<-pre_process(here("data/sex_comparisons/BIR_SpringGPS_Males.csv"))

summer_gps_female<-pre_process(here("data/sex_comparisons/BIR_SummerGPS_Females.csv"))
summer_gps_male<-pre_process(here("data/sex_comparisons/BIR_SummerGPS_Males.csv"))

winter_gps_female<-pre_process(here("data/sex_comparisons/BIR_WinterGPS_Females.csv"))
winter_gps_male<-pre_process(here("data/sex_comparisons/BIR_WinterGPS_Males.csv"))

# Create activity kernels
fall_female_kern<-gps2kernel(fall_gps_female)
fall_male_kern<-gps2kernel(fall_gps_male)

spr_female_kern<-gps2kernel(spring_gps_female)
spr_male_kern<-gps2kernel(spring_gps_male)

sum_female_kern<-gps2kernel(summer_gps_female)
sum_male_kern<-gps2kernel(summer_gps_male)

win_female_kern<-gps2kernel(winter_gps_female)
win_male_kern<-gps2kernel(winter_gps_male)

# Figures

tiff(here("figures/BIR_Male_Female/BIR_MaleFemale_Spring_Overlap.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(spr_female_kern$gps_kernel, spr_male_kern$gps_kernel, main="Spring Wild Pig Activity Curves Florida", linetype = c(2, 1), 
            linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("Males (n=25)", "Females (n=23)", "Overlap=0.92", "(0.87-0.95)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/BIR_Male_Female/BIR_MaleFemale_Summer_Overlap.tiff"), width = 6, height = 6, units = 'in', res = 300)
overlapPlot(sum_female_kern$gps_kernel, sum_male_kern$gps_kernel, main="Summer Wild Pig Activity Curves Florida", linetype = c(2, 1), 
            linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("Males (n=20)","Females (n=23)", "Overlap=0.93", "(0.87-0.95)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/BIR_Male_Female/BIR_MaleFemale_Fall_Overlap.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(fall_female_kern$gps_kernel, fall_male_kern$gps_kernel, main="Fall Wild Pig Activity Curves Florida", linetype = c(2, 1), 
            linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("Males (n=7)","Females (n=18)", "Overlap=0.92", "(0.83-0.95)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/BIR_Male_Female/BIR_MaleFemale_Winter_Overlap.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(win_female_kern$gps_kernel, win_male_kern$gps_kernel, main="Winter Wild Pig Activity Curves Florida", linetype = c(2, 1), 
            linecol = c("black", "black"),linewidth = c(2, 2), ylab="Activity", olapcol = "lightgrey",adjust=1, cex.lab=1.5, cex.axis=1.5, family = "serif")
legend("top", c("Males (n=17)","Females (n=9)" , "Overlap=0.89", "(0.80-0.93)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()




