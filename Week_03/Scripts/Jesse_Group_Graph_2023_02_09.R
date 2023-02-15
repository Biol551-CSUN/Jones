#Jesse's Penguin Group Plot Submission
#Created By: Jesse Jones
#Date: 2023-02-14
###Libraries###
library(tidyverse)
library(devtools)
library(here)
library(ggthemes)
library(palmerpenguins)
ggplot(data=penguins) + #creates a plot in ggplot using the penguins dataframe
       geom_col(mapping=aes(x=species, #specifies which kind of graph I will make and assigns the species column and its components to the x axis
           y=body_mass_g)) + #assigns the body_mass_g column and values to the y axis
  scale_x_discrete(limits = c("Gentoo", "Adelie", "Chinstrap")) + #I'm not sure where I got this from or what it does. I think it orders the members along my x axis in the way I typed it rather than alphabetically.
  labs(x="Species", #gives x axis the title in quotes
       y="Total Mass") + #gives y axis the title in quotes
  theme(panel.background=element_rect(fill="beige")) + #changes the graph background color
  ggsave(here("Week_03","output","Jesse_Group_Graph_Penguin.pdf")) #saves my file to my week_03/output folders as a PDF