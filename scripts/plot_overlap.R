# PLot all the overlap coefficients

library(here)
library(tidyverse)

df<-read_csv(here("output/overlap_table.csv"))

df$type<-as.factor(df$type)
df$full<-paste(df$state, df$db1, df$db2, sep='-')

sub<-df %>% 
  filter(type%in%c("GPS/Cam", "season_light-corrected", "sex"))

df %>% 
  arrange(type) %>% 
  mutate(full=factor(full, levels=full)) %>% 
ggplot(aes(full, coef_overlap, colour=type, group=type))+
  geom_point()+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), size=0.5)+
  labs(y="coefficient of overlap",x="datasets used",colour="type of comparison")+
  facet_wrap(~state)+
  coord_flip()



##
sub$full<-paste(sub$db1, sub$db2, sep='-')

library(ggthemes)

sub %>% 
  arrange(type) %>% 
  ggplot(aes(full, coef_overlap, colour=type, group=type))+
  geom_point()+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), size=0.5)+
  labs(y="coefficient of overlap",x="datasets used",colour="type of comparison")+
  facet_wrap(~state)+
  # scale_x_discrete(breaks=1:20, labels=c(letters[1:20]))+
  coord_flip()+
  theme_bw()


