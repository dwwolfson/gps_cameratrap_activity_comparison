# Convert table 1 to a figure (to satisfy reviewer request)
library(here)
library(tidyverse)
library(ggpubr)

df<-read_csv(here("output/diel_table.csv"))

df<-df %>% 
  rename("Crepuscular"="prop_crepuscular",
         "Diurnal"="prop_diurnal",
         "Nocturnal"="prop_nocturnal")
df<-df %>% 
  mutate(method=recode(method, "cam"="Camera"),
         season=str_to_title(season))

df<-df %>% 
  pivot_longer(df, cols=Nocturnal:Crepuscular,
             names_to="diel_category",
       values_to="prop_activity")



p1<-ggplot(df, aes(fct_relevel(season, "Spring", "Summer", "Fall", "Winter"), 
                   prop_activity,
               group=diel_category, 
               color=diel_category))+
  labs(color="Diel Category",
       x="\n Season",
       y="Proportion of Diel Activity\n",
       )+
  geom_point()+
  facet_grid(site~method)+
  geom_line()+
  theme_bw()+
  theme(axis.text.x=element_text(angle=-45))+
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
  filename=here("figures/post_review/diel.tiff"),
                plot=p1, compression="lzw")

