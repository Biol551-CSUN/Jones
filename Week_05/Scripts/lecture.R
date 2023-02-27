#Lecture code 2023-02-21
#Created By: Jesse Jones
#Date: 2023-02-21
###Libraries
library(tidyverse)
library(here)
###Data
EnviroData <- read_csv(here("Week_05","data","site.characteristics.data.csv"))
TPCData <- read_csv(here("week_05","data","Topt_data.csv"))
EnviroData_Wide <- EnviroData %>% 
  pivot_wider(names_from=parameter.measured, #pivot data wider
              values_from=values) %>% 
  arrange(site.letter)  #arrange dataframe by site
  FullData_Left <- left_join(TPCData,EnviroData_Wide) %>% 
    relocate(where(is.numeric),.after=where(is.character)) #relocate the numerical columns and place them after the the character columns
  TPS <- FullData_Left %>% 
    pivot_longer(c(E,Eh,lnc,Th,Topt,light,temp,NH4,N.N,P,DIN_DIP,N,trap.accumulation.rate,CCA.cover,algal.cover,p.acuta.cover,coral.cover,substrate.cover),
                 names_to="Variables",
                 values_to="Values") %>% 
    group_by(site.letter, Variables) %>% 
    summarise(mean=mean(Values, na.rm=TRUE),
              variance=var(Values,na.rm=TRUE))
  TTemp <- tibble(Site.ID=c("A","B","C","D"),
               Temperature=c(14.1,16.7,15.3,12.8))
  TpH <- tibble(Site.ID=c("A","B","D","E"),
  pH=c(8.8,7.2,9.3,4.0))
  Left_Tibble <- left_join(TTemp, TpH)
  Right_Tibble <- right_join(TTemp, TpH)
Inner_Tibble <- inner_join(TpH,TTemp) #drops any rows with missing data between/among data sets
Full_Tibble <- full_join(TpH,TTemp) #keeps all data rows, places NAs where missing data occurs between/among the dataframes
view(Inner_Tibble)
view(Full_Tibble)
#semi_join Idk what this does
#anti_join - keeps only missing info between/among data sets
install.packages("cowsay")
library(cowsay)
say("poopie","random")

