#Chapter 5 Dyplr
install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

flights
filter(flights,month==1,day==1)
#alternative with pipe

flights %>% filter(month==1,day==1)

flights %>% filter(month==11|month==12)
flights %>% filter(month %in% c(11,12))

#flights that were not delayed by more than 2 hours

filter(flights,!(arr_delay>120 | dep_delay>120))
filter(flights,(arr_delay<=120 & dep_delay<=120))

#Exercises
#1 arrival delay of 2 or more hours
filter(flights,arr_delay>=120)
#2 Flew to IAH or HOU
test<-filter(flights,dest %in% c("IAH","HOU"))
# 3 operated by UA, AA, DL
filter(flights,carrier %in% c("UA","AA","DL"))
# 4 departed in summer July, August, Sep
filter(flights,month %in% 7:9)
# 5 arrive more than 2 hours late but did not leave late
filter(flights, arr_delay>120&dep_delay<=0)
#6 were delayed by at least an hour but made up over 30 minutes in flight
filter(flights,dep_delay>=60 & arr_delay<dep_delay-30)
#7 Departed between midnight and 6 am
filter(flights,dep_time>=2400|dep_time<=600)

# Arrange

arrange(flights,year,month,day)
arrange(flights,desc(dep_delay))

df<-tibble(x=c(5,2,NA))
arrange(df,x)
arrange(df,desc(x))

arrange(df,desc(is.na(x)))
#find earliest departure
arrange(flights,dep_delay)
#find fastest flight
arrange(flights,desc(distance/air_time))
#Find the shortest and farthest
arrange(flights,distance)
arrange(flights,desc(distance))

#Select
select(flights,-(year:day))
select(flights,time_hour,air_time,everything())
select(flights,contains("TIME"))

#Mutate
flights_sml<-select(flights,year:day,ends_with("delay"),distance,air_time)

mutate(flights_sml,gain=dep_delay-arr_delay,speed=distance/air_time*60)

# Use transmute to keep only the new variables 

x<-seq(1:10)
cumsum(x)
lag(x)
lead(x)
cummin(x)
cummean(x)
min_rank(desc(x))

#Exercise
#1 convert dep_time and sched_dep_time minutes since midnight
time2mins <- function(x) {
  (x %/% 100 * 60 + x %% 100) %% 1440
}
flights %>% mutate(dept=time2mins(dep_time),scheddt=time2mins(sched_dep_time)) %>% 
select(dept,dep_time,scheddt,sched_dep_time)
# compare air_time with arr_time-dep_time
flights %>% mutate(air_time2=time2mins(arr_time)-time2mins(dep_time)) %>%
  select(dep_time,arr_time,air_time,air_time2)

flights%>%mutate(ranking=min_rank(dep_delay))%>%
    arrange(desc(ranking))

# Grouped Summaries


