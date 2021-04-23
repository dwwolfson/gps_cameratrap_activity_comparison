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
tiff(here("figures/TejonSpring.tiff"), width = 6, height = 6, units = 'in', res = 300)

my_overlapPlot(spring_cam_kern, spring_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("Cameras (n=840)", "GPS (n=9)", "Overlap=0.86", "(0.78-0.90)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()


tiff(here("figures/TejonSummer.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(summer_cam_kern, summer_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("Cameras (n=1,305)", "GPS (n=12)", "Overlap=0.86", "(0.78-0.91)"), 
       lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()

tiff(here("figures/TejonFall.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(fall_cam_kern, fall_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("Cameras (n=2,053)", "GPS (n=14)", "Overlap=0.75", "(0.66-0.84)"), 
       lty=c(1,2,0,0), col = c(1,1,0,0), bty="n")
dev.off()

tiff(here("figures/TejonWinter.tiff"), width = 6, height = 6, units = 'in', res = 300)
my_overlapPlot(winter_cam_kern, winter_kern$gps_kernel, 
               linetype = c(2, 1), linecol = c("black", "black"),
               linewidth = c(2, 2), ylab="Activity",
               olapcol = "lightgrey",adjust=1, cex.lab=1.5, 
               cex.axis=1.5, family = "serif")
legend("top", c("Cameras (n=1,090)", "GPS (n=10)", "Overlap=0.83", "(0.73-0.89)"), lty=c(1,2,0,0), col = c(1,1,0,0), bty="n") #creates density plot showing activity patterns
dev.off()
