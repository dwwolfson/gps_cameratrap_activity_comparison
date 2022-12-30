# Function to bootstrap GPS activity kernels in order to get confidence intervals for plotting
# for use in the script 'scripts/multiplanel_plots.R' and 'scripts/create all figures.R' in conjunction with 'scripts/functions/ggplot_custom_function.R'

library(here)
library(readr)


# import time in radians
time<-read_csv(here("data/time_radians.csv"))

boot_gps<-function(path_to_dataset, nrow=513, iter=1000){
  # dataset should be a data frame with each column representing the activity kernel of a single animal
  df<-read_csv(path_to_dataset)
  num_pigs<-ncol(df)
  
  boot_mat<-matrix(data=NA, nrow=nrow, ncol=iter)
  
  for(i in 1:iter){
    tmp<-df[,sample(ncol(df), size=num_pigs, replace=T)] 
    #resample a column at a time with replacement for a dataset the same size
    
    boot_mat[,i]<-t(apply(tmp, 1, mean))
  }
  
  out<-data.frame(x=time, y=NA, lcl=NA, ucl=NA)

  out$y<-as.vector(t(apply(boot_mat, 1, mean, na.rm=T)))
  out[,c("lcl","ucl")]<-t(apply(boot_mat, 1, quantile, probs=c(0.025, 0.975), na.rm=T))
  return(out)
}

