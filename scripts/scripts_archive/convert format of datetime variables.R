# fix stupid date column
library(lubridate)


files<-c(here("data/sexes_by_year/BIR_SpringGPS_Females2015.csv"),
here("data/sexes_by_year/BIR_SummerGPS_Females2015.csv"),
here("data/sexes_by_year/BIR_SummerGPS_Females2016.csv"),
here("data/sexes_by_year/BIR_SummerGPS_Females2017.csv"),
here("data/sexes_by_year/BIR_SpringGPS_Males2015.csv"),
here("data/sexes_by_year/BIR_SpringGPS_Males2016.csv"),
here("data/sexes_by_year/BIR_SpringGPS_Males2017.csv"),
here("data/sexes_by_year/BIR_SummerGPS_Males2016.csv"),
here("data/sexes_by_year/BIR_SummerGPS_Males2017.csv"))

for(i in 1:length(files)){
  tmp<-read.csv(files[[i]])
  
  tmp$Fix_DateTime<-as.POSIXct(strptime(as.character(tmp$Fix_DateTime),"%m/%d/%Y %H:%M", tz="America/New_York"))
  tmp$Fix_DateTime<-format(tmp$Fix_DateTime, "%Y/%m/%d %H:%M")
  tmp_name<-strsplit(files[[i]], "/")[[1]][[7]]
  write.csv(x = tmp, file = paste(here("data/fixed_dates/"), tmp_name, sep="/"))
}

# for Tejon

files<-list.files(here("data/Tejon/"), pattern= "*GPS.csv", full.names = T)
for(i in 1:length(files)){
  tmp<-read.csv(files[[i]])
  
  tmp$Fix_DateTime<-as.POSIXct(strptime(as.character(tmp$Fix_DateTime),"%m/%d/%Y %H:%M", tz="America/Los_Angeles"))
  tmp$Fix_DateTime<-format(tmp$Fix_DateTime, "%Y/%m/%d %H:%M")
  tmp_name<-strsplit(files[[i]], "/")[[1]][[7]]
  write.csv(x = tmp, file = paste(here("data/tejon_date_fixed/"), tmp_name, sep="/"))
}

# Tejon winter gps was already in Y/m/d format so it didn't need the conversion