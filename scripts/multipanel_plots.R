
# Create all 4-panel plots
# Annotated confidence interval values from overlap script
# Save out bootstrapped output as RDS object to save intermediaries

packages<-c('here', 'readr', 'activity','ggplot2', 'patchwork')

# install any packages not previously installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# load packages
invisible(lapply(packages, library, character.only = TRUE))

func_paths <- list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))


# save plot objects to format for final figures
out_dir<-here("output/plot_objects/bigger_font_size")

# FL methods
# 1) FL	Spring_GPS	Spring_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRSpringGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Spring_Cams.Rda"))

fl_methods_spring <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Spring"
)

# saveRDS(fl_methods_spring, file=paste0(out_dir, "/fl_spring.RDS"))
fl_methods_spring<-readRDS(here("output/plot_objects/fl_spring.RDS"))

fl_methods_spring<-fl_methods_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.85, CI = (0.84-0.86)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()

# fl_methods_spring<-fl_methods_spring+
#   annotate("text",
#     x = 12, y = 0.4,
#     label = expression(paste(Delta, "=0.85, CI=(0.84-0.86)")),
#     size = 6
#   )



# 2) FL	summer_GPS	summer_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRSummerGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Summer_Cams.Rda"))

fl_methods_summer <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Summer"
) 
# saveRDS(fl_methods_summer, file=paste0(out_dir, "/fl_summer.RDS"))
fl_methods_summer<-readRDS(here("output/plot_objects/fl_summer.RDS"))

fl_methods_summer<-fl_methods_summer+
labs(subtitle=expression(paste(hat(Delta)[4], " = 0.84, CI = (0.82-0.86)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))



#   annotate("text",
#     x = 12, y = 0.4,
#     label = expression(paste(Delta, "=0.84, CI=(0.82-0.86)")),
#     size = 6
#   )

# 3) FL	fall_GPS	fall_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRFallGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Fall_Cams.Rda"))

fl_methods_fall <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Fall"
)
# saveRDS(fl_methods_fall, file=paste0(out_dir, "/fl_fall.RDS"))
fl_methods_fall<-readRDS(here("output/plot_objects/fl_fall.RDS"))

fl_methods_fall<-fl_methods_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.90, CI = (0.86-0.93)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

  # annotate("text",
  #   x = 12, y = 0.4,
  #   label = expression(paste(Delta, "=0.90, CI=(0.86-0.93)")),
  #   size = 6
  # )

# 4) FL	winter_GPS	winter_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRWinterGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Winter_Cams.Rda"))

fl_methods_winter <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Winter"
) 
# saveRDS(fl_methods_winter, file=paste0(out_dir, "/fl_winter.RDS"))
fl_methods_winter<-readRDS(here("output/plot_objects/fl_winter.RDS"))

fl_methods_winter<-fl_methods_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.93, CI = (0.90-0.94)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))
  
  # annotate("text",
  #   x = 12, y = 0.45,
  #   label = expression(paste(Delta, "=0.93, CI=(0.90-0.94)")),
  #   size = 6
  # )

fl_methods_comparison <- fl_methods_winter +fl_methods_fall + fl_methods_summer + fl_methods_spring 

ggsave(
  filename = here("figures/multipanel_plots_w_suntime/fl_methods_comparison_newest.tiff"),
  plot = fl_methods_comparison, compression = "lzw"
)



###########
# Tejon methods
# 40) CA	Spring_GPS	Spring_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonSpringGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Spring_15-16_Cams.Rda"))

tejon_spring <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Spring"
) 
# saveRDS(tejon_spring, file=paste0(out_dir, "/tejon_spring.RDS"))
tejon_spring<-readRDS(here("output/plot_objects/tejon_spring.RDS"))

tejon_spring<-tejon_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.77, CI = (0.71-0.82)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))





# 41) CA	summer_GPS	summer_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonSummerGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Summer_15-16_Cams.Rda"))

tejon_summer <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Summer"
) 
# saveRDS(tejon_summer, file=paste0(out_dir, "/tejon_summer.RDS"))
tejon_summer<-readRDS(here("output/plot_objects/tejon_summer.RDS"))


tejon_summer<-tejon_summer+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.76, CI = (0.69-0.82)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

# 42) CA	fall_GPS	fall_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonFallGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Fall_15-16_Cams.Rda"))

tejon_fall <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Fall"
) 
# saveRDS(tejon_fall, file=paste0(out_dir, "/tejon_fall.RDS"))
tejon_fall<-readRDS(here("output/plot_objects/tejon_fall.RDS"))


tejon_fall<-tejon_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.79, CI = (0.69-0.87)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))


# 43) CA	winter_GPS	winter_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonWinterGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Winter_15-17_Cams.Rda"))

tejon_winter <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Winter"
) 
# saveRDS(tejon_winter, file=paste0(out_dir, "/tejon_winter.RDS"))
tejon_winter<-readRDS(here("output/plot_objects/tejon_winter.RDS"))


tejon_winter<-tejon_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.85, CI = (0.75-0.89)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

tejon_methods_comparison <- tejon_winter + tejon_fall + tejon_summer + tejon_spring


 ggsave(
  filename = here("figures/multipanel_plots_w_suntime/tejon_methods_comparison_newest.tiff"),
  plot = tejon_methods_comparison, compression = "lzw"
)

##########################
# Sex comparison for GPS at Florida


# 8) FL	winter_GPS_female	winter_gps_male

db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_WinterGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_WinterGPS_Males.csv"))

fl_sex_winter <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Winter"
) 

# saveRDS(fl_sex_winter, file=paste0(out_dir, "/fl_sex_winter.RDS"))
fl_sex_winter<-readRDS(here("output/plot_objects/fl_sex_winter.RDS"))

fl_sex_winter<-fl_sex_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.88, CI = (0.79-0.93)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

# 5) FL	fall_GPS_female	fall_gps_male
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_FallGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_FallGPS_Males.csv"))

fl_sex_fall <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Fall"
) 
# saveRDS(fl_sex_fall, file=paste0(out_dir, "/fl_sex_fall.RDS"))
fl_sex_fall<-readRDS(here("output/plot_objects/fl_sex_fall.RDS"))

fl_sex_fall<-fl_sex_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.90, CI = (0.80-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

# 7) FL	summer_GPS_female	summer_gps_male

db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SummerGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SummerGPS_Males.csv"))

fl_sex_summer <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Summer"
) 
# saveRDS(fl_sex_summer, file=paste0(out_dir, "/fl_sex_summer.RDS"))
fl_sex_summer<-readRDS(here("output/plot_objects/fl_sex_summer.RDS"))

fl_sex_summer<-fl_sex_summer+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.93, CI = (0.87-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

# 6) FL	spring_GPS_female	spring_gps_male
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SpringGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SpringGPS_Males.csv"))

fl_sex_spring <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Spring"
) 
# saveRDS(fl_sex_spring, file=paste0(out_dir, "/fl_sex_spring.RDS"))
fl_sex_spring<-readRDS(here("output/plot_objects/fl_sex_spring.RDS"))

fl_sex_spring<-fl_sex_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.92, CI = (0.87-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))

fl_sex_comparison <- fl_sex_winter + fl_sex_fall + fl_sex_summer + fl_sex_spring

ggsave(
  filename = here("figures/multipanel_plots_w_suntime/fl_sex_comparison_newest.tiff"),
  plot = fl_sex_comparison, compression = "lzw"
)
