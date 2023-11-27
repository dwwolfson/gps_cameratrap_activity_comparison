# Run Chi-squared tests for all the camera trap datab

library(here)
library(tidyverse)

func_paths<-list.files(here("scripts/functions"), full.names = T)
invisible(lapply(func_paths, source))

files<-list.files(path=here("output/suntime_datasets/cameras"), full.names = T)

# store results of tests
out<-data.frame(dataset_name=NA, 
                p_val=NA,
                chi_stat=NA,
                st_res_nocturnal=NA,
                st_res_diurnal=NA,
                st_res_crepuscular=NA)

for(i in 1:length(files)){

  #store name of dataset
  tmp_name<-substr(basename(files[i]),1,nchar(basename(files[i]))-4)
  
# import dataset
tmp<-readRDS(files[[i]])  
  
# sample size
n<-nrow(tmp)

# convert from radians to hours
tmp_hrs<-tmp$suntime*(24/(2*pi))

# daily categories
tmp_nocturnal<-sum(tmp_hrs<5 | tmp_hrs>19)
tmp_diurnal<-sum(tmp_hrs > 7 & tmp_hrs < 17)
tmp_crepuscular<-sum(tmp_hrs >5 & tmp_hrs < 7 | tmp_hrs > 17 & tmp_hrs < 19)

# run test
tmp_chi<-chisq.test(x=c(tmp_nocturnal, tmp_diurnal, tmp_crepuscular),
           p=c(10/24, 10/24, 4/24))

# save output
out[i,]<-c(tmp_name, tmp_chi$p.value, tmp_chi$statistic[[1]], 
           tmp_chi$stdres[[1]],tmp_chi$stdres[[2]],
           tmp_chi$stdres[[3]])

}

# convert out from wide to long for easier 'ggplotting'
out_long<-out %>% 
  pivot_longer(cols=c(st_res_nocturnal,
                      st_res_diurnal,
                      st_res_crepuscular),
               names_to = "standardized_residual_type",
               values_to = "residual")

out_long$study_site<-c(rep("Florida", 12), rep("California", 12))
out_long$season<-c(rep("Fall", 3), rep("Spring", 3), rep("Summer", 3), rep("Winter", 3),
                   rep("Fall", 3), rep("Spring", 3), rep("Summer", 3), rep("Winter", 3))

season_labs<-c("Crepuscular", "Diurnal", "Nocturnal")

res_plot<-out_long  %>%
  ggplot(., aes(standardized_residual_type, as.numeric(residual), color=as.factor(season)))+
    geom_point()+
    geom_line(aes(group=dataset_name, linetype=study_site), linewidth=1)+
  theme_bw()+
  my_theme()+
  scale_x_discrete(labels=season_labs)+
  labs(color="Season", linetype="Study Site", x="\nDiel Periods", y="Standardized Residuals\n")+
  theme(
  # Specify the default settings for axis titles
  axis.title = element_text(
    size = 24,
    face = "bold",
    family = "serif"),
  # Specify the default settings for x axis text
  axis.text.x = element_text(
    size = 24,
    face = "bold",
    family = "serif"),
  # Specify the default settings for y axis text
  axis.text.y = element_text(
    size = 22,
    family = "serif"),
  # Specify the default settings for legend titles
  legend.title = element_text(
    size = 24,
    face = "bold",
    family = "serif"),
  # Specify the default settings for legend text
  legend.text = element_text(
    size = 24,
    family = "serif"))

ggsave(
  filename = here("figures/chi_squared/residuals.tiff"),
  plot = res_plot, compression = "lzw",
  width=16, height=10
)







