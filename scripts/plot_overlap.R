# PLot all the overlap coefficients

library(here)
library(tidyverse)

df<-read_csv(here("output/overlap_table.csv"))

df$type<-as.factor(df$type)
df$full<-paste(df$state, df$db1, df$db2, sep='-')

df %>% 
  arrange(type) %>% 
  mutate(full=factor(full, levels=full)) %>% 
ggplot(aes(full, coef_overlap, colour=type, group=type))+
  geom_point()+
  geom_errorbar(aes(ymin=CI_lower, ymax=CI_upper), size=0.5)+
  labs(y="coefficient of overlap",x="datasets used",colour="type of comparison")+
  facet_wrap(~state)+
  coord_flip()
