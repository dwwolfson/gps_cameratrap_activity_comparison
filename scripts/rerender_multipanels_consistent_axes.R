
# Create all 4-panel plots

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
out_dir<-here("output/plot_objects")

# in order to have consistent y axes in a multipanel plot, here are the y-limits
# FL methods 0.5
# CA methods 0.55
# FL sex 0.55



# FL methods
# 1) FL	Spring_GPS	Spring_Cam
fl_methods_spring<-readRDS(here("output/plot_objects/fl_spring.RDS"))

fl_methods_spring<-fl_methods_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.85, CI = (0.84-0.86)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.5))



# 2) FL	summer_GPS	summer_Cam
fl_methods_summer<-readRDS(here("output/plot_objects/fl_summer.RDS"))

fl_methods_summer<-fl_methods_summer+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.84, CI = (0.82-0.86)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.5))

# 3) FL	fall_GPS	fall_Cam
fl_methods_fall<-readRDS(here("output/plot_objects/fl_fall.RDS"))

fl_methods_fall<-fl_methods_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.90, CI = (0.86-0.93)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.5))

# 4) FL	winter_GPS	winter_Cam
fl_methods_winter<-readRDS(here("output/plot_objects/fl_winter.RDS"))

fl_methods_winter<-fl_methods_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.93, CI = (0.90-0.94)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.5))


fl_methods_comparison <- fl_methods_winter +fl_methods_fall + fl_methods_summer + fl_methods_spring 

# ggsave(
#   filename = here("figures/multipanel_plots_w_suntime/consistent_axes/fl_methods.tiff"),
#   plot = fl_methods_comparison, compression = "lzw"
# )

# I rendered all the plots, but then tweaked the my_theme function to make the text fonts bigger and reran

# larger font sizes
ggsave(
  filename = here("figures/multipanel_plots_w_suntime/consistent_axes/bigger_fonts/fl_methods.tiff"),
  plot = fl_methods_comparison, compression = "lzw"
)


###########
# Tejon methods
# 40) CA	Spring_GPS	Spring_Cam
tejon_spring<-readRDS(here("output/plot_objects/tejon_spring.RDS"))

tejon_spring<-tejon_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.77, CI = (0.71-0.82)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))


# 41) CA	summer_GPS	summer_Cam
tejon_summer<-readRDS(here("output/plot_objects/tejon_summer.RDS"))


tejon_summer<-tejon_summer+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.76, CI = (0.69-0.82)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

# 42) CA	fall_GPS	fall_Cam
tejon_fall<-readRDS(here("output/plot_objects/tejon_fall.RDS"))


tejon_fall<-tejon_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.79, CI = (0.69-0.87)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))


# 43) CA	winter_GPS	winter_Cam
tejon_winter<-readRDS(here("output/plot_objects/tejon_winter.RDS"))


tejon_winter<-tejon_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.85, CI = (0.75-0.89)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

tejon_methods_comparison <- tejon_winter + tejon_fall + tejon_summer + tejon_spring

# 
# ggsave(
#   filename = here("figures/multipanel_plots_w_suntime/consistent_axes/tejon_methods.tiff"),
#   plot = tejon_methods_comparison, compression = "lzw"
# )

# bigger fonts
ggsave(
  filename = here("figures/multipanel_plots_w_suntime/consistent_axes/bigger_fonts/tejon_methods.tiff"),
  plot = tejon_methods_comparison, compression = "lzw"
)

##########################
# Sex comparison for GPS at Florida


# 8) FL	winter_GPS_female	winter_gps_male
fl_sex_winter<-readRDS(here("output/plot_objects/fl_sex_winter.RDS"))

fl_sex_winter<-fl_sex_winter+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.88, CI = (0.79-0.93)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

# 5) FL	fall_GPS_female	fall_gps_male
fl_sex_fall<-readRDS(here("output/plot_objects/fl_sex_fall.RDS"))

fl_sex_fall<-fl_sex_fall+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.90, CI = (0.80-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

# 7) FL	summer_GPS_female	summer_gps_male
fl_sex_summer<-readRDS(here("output/plot_objects/fl_sex_summer.RDS"))

fl_sex_summer<-fl_sex_summer+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.93, CI = (0.87-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

# 6) FL	spring_GPS_female	spring_gps_male
fl_sex_spring<-readRDS(here("output/plot_objects/fl_sex_spring.RDS"))

fl_sex_spring<-fl_sex_spring+
  labs(subtitle=expression(paste(hat(Delta)[4], " = 0.92, CI = (0.87-0.95)")))+
  theme(plot.subtitle = element_text(hjust=0.5,
                                     face="bold"))+
  my_theme()+
  ylim(c(0,0.55))

fl_sex_comparison <- fl_sex_winter + fl_sex_fall + fl_sex_summer + fl_sex_spring

# ggsave(
#   filename = here("figures/multipanel_plots_w_suntime/consistent_axes/fl_sex.tiff"),
#   plot = fl_sex_comparison, compression = "lzw",
#   width=16, height=10
# )

# bigger fonts
ggsave(
  filename = here("figures/multipanel_plots_w_suntime/consistent_axes/bigger_fonts/fl_sex.tiff"),
  plot = fl_sex_comparison, compression = "lzw",
  width=16, height=10
)
