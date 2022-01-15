# Function to plot activity kernels with confidence intervals 

my_ggplot<-function(db1, db2, lab1=NA, lab2=NA, legend_title="", plot_title=NA){
  # db1 and db2 are the output of the boot_gps function (a dataframe with specific column names)
  # convert radians to hours
  db1$hr<-db1$x*(24/(2*pi))
  db2$hr<-db2$x*(24/(2*pi))
  
  ggplot()+
    geom_line(aes(db1$hr, db1$y))+
    geom_ribbon(aes(x=db1$hr, ymin=db1$lcl, ymax=db1$ucl, fill="blue"), alpha=0.5 )+
    geom_line(aes(db2$hr, db2$y))+
    geom_ribbon(aes(x=db2$hr, ymin=db2$lcl, ymax=db2$ucl, fill='goldenrod1'), alpha=0.5 )+
    scale_x_continuous(limits = c(0,24), breaks=c(0,6,12,18, 24), expand = c(0, 0), 
                       labels=c("0:00", "6:00", "12:00", "18:00", "24:00"))+
    ylab("Activity")+
    xlab("Time of Day")+
    theme_bw()+
    scale_fill_manual(name=legend_title, labels=c(lab1, lab2), 
                      values=c("blue"="blue","goldenrod1"="goldenrod1"))+
    
    ggtitle(plot_title)+
    theme(plot.title = element_text(hjust = 0.5))+
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
        size = 14,
        family = "serif"),
      # Specify the default settings for y axis text
      axis.text.y = element_text(
        size = 14,
        family = "serif"),
      # Specify the default settings for legend titles
      legend.title = element_text(
        size = 16,
        face = "bold",
        family = "serif"),
      # Specify the default settings for legend text
      legend.text = element_text(
        size = 14,
        family = "serif"))
  
}