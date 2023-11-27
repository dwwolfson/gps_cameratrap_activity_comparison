# Provide a table of sample sizes for camera pig detections for every season.
library(here)
library(tidyverse)

f_fall<-read_csv(here("raw_data/BIR_FL/Cameras/BIR_Fall_Cams.csv"))
f_winter<-read_csv(here("raw_data/BIR_FL/Cameras/BIR_Winter_Cams.csv"))
f_spring<-read_csv(here("raw_data/BIR_FL/Cameras/BIR_Spring_Cams.csv"))
f_summer<-read_csv(here("raw_data/BIR_FL/Cameras/BIR_Summer_Cams.csv"))

files<-list.files(here("raw_data/Tejon_CA/Camera"), full.names = T)
# too lazy to actually regex the season out
t_fall<-read_csv(files[[1]])
t_spring<-read_csv(files[[2]])
t_summer<-read_csv(files[[3]])
t_winter<-read_csv(files[[4]])

# a good way to bring in but a bad way to name
# # list2env(
#   lapply(setNames(files, make.names(gsub("*.csv$", "", files))), 
#          read_csv), envir = .GlobalEnv)


# GPS 
files<-list.files(here("data/"), pattern="GPS", full.names=T)
g_spring<-read_csv(files[[2]])
g_summer<-read_csv(files[[3]])
g_fall<-read_csv(files[[1]])
g_winter<-read_csv(files[[4]])

files<-list.files(here("data/Tejon"), pattern="GPS", full.names=T)
ca_spring<-read_csv(files[[2]])
ca_summer<-read_csv(files[[3]])
ca_fall<-read_csv(files[[1]])
ca_winter<-read_csv(files[[4]])
