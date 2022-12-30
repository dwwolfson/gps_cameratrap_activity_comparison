# PLot all the overlap coefficients

library(here)
library(tidyverse)

df<-read_csv(here("output/all_suntimes_overlap_table.csv"))



df$full<-paste(df$state, df$db1, df$db2, sep='-')


df %>% 
  arrange(comparison) %>% 
  mutate(full=factor(full, levels=full)) %>% 
ggplot(aes(full, coef_overlap, colour=comparison, group=comparison))+
  geom_point()+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), size=0.5)+
  labs(y="coefficient of overlap",x="datasets used",colour="type of comparison")+
  facet_wrap(~state)+
  coord_flip()



##
df$full<-(paste(df$db1, df$db2, sep='-'))

library(ggthemes)

df %>% 
  arrange(comparison) %>% 
  ggplot(aes(full, coef_overlap, colour=comparison, group=comparison))+
  geom_point(size=3)+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), lwd=1, width=0)+
  labs(y="Coefficient of overlap",x="Datasets used",colour="Type of comparison")+
  facet_wrap(~state)+
  # scale_x_discrete(breaks=1:20, labels=c(letters[1:20]))+
  coord_flip()+
  theme_bw()+
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
    legend.background = element_rect(fill = "transparent", colour = NA),
    
    # The labels in the case of facetting
    strip.text = element_text(size = 16, face = "bold",
                              color = "black", margin = margin(5,0,5,0))
    )


