# Function for overlap activity kernel and comparison
# Input is the list that is created by the pre-processing.R script 
# Output is a normalized 255-value vector of the averaged pig gps activity

library(circular)
library(CircStats)
library(overlap)

gps2kernel<-function(gps_list){
  ptm<-proc.time()
  
  out<-list(NA, NA)
  names(out)<-c("gps_matrix", "gps_kernel")

num_pigs<-length(gps_list)
  
# create a matrix to store the activity info for each pig
pigMat<-matrix(data = NA, nrow = 256, ncol = num_pigs)

    
### Step 1
# now fit an activity density curve for each pig
for(i in 1:num_pigs){
  tmp_dens<-densityPlot(gps_list[[i]], xscale=1, n.grid=256, extend=NULL)
  pigMat[,i]<-tmp_dens$y
  cat("Creating activity kernel for pig", i, "out of", num_pigs, "\n")
}


### Step 2
# The first and last rows both refer to midnight: needed for plotting but otherwise leads to double counting. 
# Discard one of them, last is easiest:
pigMat <- pigMat[1:255, ]

#That messes up the area under the curve, but we need to fix the columns to add to 1 for the overlap calculation, so do that now:
pigMat <- sweep(pigMat, 2, colSums(pigMat), "/")
colSums(pigMat)  # should all be 1.
out[[1]]<-pigMat

### Step 3
# Get an "average" activity curve with all pigs equally weighted 
pigAve <- rowMeans(pigMat)
#This is a length 255 vector which sums to 1.
out[[2]]<-pigAve

time_minutes<-(proc.time()-ptm)/60
time_minutes<-round(time_minutes[["elapsed"]], 1)
cat("Creating activity kernels for this gps dataset took", time_minutes, "minutes")

return(out)
}




# If we are comparing camera datasets, use this function to get a vector to use from the activity kernel
cam2kernel<-function(path_to_cam){
  df<-read_csv(path_to_cam, col_types = cols())
  
  # Convert camera data to a vector summing to 1 in the same way as steps 1-3
  cam_dens<-densityPlot(df$timeRad, xscale=1, n.grid = 256, extend=NULL)
  camVec<-cam_dens$y
  camVec<-camVec[1:255]
  
  #normalize to sum to 1
  camVec<-camVec/sum(camVec)
  return(camVec)
}

# If using the above function but importing a csv 
# (that was already preprocessed to suntime) instead of a path to a csv.
cam2kern<-function(df){
  # Convert camera data to a vector summing to 1 in the same way as steps 1-3
  cam_dens<-densityPlot(df$timeRad, xscale=1, n.grid = 256, extend=NULL)
  camVec<-cam_dens$y
  camVec<-camVec[1:255]
  
  #normalize to sum to 1
  camVec<-camVec/sum(camVec)
  return(camVec)
  
}