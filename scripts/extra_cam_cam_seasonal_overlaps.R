# Add cam to cam seasonal overlap estimation for FL and CA and also add into coef plot

library(here)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# Create dataframe to store results
overlap_results<-data.frame(state=NA, db1=NA, db2=NA, coef_overlap=NA, CI_lower=NA, CI_upper=NA)

# FL cam Seasonal comparisons
# spring-summer FL cam
fl_spring<-readRDS(here("output/suntime_datasets/cameras/BIR_Spring_Cams.Rda"))
fl_summer<-readRDS(here("output/suntime_datasets/cameras/BIR_Summer_Cams.Rda"))

t0<-overlapEst(fl_spring$suntime, fl_summer$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_spring$suntime, fl_summer$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))

overlap_results[1,]<-c("FL", "Spring_Cam", "Summer_Cam", 
                       t0,boots$lower[1],boots$upper[1])
write_csv(overlap_results, here("output/extra_cam_overlaps.csv"))


# spring-fall FL cam
fl_fall<-readRDS(here("output/suntime_datasets/cameras/BIR_Fall_Cams.Rda"))

t0<-overlapEst(fl_spring$suntime, fl_fall$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_spring$suntime, fl_fall$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("FL", "Spring_Cam", "Fall_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# spring-winter FL cam
fl_winter<-readRDS(here("output/suntime_datasets/cameras/BIR_Winter_Cams.Rda"))

t0<-overlapEst(fl_spring$suntime, fl_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_spring$suntime, fl_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("FL", "Spring_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# summer-fall FL cam
t0<-overlapEst(fl_summer$suntime, fl_fall$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_summer$suntime, fl_fall$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("FL", "Summer_Cam", "Fall_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# summer-winter FL cam
t0<-overlapEst(fl_summer$suntime, fl_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_summer$suntime, fl_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("FL", "Summer_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# fall-winter FL cam
t0<-overlapEst(fl_fall$suntime, fl_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(fl_fall$suntime, fl_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("FL", "Fall_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# CA cam Seasonal comparisons
# spring-summer CA cam
ca_spring<-readRDS(here("output/suntime_datasets/cameras/Spring_15-16_Cams.Rda"))
ca_summer<-readRDS(here("output/suntime_datasets/cameras/Summer_15-16_Cams.Rda"))

t0<-overlapEst(ca_spring$suntime, ca_summer$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_spring$suntime, ca_summer$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Spring_Cam", "Summer_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# spring-fall CA cam
ca_fall<-readRDS(here("output/suntime_datasets/cameras/Fall_15-16_Cams.Rda"))

t0<-overlapEst(ca_spring$suntime, ca_fall$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_spring$suntime, ca_fall$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Spring_Cam", "Fall_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# spring-winter CA cam
ca_winter<-readRDS(here("output/suntime_datasets/cameras/Winter_15-17_Cams.Rda"))

t0<-overlapEst(ca_spring$suntime, ca_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_spring$suntime, ca_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Spring_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# summer-fall CA cam
t0<-overlapEst(ca_summer$suntime, ca_fall$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_summer$suntime, ca_fall$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Summer_Cam", "Fall_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# summer-winter CA cam
t0<-overlapEst(ca_summer$suntime, ca_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_summer$suntime, ca_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Summer_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)

# fall-winter CA cam
t0<-overlapEst(ca_fall$suntime, ca_winter$suntime, kmax = 3, 
               n.grid = 256, type="Dhat4")
bt<-bootstrap(ca_fall$suntime, ca_winter$suntime, n.grid=256, 
              nb=1000, type="Dhat4")
boots<-as.data.frame(bootCI(t0, bt, conf = 0.95))
res<-c("CA", "Fall_Cam", "Winter_Cam", t0, boots$lower[1], boots$upper[1])

write_csv(as.data.frame(t(res)), here("output/extra_cam_overlaps.csv"), append = T)
