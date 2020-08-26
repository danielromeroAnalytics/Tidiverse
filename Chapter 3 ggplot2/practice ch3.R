# Chapter 3 Data Visualziation
install.packages("tidyverse")
library(tidyverse)
mpg
# Create plot of efficiency vs engine size
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))

#Excercises
ggplot(data=mpg) #empty canvas
nrow(mpg); ncol(mpg) # Number of rows and cols

ggplot(data=mpg)+
  geom_point(mapping=aes(x=class,y=drv))
# Aesthetic Mappings

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,color=class))

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,size=class))

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,alpha=class))

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,shape=class))

# To make all point blue
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),col="blue")

# Excercises 3.3.1

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),col="blue") # the color was outside aes
str(mpg) #Check categorical and continuous varaibles

?geom_point
# If a condition is added to color it shows T and F
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy,col=displ<5))

#Facets
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_wrap(~class,nrow=2)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(drv~cyl)

#Excercises
# If you try to facet wrap on continuous varaible it creates multiple plots
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_wrap(~displ,nrow=2)
# empty plots in facet means that there are no combinations of those values

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(drv~.)

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  facet_grid(.~cyl)

?facet_wrap
?facet_grid

# Geoms

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))
ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ,y=hwy))

ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ,y=hwy,linetype=drv))

ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ,y=hwy))
ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ,y=hwy,group=drv))
ggplot(data=mpg)+
  geom_smooth(mapping=aes(x=displ,y=hwy,col=drv),show.legend=F)

#Multiple geoms in one plot

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy))+
  geom_smooth(mapping=aes(x=displ,y=hwy))

ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth()

ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point(mapping=aes(col=class))+
  geom_smooth(data=filter(mpg,class=="subcompact"),se=F)

#Excercises
?geom_line
?geom_boxplot
?geom_bar
?geom_area
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_line()

ggplot(data=mpg,mapping=aes(y = hwy,x=class))+
  geom_boxplot()+
  coord_flip()

ggplot(data=mpg,mapping=aes(x=displ,y=hwy,col=drv))+
  geom_point()+
  geom_smooth(se=F)

ggplot()+
  geom_point(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_smooth(data=mpg,mapping=aes(x=displ,y=hwy))

ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth()
#both plots are the same
#recreate the plots
#1
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth(se=F)
#2
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point()+
  geom_smooth(mapping=aes(group=drv),se=F)
#3
ggplot(data=mpg,mapping=aes(x=displ,y=hwy,col=drv))+
  geom_point()+
  geom_smooth(mapping=aes(group=drv),se=F)
#4
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point(mapping=aes(col=drv))+
  geom_smooth(se=F)
#5
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point(mapping=aes(col=drv))+
  geom_smooth(mapping=aes(linetype=drv),se=F)

#6
ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),col="white",size=5)+
  geom_point(mapping=aes(x=displ,y=hwy,col=drv))

#Statistical Tansformation
diamonds
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut))

demo<-tribble(
  ~cut, ~freq,
  "Fair", 1610,
  "Good",4906,
  "Very Good",12082,
  "Premium", 13791,
  "ideal", 21551
)
ggplot(data=demo)+
  geom_bar(mapping=aes(x=cut,y=freq),stat="identity")

ggplot(diamonds)+
  geom_bar(mapping=aes(x=cut,y=stat(prop),group=1))

ggplot(data=diamonds)+
  stat_summary(
    mapping=aes(x=cut,y=depth),
    fun.ymin=min,
    fun.ymax=max,
    fun.y=median
  )
ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,y=..prop..,group=1))

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=color,y=..prop..))

# Position adjustments

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,col=cut))

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=cut))

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=clarity))

#Positions
ggplot(data=diamonds,mapping=aes(x=cut,fill=clarity))+
  geom_bar(alpha=1/5,position="identity")

ggplot(data=diamonds,mapping=aes(x=cut,col=clarity))+
  geom_bar(fill=NA,position="identity")

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=clarity),position="fill")

ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=clarity),position="dodge")

ggplot(data=mpg)+
  geom_point(mapping=aes(x=displ,y=hwy),position="jitter")

#Excercises

ggplot(data=mpg,mapping=aes(x=cty,y=hwy))+
 geom_point(position="jitter")  

ggplot(data=mpg,mapping=aes(y=hwy,x=class))+
  geom_boxplot()

bar<-ggplot(data=diamonds)+
  geom_bar(mapping=aes(x=cut,fill=cut))+
  labs(x=NULL,y=NULL)
bar
bar+coord_flip()
bar+coord_polar()
