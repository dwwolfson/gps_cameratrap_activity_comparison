# Script to calculate overlap and CIs

library(here)
library(readr)

est_overlap<-function(kernel1, kernel2, bootCI=TRUE, k1="gps", k2="cam", matrix1, matrix2=NA){
  overlap_list<-list()
 
  overlap_list[[1]]<-sum(pmin(kernel1, kernel2))
  
  names(overlap_list[[1]])<-"coef_overlap"
  
  if(bootCI==TRUE && k1=="gps" && k2=="cam"){
    iter<-10000
    bs<-vector(length=iter)
    for(i in 1:iter) {
      bsCols <- sample(1:ncol(matrix1), ncol(matrix1), replace=TRUE)
      bsMat <- matrix1[, bsCols]
      bsAve <- rowMeans(bsMat)
      bs[i] <- sum(pmin(bsAve, kernel2))
    }
    
    overlap_list[[2]]<-stats::quantile(bs, probs=c(0.025, 0.975))
    names(overlap_list[[2]])<-c("CI lower", "CI upper")
  }
  
  if(bootCI==TRUE && k1=="gps" && k2=="gps"){
    iter<-1000
    bs<-vector(length=iter)
    for(i in 1:iter) {
      bs1Cols <- sample(1:ncol(matrix1), ncol(matrix1), replace=TRUE)
      bs1Mat <- matrix1[, bs1Cols]
      bs1Ave <- rowMeans(bs1Mat)
      bs2Cols <- sample(1:ncol(matrix2), ncol(matrix2), replace=TRUE)
      bs2Mat <- matrix2[, bs2Cols]
      bs2Ave <- rowMeans(bs2Mat)
      bs[i] <- sum(pmin(bs1Ave, bs2Ave))
  }
  
    overlap_list[[2]]<-stats::quantile(bs, probs=c(0.025, 0.975))
    names(overlap_list[[2]])<-c("CI lower", "CI upper")
  }
  return(overlap_list)
}


