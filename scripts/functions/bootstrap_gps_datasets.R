# Function to bootstrap GPS activity kernels for mean and CIs by dataset

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
  
}
# 
# # Convert from radians to hours 
# out$hr<-out$x*(24/(2*pi))
# 
# # Plot
# ggplot()+
#    geom_line(aes(out$hr, out$y))+
#   scale_x_continuous(limits = c(0,24), expand = c(0, 0))+
#    geom_ribbon(aes(out$hr, ymin=out$lcl, ymax=out$ucl), alpha=0.5, fill="blue")+
#   theme_bw()

