#Lecture script 2023-02-23
#Created by: Jesse Jones
#Date Created: 2023-02-23
###Libraries
library(tidyverse)
library(here)
library(lubridate)
now() #what time is it on my computer's time zone?
now(tzone="EST") #what time is it EST?
today() #gives you only the date (no time)
am(now()) #is it morning?
pm(now())
leap_year(now()) #is this a leap year?
#for lubridate to work, your date needs to be a character!
ymd("2021-02-24")
mdy("02/24/21")
dmy("24/2/2021")
ymd_hms() #reads time as well as day; h=hour; m=minute; s=seconds
datetimes <- c("02/24/2021 22:22:20",
              "02/25/2021 11:21:10",
              "02/26/2021 8:01:52")
datetimes <- mdy_hms(datetimes)
month(datetimes) #What are the months in this vector (numerically)?
month(datetimes,label=TRUE) #What are the months (spelled out)?
wday(datetimes,label=TRUE) #extract day of the week
#works for hour, minute, and seconds with hour(datetimes) minute(datetimes) second(datetimes)
datetimes+hours(4) #this adds 4 hours (notice the hours funciton differs from hour function)
round_date(datetimes,"minute") #rounds to the nearest minute
round_date(datetimes,"5 mins")
round_date(datetimes,"5 minute")#differen ways of spelling min/minute/minutes give same result in this function
CondData <- read.csv(here("Week_05","Data","CondData.csv"))
view(CondData)
glimpse(CondData)
NewData <- CondData %>% 
  mutate(Date=mdy_hm(Date))
view(NewData)
