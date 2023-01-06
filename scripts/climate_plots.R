library(here)
library(tidyverse)
library(patchwork)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

df<-read_csv(here("data/climate/monthly_trends.csv"))

# df<-df %>% 
#   pivot_longer(avg_max_temp:avg_temp,
#                names_to = 'tmp_type',
#                values_to = 'temp')
# 
# months<-unique(df$month_str)



p1<-df %>% 
  ggplot(aes(factor(month_str, levels=month.name), avg_max_temp, color=study_site, group=study_site))+
  geom_point()+
  geom_line(linewidth=1)+
  theme_bw()+
  labs(color="Study Site", x="Month", y="Temperature (°F)\n", title="Average maximum monthly temperature")+
  scale_color_manual(labels=c("FL", "CA"), values=c("goldenrod1", "blue"))+
  theme(axis.text.x=element_text(angle=-30))+
  theme(
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 18,
      face = "bold",
      family = "serif", 
      hjust=0.5),
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
      size = 16,
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
    legend.background = element_rect(fill = "transparent", colour = NA)
  )


# this is too busy
# df %>% 
#   ggplot(aes(x=month_str, y=temp,color=as.factor(tmp_type), linetype=study_site))+
#   geom_point()+
#   geom_line(aes(group=interaction(tmp_type, study_site)))+
#   scale_x_discrete(labels=months)
#####
ggsave(
  filename = here("figures/climate_plots/max_temp.tiff"),
  plot = p1, compression = "lzw"
)

p2<-df %>% 
  ggplot(aes(factor(month_str, levels=month.name), avg_total_precip, color=study_site, group=study_site))+
  geom_point()+
  geom_line(linewidth=1)+
  labs(color="Study Site", x="Month", y="Precipitation (inches)\n", title="Average monthly precipitation")+
  scale_color_manual(labels=c("FL", "CA"), values=c("goldenrod1", "blue"))+
  scale_y_continuous(breaks=seq(0,10, by=2))+
  theme_bw()+
  theme(axis.text.x=element_text(angle=-30))+
  theme(
    # Specify the default settings for the plot title
    plot.title = element_text(
      size = 18,
      face = "bold",
      family = "serif", 
      hjust=0.5),
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
      size = 16,
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
    legend.background = element_rect(fill = "transparent", colour = NA)
  )
ggsave(
  filename = here("figures/climate_plots/precip.tiff"),
  plot = p2, compression = "lzw"
)

