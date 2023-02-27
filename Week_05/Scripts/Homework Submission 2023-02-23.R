#Lab Homework 2023-02-23
#Created By: Jesse Jones
#Date Created: 2023-02-23
###Libraries
library(here)
library(tidyverse)
library(lubridate) #loads these libraries
#Data & Script
CondData <- read_csv(here("Week_05","Data","CondData.csv"))
DepthData <- read_csv(here("Week_05","Data","DepthData.csv")) #creates a function for reading these csv files
Depth <- DepthData %>% 
  mutate(date=ymd_hms(date)) #adds this column, reads the data as a date rather than character

Cond <- CondData %>% #creates function "Cond", loads CondData dataframe
  mutate(date=mdy_hms(date), #adds this date column, transfers characters to standard date format
date=round_date(date,"10 seconds"))  #rounds to the nearest 10-second interval for each time point

Cond_Depth <- inner_join(Cond,Depth) %>% #joins cond & depth data, only retaining matching and complete data categories that are found in both dataframes
  mutate(Hour=hour(date)) %>% #creates an hour column, selecting only for the hour per date?
  mutate(Date_Minute=round_date(date, "minute"), #creates a date column rounded to the nearest minute 
  By_minute=minute(Date_Minute)) %>% #only the minutes from the "Date_Minute" column are retained in this "By_Minute" column
  pivot_longer(c(Temperature, Depth, Salinity), #pivots these data categories longer, so that a column represents all these values per their corresponding variable
               names_to="Variables", #name of the column of the character categories of temp, dpeth, salinity to a "Variables" column
               values_to="Values") %>%  #name of the column for the values associated with each variable
  group_by(Date_Minute, Variables, By_minute) %>% #Groups my data by the date (rounded to the nearest mintue), its corresponding minute, and the "Variables" column
  summarise(Mean=mean(Values)) #Creates a column of mean values for each value per minute?? (ask for help/clarity)

view(Cond_Depth)
Cond_Depth %>% ggplot(aes(x=Date_Minute,y=Mean,
                      color=Variables))+
  geom_smooth()+
  facet_wrap(~Variables,scales="free")+
  labs(x="Minute", title= "Average Values per Minute")+
  ggsave(here("Week_05", "Output", "Homework_Graph.png"), width=12, height=8)