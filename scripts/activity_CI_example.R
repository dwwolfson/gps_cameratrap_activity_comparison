library(here)
library(readr)
library(dplyr)
library(activity)
library(ggplot2)
# input camera csv
p1<-here("data/Tejon/Spring_15-16_Cams.csv")
p2<-here("data/Tejon/Summer_15-16_Cams.csv")
df1<-read_csv(p1)
df2<-read_csv(p2)
g1<-read_csv(here("data/tejon_date_fixed/TejonFallGPS.csv"))


cams<-sort(unique(df1$Camera))
num_cams<-length(cams)


# make a matrix to store activity info for each camera
cam_mat<-matrix(data=NA, nrow=256, ncol=num_cams)

m1<-fitact(df1$timeRad)
m2<-fitact(df2$timeRad)
#compareCkern(m1, m2)

f1<-fitact(df1$timeRad, sample="data")
plot(f1,yunit="density",data="histogram")
f2<-fitact(df2$timeRad, sample="data", reps=100)
plot(f2)
head(f2)
str(f2)
head(f2@pdf[2])
f2@pdf
plot(f1, yunit="density", 
     data="none", 
     tline=list(col="red"),
     cline=list(col="red"))

plot(f2, yunit="density",
     add=T, 
     data="none", 
     tline=list(col="blue"),
     cline=list(col="blue"))
# is what it looks like unshaded...too busy
# I either need to figure out shading, or throw in vertical lines for
# all the time periods where CI's aren't overlapping
polygon(x=c(rev(f1@pdf[,'x']), f1@pdf[,'x']),
        y=c(rev(f1@pdf[,'lcl']), f1@pdf[,'ucl']),
        col="blue", border=NA)

f1df<-as.data.frame(f1@pdf)
f2df<-as.data.frame(f2@pdf)
f12<-rbind(f1df, f2df)

ggplot()+
        geom_line(aes(f1df$x,f1df$y))+
        geom_ribbon(aes(x=f1df$x, ymin=f1df$lcl, ymax=f1df$ucl), alpha=0.5, fill="blue")+
        geom_line(aes(f2df$x, f2df$y))+
        geom_ribbon(aes(x=f2df$x, ymin=f2df$lcl, ymax=f2df$ucl), alpha=0.5, fill="goldenrod1")+
        theme(axis.text=element_text(colour="black", size=16), 
              axis.title=element_text(colour="black", size=16),
              legend.text=element_text(colour="black", size=15),
              legend.title=element_text(colour="black", size=15))+
        ylab("Activity Level")+
        xlab("Diel Period (in radians)")+
        scale_x_continuous(expand=c(0,0))+
        theme_bw()+
        theme(plot.margin = unit(c(1,1,1,1), "cm"))
        
        
