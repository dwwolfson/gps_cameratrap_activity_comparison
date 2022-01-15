# Function for testing activity kernels using Watson's two-sample test of homogeneity

# This function relies on other helper functions from the scripts 'pre_processing.R' 
# and 'create_activity_kernels.R' that are located in the functions folder. 

# Input are the raw activity csv files that serve as inputs to 'pre_processing.R'
# Output is a table of test statistics and p-values for each activity comparison

library(here)
library(circular)
library(overlap)
library(scales)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

full_watson_workflow<-function(path_to_dataset1,
                               path_to_dataset2,
                               db1_name=NA,
                               db2_name=NA,
                               data_type1=NA,
                               data_type2=NA,
                               site="FL",
                               suntime_conversion=F){
  results<-list()
  results[[1]]<-site
  results[[2]]<-db1_name
  results[[3]]<-db2_name
  results[[4]]<-suntime_conversion
  
  if(suntime_conversion==F){
    
      if(data_type1=="gps"){
      db1<-pre_process(path_to_dataset1)
      db1_kern<-gps2kernel(db1)
      }else if(data_type1=="cam"){
      db1_kern<-cam2kernel(path_to_dataset1)}
    
      if(data_type2=="gps"){
        db2<-pre_process(path_to_dataset2)
        db2_kern<-gps2kernel(db2)
      }else if(data_type2=="cam"){
        db2_kern<-cam2kernel(path_to_dataset2)}
    
     db1_rescale<-rescale(db1_kern[["gps_kernel"]], to=c(0,2*pi))
     db2_rescale<-rescale(db2_kern[["gps_kernel"]], to=c(0,2*pi))
    
      out<-watson.two.test(db1_rescale, db2_rescale)
  } # end of suntime = F loop
  
  if(suntime_conversion==T){
    # suntime conversion is only for gps datasets
    if(site=="FL"){
      
      if(data_type1=="gps"&data_type2=="gps"){
      
      # suntime defaults are for Florida timezone
      tz="America/New_York"
      db1<-pre_process_suntime_conversion(path_to_dataset1)
      db1_kern<-gps2kernel(db1)
      
      db2<-pre_process_suntime_conversion(path_to_dataset2)
      db2_kern<-gps2kernel(db2)
      
      db1_rescale<-rescale(db1_kern[["gps_kernel"]], to=c(0,2*pi))
      db2_rescale<-rescale(db2_kern[["gps_kernel"]], to=c(0,2*pi))
      
      out<-watson.two.test(db1_rescale, db2_rescale)
      }
      
      if(data_type1=="gps"&data_type2=="cam"){
        db1<-pre_process_suntime_conversion(path_to_dataset1)
        db1_kern<-gps2kernel(db1)
        
        db2_kern<-cam2kernel(path_to_dataset2)
        
        db1_rescale<-rescale(db1_kern[["gps_kernel"]], to=c(0,2*pi))
        db2_rescale<-rescale(db2_kern, to=c(0,2*pi))
        
        out<-watson.two.test(db1_rescale, db2_rescale)
      }
      
      if(data_type1=="cam"&data_type2=="gps"){
        db1_kern<-cam2kernel(path_to_dataset1)
        
        db2<-pre_process_suntime_conversion(path_to_dataset2)
        db2_kern<-gps2kernel(db2)
        
        db1_rescale<-rescale(db1_kern, to=c(0,2*pi))
        db2_rescale<-rescale(db2_kern[["gps_kernel"]], to=c(0,2*pi))
        
        out<-watson.two.test(db1_rescale, db2_rescale)
      }
    } # end of state loop
    
    if(site=="CA"){
      tz="America/Los_Angeles"
      
      if(data_type1=="gps"&data_type2=="gps"){
      db1<-pre_process_suntime_conversion(path_to_dataset1,
                                          tz=tz,
                                          site="CA")
      db1_kern<-gps2kernel(db1)
      
      db2<-pre_process_suntime_conversion(path_to_dataset2,
                                          tz=tz,
                                          site="CA")
      db2_kern<-gps2kernel(db2)
      
      db1_rescale<-rescale(db1_kern[["gps_kernel"]], to=c(0,2*pi))
      db2_rescale<-rescale(db2_kern[["gps_kernel"]], to=c(0,2*pi))
      
      out<-watson.two.test(db1_rescale, db2_rescale)
      }
      
      if(data_type1=="gps"&data_type2=="cam"){
        db1<-pre_process_suntime_conversion(path_to_dataset1,
                                            tz=tz,
                                            site="CA")
        db1_kern<-gps2kernel(db1)
        
        db2_kern<-cam2kernel(path_to_dataset2)
        
        db1_rescale<-rescale(db1_kern[["gps_kernel"]], to=c(0,2*pi))
        db2_rescale<-rescale(db2_kern, to=c(0,2*pi))
        
        out<-watson.two.test(db1_rescale, db2_rescale)
      }
      
      if(data_type1=="cam"&data_type2=="gps"){
        db1_kern<-cam2kernel(path_to_dataset1)
        
        db2<-pre_process_suntime_conversion(path_to_dataset2,
                                            tz=tz,
                                            site="CA")
        db2_kern<-gps2kernel(db2)
        
        db1_rescale<-rescale(db1_kern, to=c(0,2*pi))
        db2_rescale<-rescale(db2_kern[["gps_kernel"]], to=c(0,2*pi))
        
        out<-watson.two.test(db1_rescale, db2_rescale)
      }
    } #end of state loop
  } # end of suntime==T loop
  
  results[[5]]<-out[[1]] # watson test statistic
  results[[6]]<-out[[5]] # watson p value
  
  return(results)
}

















