# PLot all the overlap coefficients

packages<-c('here', 'tidyverse', 'ggthemes')

# install any packages not previously installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# load packages
invisible(lapply(packages, library, character.only = TRUE))


df<-read_csv(here("output/all_suntimes_overlap_table.csv"))
df1<-read_csv(here("output/extra_cam_overlaps.csv"))
df1$comparison<-"seasonal (Cam)"

df<-rbind(df, df1)

##
df$full<-paste(df$db1, df$db2, sep='-')

df<-df %>% 
  mutate(full=recode(full, "Spring_GPS-Spring_Cam" = "Spring GPS - Spring Camera",
               "summer_GPS-summer_Cam" = "Summer GPS - Summer Camera",
               "fall_GPS-fall_Cam" = "Fall GPS - Fall Camera",
               "winter_GPS-winter_Cam" = "Winter GPS - Winter Camera",
               "spring_gps-summer_gps" = "Spring GPS - Summer GPS",
               "spring_gps-fall_gps" = "Spring GPS - Fall GPS",
               "spring_gps-winter_gps" = "Spring GPS - Winter GPS",
               "summer_gps-fall_gps" = "Summer GPS - Fall GPS",
               "summer_gps-winter_gps" = "Summer GPS - Winter GPS",
               "fall_gps-winter_gps" = "Fall GPS - Winter GPS",
               "spring_female_gps-spring_male_gps" = "Spring Female GPS - Spring Male GPS",
               "summer_female_gps-summer_male_gps" = "Summer Female GPS - Summer Male GPS",
               "fall_female_gps-fall_male_gps" = "Fall Female GPS - Fall Male GPS",
               "winter_female_gps-winter_male_gps" = "Winter Female GPS - Winter Male GPS",
               "Spring_Cam-Summer_Cam" = "Spring Camera - Summer Camera",
               "Spring_Cam-Fall_Cam" = "Spring Camera - Fall Camera",
               "Spring_Cam-Winter_Cam" = "Spring Camera - Winter Camera",
               "Summer_Cam-Fall_Cam" = "Summer Camera - Fall Camera",
               "Summer_Cam-Winter_Cam" = "Summer Camera - Winter Camera",
               "Fall_Cam-Winter_Cam" = "Fall Camera - Winter Camera"))

orders<-unique(df$full)

p1<-df %>% 
  mutate(full=fct_relevel(full,orders)) %>% 
  ggplot(aes(x=fct_rev(full), y=coef_overlap, colour=comparison, group=comparison))+
  geom_point(size=3)+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), lwd=1, width=0)+
  labs(y="Coefficient of overlap",x="Dataset comparisons \n",colour="Type of comparison")+
  facet_wrap(~state)+
  coord_flip()+
  theme_bw()+
  scale_colour_discrete(breaks=unique(df$comparison))+
  theme(
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 18,
      face = "bold",
      family = "serif"),
    # Specify the default settings for caption text
    plot.caption = element_text(
      size = 12,
      family = "serif" ),
    # Specify the default settings for subtitle text
    plot.subtitle = element_text(
      size = 16,
      family = "serif"),
    # Specify the default settings for axis titles
    axis.title = element_text(
      size = 16,
      face = "bold",
      family = "serif"),
    # Specify the default settings for x axis text
    axis.text.x = element_text(
      size = 16,
      family = "serif",
      face="bold"),
    # Specify the default settings for y axis text
    axis.text.y = element_text(
      size = 14,
      family = "serif",
      face="bold"),
    # Specify the default settings for legend titles
    legend.title = element_text(
      size = 16,
      face = "bold",
      family = "serif"),
    # Specify the default settings for legend text
    legend.text = element_text(
      size = 16,
      family = "serif"), 
   
    axis.line = element_line(color = "black"),
    
    # The legend
    legend.key = element_rect(fill = "transparent", colour = NA),
    legend.key.size = unit(1.5, "lines"),
    legend.background = element_rect(fill = "transparent", colour = NA),
    
    # The labels in the case of facetting
    strip.text = element_text(size = 16, face = "bold",
                              color = "black", margin = margin(5,0,5,0))
    )

ggsave(
  filename = here("figures/coef_plot/coef_plot.tiff"),
  plot = p1, 
  compression = "lzw"
)

