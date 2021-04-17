# Analysis workflow

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# Create dataframe to store results
overlap_results<-data.frame(state=NA, db1=NA, db2=NA, coef_overlap=NA, CI_lower=NA, CI_upper=NA)

# Comparison 1
# FL Spring GPS data to FL Spring Camera data
ptm<-proc.time()
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

time_minutes<-(proc.time()-ptm)/60
time_minutes<-round(time_minutes[["elapsed"]], 1)
cat("This comparison analysis took", time_minutes, "minutes")