# Script to calculate Kolgorov-Smirnov test statistic between two activity kernels

ks_test<-function(kernel1, kernel2, bootCI=TRUE, k1, k2, matrix1, matrix2){
  ks_list<-list()
  
  if(bootCI==TRUE && k1=="gps" && k2=="cam"){
    #calculate test statistic
    ks_test_stat<-max(abs(cumsum(kernel1[["gps_kernel"]])-cumsum(kernel2)))
    ks_list[[1]]<-ks_test_stat
    
    iter<-10000
    bs<-vector(length=iter)
    for(i in 1:iter) {
      bsCols <- sample(1:ncol(matrix1), ncol(matrix1), replace=TRUE)
      bsMat <- matrix1[, bsCols]
      bsAve <- rowMeans(bsMat)
      bs[i] <- max(abs(cumsum(bsAve)-cumsum(kernel2)))
    }
    
      greater_vals<-bs[bs>ks_test_stat]
      ks_list[[2]]<-length(greater_vals)/iter #p-value
  }
  
  if(bootCI==TRUE && k1=="gps" && k2=="gps"){
    #calculate test statistic
    ks_test_stat<-max(abs(cumsum(kernel1[["gps_kernel"]])-cumsum(kernel2[["gps_kernel"]])))
    ks_list[[1]]<-ks_test_stat
    
    iter<-10000
    bs<-vector(length=iter)
    for(i in 1:iter) {
      bs1Cols <- sample(1:ncol(matrix1), ncol(matrix1), replace=TRUE)
      bs1Mat <- matrix1[, bs1Cols]
      bs1Ave <- rowMeans(bs1Mat)
      bs2Cols <- sample(1:ncol(matrix2), ncol(matrix2), replace=TRUE)
      bs2Mat <- matrix2[, bs2Cols]
      bs2Ave <- rowMeans(bs2Mat)
      bs[i] <- max(abs(cumsum(bs1Ave)-cumsum(bs2Ave)))
    }
    
    greater_vals<-bs[bs>ks_test_stat]
    ks_list[[2]]<-length(greater_vals)/iter  # p-value
    
    }
  return(ks_list)
}

