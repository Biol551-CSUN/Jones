#Homework Using Pipe
#Created By: Jesse Jones
#Date: 2023-02-14
##Libraries##
library(tidyverse) #loads this library
library(palmerpenguins)
library(here)
library(ggplot2)
library(ggthemes)
##Data##
bodymassdata <- penguins %>% #assigns this text to the function I am creating
  drop_na(sex, body_mass_g) %>% #removes all data from rows that are missing sex
  group_by(species, island, sex) %>% #sets which columns we will summarize
  summarise(mean_mass=mean(body_mass_g, na.rm=TRUE),#calculates and adds a row of mean body bass
                       var_mass=var(body_mass_g, na.rm=TRUE))#includes variance of body mass in our data
view(bodymassdata) #view dataframe that I've created from palmerpenguins
plotdata <- penguins%>% #assigns a function to this text entry
  filter(sex=="female") %>% #selects for only female; excludes males
mutate(log_mass=log(body_mass_g)) %>% #adds a new column
summarise(Species=species,Island=island,Sex=sex, Log_Mass=log_mass) #selects only these listed columns
view(plotdata) #check/view my data that I will be plotting
ggplot(data=plotdata, #loads the "plotdata" dataframe for plotting
       mapping=aes(x=Island,y=Log_Mass, #assigns Island column to x axis and Log_Mass to y axis
       group=Species, #creates a group for the Species column
       color=Species)) + #assigns the Species group members different colors
geom_point() + #the type of graph I want to make
  labs(y="Log of Body Mass (grams)", title="Female Penguins - Island by Log of Body Mass and Species") + #changes the y axis title and graph title
scale_color_viridis_d() + #changes the color for colorblind persons
  theme_light() #changes the theme of the graph to a solid white
ggsave(here("Week_04","output","Female Penguins_Island by Body Mass and Species.png"))