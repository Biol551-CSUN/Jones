#Jesse's Penguin Group Plot Submission
library(tidyverse)
library(devtools)
library(here)
library(ggthemes)
library(palmerpenguins)
ggplot(data=penguins) +
       geom_col(mapping=aes(x=species,
           y=body_mass_g)) +
  scale_x_discrete(limits = c("Gentoo", "Adelie", "Chinstrap")) +
  labs(x="Species",
       y="Total Mass") +
  theme(panel.background=element_rect(fill="beige")) +
  ggsave(here("Week_03","output","Jesse_Group_Graph_Penguin.pdf"))