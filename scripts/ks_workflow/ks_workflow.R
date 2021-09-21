# KS workflow

# This function relies on other helper functions from the scripts 'pre_processing.R' 
# and 'create_activity_kernels.R' that are located in the functions folder. 

# Input are the raw activity csv files that serve as inputs to 'pre_processing.R'
# Output is a table of Kolgorov-Smirnov test statistics and p-values for each activity comparison

# To simplify code, is there is a comparison between a gps dataset and a camera dataset, always put
# the gps as k1 and the camera as k2

library(here)
library(circular)
library(overlap)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))


full_ks_workflow<-function(path_to_dataset1,
                               path_to_dataset2,
                               db1_name=NA,
                               db2_name=NA,
                               k1=NA,
                               k2=NA,
                               site="FL",
                               suntime_conversion=F){
  results<-list()
  results[[1]]<-site
  results[[2]]<-db1_name
  results[[3]]<-db2_name
  results[[4]]<-suntime_conversion
  
  if(suntime_conversion==F){
    
    if(k1=="gps"& k2=="gps"){
      db1<-pre_process(path_to_dataset1)
      db1_kern<-gps2kernel(db1)
      
      db2<-pre_process(path_to_dataset2)
      db2_kern<-gps2kernel(db2)
      
      ks_out<-ks_test(db1_kern, 
                      db2_kern, 
                      k1="gps",
                      k2="gps",
                      matrix1=db1_kern[["gps_matrix"]],
                      matrix2=db2_kern[["gps_matrix"]])
    }
    if(k1=="gps"& k2=="cam"){
      db1<-pre_process(path_to_dataset1)
      db1_kern<-gps2kernel(db1)
      
      db2_kern<-cam2kernel(path_to_dataset2)
      
      ks_out<-ks_test(kernel1=db1_kern, 
                      kernel2=db2_kern,
                      k1="gps", 
                      k2="cam",
                      matrix1=db1_kern[["gps_matrix"]])
    }
  } # end of suntime = F loop
  
  if(suntime_conversion==T){
    # suntime conversion is only for gps datasets
    if(site=="FL"){
      
      if(k1=="gps"& k2=="gps"){
        
        # suntime defaults are for Florida timezone
        tz="America/New_York"
        db1<-pre_process_suntime_conversion(path_to_dataset1)
        db1_kern<-gps2kernel(db1)
        
        db2<-pre_process_suntime_conversion(path_to_dataset2)
        db2_kern<-gps2kernel(db2)
        
        ks_out<-ks_test(db1_kern, 
                        db2_kern, 
                        k1="gps",
                        k2="gps",
                        matrix1=db1_kern[["gps_matrix"]],
                        matrix2=db2_kern[["gps_matrix"]])
      }
      
      if(k1=="gps"& k2=="cam"){
        db1<-pre_process_suntime_conversion(path_to_dataset1)
        db1_kern<-gps2kernel(db1)
        
        db2_kern<-cam2kernel(path_to_dataset2)
        
        ks_out<-ks_test(db1_kern, 
                        db2_kern, 
                        k1="gps",
                        k2="cam",
                        matrix1=db1_kern[["gps_matrix"]])
      }
    } # end of state loop
    
    if(site=="CA"){
      tz="America/Los_Angeles"
      
      if(k1=="gps"&k2=="gps"){
        db1<-pre_process_suntime_conversion(path_to_dataset1,
                                            tz=tz,
                                            site="CA")
        db1_kern<-gps2kernel(db1)
        
        db2<-pre_process_suntime_conversion(path_to_dataset2,
                                            tz=tz,
                                            site="CA")
        db2_kern<-gps2kernel(db2)
        
        ks_out<-ks_test(db1_kern, 
                        db2_kern, 
                        k1="gps",
                        k2="gps",
                        matrix1=db1_kern[["gps_matrix"]],
                        matrix2=db2_kern[["gps_matrix"]])
      }
      
      if(k1=="gps"&k2=="cam"){
        db1<-pre_process_suntime_conversion(path_to_dataset1,
                                            tz=tz,
                                            site="CA")
        db1_kern<-gps2kernel(db1)
        
        db2_kern<-cam2kernel(path_to_dataset2)
        
        ks_out<-ks_test(db1_kern, 
                        db2_kern, 
                        k1="gps",
                        k2="cam",
                        matrix1=db1_kern[["gps_matrix"]])
      }
      
    } #end of state loop
  } # end of suntime==T loop
  
  results[[5]]<-ks_out[[1]] # ks test statistic
  results[[6]]<-ks_out[[2]] # ks p value
  
  return(results)
}
