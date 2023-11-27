library(here)
library(tidyverse)
library(patchwork)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

df<-read_csv(here("raw_data/monthly_trends.csv"))

# df<-df %>% 
#   pivot_longer(avg_max_temp:avg_temp,
#                names_to = 'tmp_type',
#                values_to = 'temp')
# 
# months<-unique(df$month_str)
df$avg_max_temp_c<-(df$avg_max_temp-32)*(5/9)


p1<-df %>% 
  ggplot(aes(factor(month_str, levels=month.name), avg_max_temp_c, color=study_site, group=study_site))+
  geom_point()+
  geom_line(linewidth=1)+
  theme_bw()+
  labs(color="Study Site", x="\nMonth", y="Temperature (°C)\n", title="Average Maximum Monthly Temperature")+
  scale_color_manual(labels=c("FL", "CA"), values=c("goldenrod1", "blue"))+
  theme(axis.text.x=element_text(angle=-30))+
  theme(
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 24,
      face = "bold",
      family = "serif", 
      hjust=0.5),
    # Specify the default settings for axis titles
    axis.title = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for x axis text
    axis.text.x = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for y axis text
    axis.text.y = element_text(
      size = 22,
      family = "serif"),
    # Specify the default settings for legend titles
    legend.title = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for legend text
    legend.text = element_text(
      size = 22,
      family = "serif"), 
    axis.line = element_line(color = "black"),
    
    # The legend
    legend.key = element_rect(fill = "transparent", colour = NA),
    legend.key.size = unit(1.5, "lines"),
    legend.background = element_rect(fill = "transparent", colour = NA)
  )


ggsave(
  filename = here("figures/climate_plots/max_temp.tiff"),
  plot = p1, compression = "lzw"
)

df$avg_total_precip_mm<-df$avg_total_precip*25.4


p2<-df %>% 
  ggplot(aes(factor(month_str, levels=month.name), avg_total_precip_mm, color=study_site, group=study_site))+
  geom_point()+
  geom_line(linewidth=1)+
  labs(color="Study Site", x="\nMonth", y="Precipitation (mm)\n", title="Average Monthly Precipitation")+
  scale_color_manual(labels=c("FL", "CA"), values=c("goldenrod1", "blue"))+
  theme_bw()+
  theme(axis.text.x=element_text(angle=-30))+
  theme(
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 24,
      face = "bold",
      family = "serif", 
      hjust=0.5),
    # Specify the default settings for axis titles
    axis.title = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for x axis text
    axis.text.x = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for y axis text
    axis.text.y = element_text(
      size = 22,
      family = "serif"),
    # Specify the default settings for legend titles
    legend.title = element_text(
      size = 22,
      face = "bold",
      family = "serif"),
    # Specify the default settings for legend text
    legend.text = element_text(
      size = 22,
      family = "serif"), 
    axis.line = element_line(color = "black"),
    
    # The legend
    legend.key = element_rect(fill = "transparent", colour = NA),
    legend.key.size = unit(1.5, "lines"),
    legend.background = element_rect(fill = "transparent", colour = NA)
  )

ggsave(
  filename = here("figures/climate_plots/precip.tiff"),
  plot = p2, compression = "lzw"
)


