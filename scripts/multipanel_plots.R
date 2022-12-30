
# Create all 4-panel plots

library(here)
library(ggplot2)
library(readr)
library(activity)
library(patchwork)

func_paths <- list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

# FL methods
# 1) FL	Spring_GPS	Spring_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRSpringGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Spring_Cams.Rda"))

fl_methods_spring <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Spring"
) +
  annotate("text",
    x = 12, y = 0.4,
    label = expression(paste(Delta, "=0.85, CI=(0.84-0.86)")),
    size = 6
  )

# 2) FL	summer_GPS	summer_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRSummerGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Summer_Cams.Rda"))

fl_methods_summer <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Summer"
) +
  annotate("text",
    x = 12, y = 0.4,
    label = expression(paste(Delta, "=0.84, CI=(0.82-0.86)")),
    size = 6
  )

# 3) FL	fall_GPS	fall_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRFallGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Fall_Cams.Rda"))

fl_methods_fall <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Fall"
) +
  annotate("text",
    x = 12, y = 0.4,
    label = expression(paste(Delta, "=0.90, CI=(0.86-0.93)")),
    size = 6
  )

# 4) FL	winter_GPS	winter_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIRWinterGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/BIR_Winter_Cams.Rda"))

fl_methods_winter <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Camera",
  plot_title = "Winter"
) +
  annotate("text",
    x = 8, y = 0.45,
    label = expression(paste(Delta, "=0.93, CI=(0.90-0.94)")),
    size = 6
  )

fl_methods_comparison <- fl_methods_winter + fl_methods_fall + fl_methods_summer + fl_methods_spring +
  plot_annotation(
    title = "Activity patterns at Buck Island Ranch, FL using GPS and camera traps",
    theme = theme(plot.title = element_text(
      hjust = 0.5,
      margin = margin(0, 0, 15, 0),
      size = 20,
      face = "bold",
      family = "serif"
    ))
  )


ggsave(
  filename = here("figures/multipanel_plots_w_suntime/fl_methods_comparison.tiff"),
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
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.77, CI=(0.71-0.82)")),
    size = 6
  )

# 41) CA	summer_GPS	summer_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonSummerGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Summer_15-16_Cams.Rda"))

tejon_summer <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Cams",
  plot_title = "Summer"
) +
  annotate("text",
    x = 12, y = 0.4,
    label = expression(paste(Delta, "=0.76, CI=(0.69-0.82)")),
    size = 6
  )

# 42) CA	fall_GPS	fall_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonFallGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Fall_15-16_Cams.Rda"))

tejon_fall <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Cams",
  plot_title = "Fall"
) +
  annotate("text",
    x = 12, y = 0.4,
    label = expression(paste(Delta, "=0.79, CI=(0.69-0.87)")),
    size = 6
  )


# 43) CA	winter_GPS	winter_Cam
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/TejonWinterGPSkernel.csv"))
db2 <- readRDS(here("output/suntime_datasets/cameras/Winter_15-17_Cams.Rda"))

tejon_winter <- my_ggplot_suntime(db1, db2,
  db2_method = "cam", lab1 = "GPS", lab2 = "Cams",
  plot_title = "Winter"
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.85, CI=(0.75-0.89)")),
    size = 6
  )

tejon_methods_comparison <- tejon_winter + tejon_fall + tejon_summer + tejon_spring +
  plot_annotation(
    title = "Activity patterns at Tejon Ranch, CA using GPS and camera traps",
    theme = theme(plot.title = element_text(
      hjust = 0.5,
      margin = margin(0, 0, 15, 0),
      size = 20,
      face = "bold",
      family = "serif"
    ))
  )


ggsave(
  filename = here("figures/multipanel_plots_w_suntime/tejon_methods_comparison.tiff"),
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
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.88, CI=(0.79-0.93)")),
    size = 6
  )

# 5) FL	fall_GPS_female	fall_gps_male
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_FallGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_FallGPS_Males.csv"))

fl_sex_fall <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Fall"
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.90, CI=(0.80-0.95)")),
    size = 6
  )

# 7) FL	summer_GPS_female	summer_gps_male

db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SummerGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SummerGPS_Males.csv"))

fl_sex_summer <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Summer"
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.93, CI=(0.87-0.95)")),
    size = 6
  )

# 6) FL	spring_GPS_female	spring_gps_male
db1 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SpringGPS_Females.csv"))
db2 <- boot_gps(here("output/all_activity_kernels_with_suntime/BIR_SpringGPS_Males.csv"))

fl_sex_spring <- my_ggplot(db1, db2,
  lab1 = "Female", lab2 = "Male",
  plot_title = "Spring"
) +
  annotate("text",
    x = 12, y = 0.45,
    label = expression(paste(Delta, "=0.92, CI=(0.87-0.95)")),
    size = 6
  )

fl_sex_comparison <- fl_sex_winter + fl_sex_fall + fl_sex_summer + fl_sex_spring +
  plot_annotation(
    title = "Activity patterns at Buck Island Ranch, FL for males and females",
    theme = theme(plot.title = element_text(
      hjust = 0.5,
      margin = margin(0, 0, 15, 0),
      size = 20,
      face = "bold",
      family = "serif"
    ))
  )


ggsave(
  filename = here("figures/multipanel_plots_w_suntime/fl_sex_comparison.tiff"),
  plot = fl_sex_comparison, compression = "lzw"
)
