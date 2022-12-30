# write out all activity kernels used in manuscript (with suntime)

library(here)
library(readr)
library(activity)
library(stringr)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

out_dir<-here("output/all_activity_kernels_with_suntime")

paths<-NA
# All paths are already preprocessed for suntime adjustment
# California datasets
#GPS
paths[1]<-here("output/suntime_datasets/gps/TejonSpringGPS.Rda")
paths[2]<-here("output/suntime_datasets/gps/TejonSummerGPS.Rda")
paths[3]<-here("output/suntime_datasets/gps/TejonFallGPS.Rda")
paths[4]<-here("output/suntime_datasets/gps/TejonWinterGPS.Rda")

# Florida datasets
#GPS
paths[5]<-here("output/suntime_datasets/gps/BIRSpringGPS.Rda")
paths[6]<-here("output/suntime_datasets/gps/BIRSummerGPS.Rda")
paths[7]<-here("output/suntime_datasets/gps/BIRFallGPS.Rda")
paths[8]<-here("output/suntime_datasets/gps/BIRWinterGPS.Rda")

for(i in 1:length(paths)){
  cat("Creating activity kernel for dataset", i, "out of", length(paths), "\n")
  tmp<-readRDS(paths[[i]])
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
  write_csv(as.data.frame(gps_mat), 
            paste0(out_dir,"/", stringr::str_sub(basename(paths[i]), 1, -5), "kernel.csv"))
}



######################################################################
# Florida sex-specific (not already saved as pre-processed)
other_paths<-NA
other_paths[1]<-here("data/sex_comparisons/BIR_SpringGPS_Females.csv")
other_paths[2]<-here("data/sex_comparisons/BIR_SpringGPS_Males.csv")
other_paths[3]<-here("data/sex_comparisons/BIR_SummerGPS_Females.csv")
other_paths[4]<-here("data/sex_comparisons/BIR_SummerGPS_Males.csv")
other_paths[5]<-here("data/sex_comparisons/BIR_FallGPS_Females.csv")
other_paths[6]<-here("data/sex_comparisons/BIR_FallGPS_Males.csv")
other_paths[7]<-here("data/sex_comparisons/BIR_WinterGPS_Females.csv")
other_paths[8]<-here("data/sex_comparisons/BIR_WinterGPS_Males.csv")

for(i in 1:length(paths)){
  cat("Creating activity kernel for dataset", i, "out of", length(paths), "\n")
  tmp<-pre_process_suntime_conversion(other_paths[[i]])
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
  write_csv(as.data.frame(gps_mat), paste(out_dir, basename(other_paths[i]), sep="/"))
}
  
  
