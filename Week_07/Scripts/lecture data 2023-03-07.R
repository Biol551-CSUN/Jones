#Date: 2023-03-07
#Created By: Jesse Jones
#Lecture Script
###Load libraries
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)
###Data
popdata <- read_csv(here("Week_07","Data","CApopdata.csv"))
stars <- read_csv(here("Week_07","data","stars.csv"))
world <- map_data("world")
world
view(world)
usa <- map_data("usa")
head(usa)
italy <- map_data("italy")
head(italy)
states <- map_data("state")
head(states)
counties <- map_data("county")
ggplot()+
  geom_polygon(data=world,aes(x=long, y=lat, group=group,
                              fill=region),
                              color="darkgrey")+
  guides(fill=FALSE)+
  scale_fill_viridis_d()+
  theme(panel.background=element_rect(fill="lightblue"))+ #the fill of the background of the graph
  coord_map(projection="mercator", #changes how you view the map (what's centered, orientation, etc)
            xlim=c(-180,180)) #allows you to zoom in and out?
head(states)
CA <- states %>% 
  filter(region=="california") 
  ggplot()+
  geom_polygon(data=CA, aes(x=long, y=lat, group=group),
               color="darkgrey")
view(popdata)
CApop_county <- popdata %>% 
  select("subregion"=County, Population) %>% 
  inner_join(counties) %>% 
  filter(region=="california")
ggplot()+
  geom_polygon(data=CApop_county,
               aes(x=long,
                   y=lat,
                   group=group,
                   fill=Population),
               color="darkgrey")+
  coord_map()+
  theme_void()+
  scale_fill_gradient(trans="log2")+
  scale_fill_viridis_c()+
  geom_point(data=stars,
             aes(x=long,
                 y=lat,
                 size=star_no), alpha=.6, color="red")+
labs(size="Star Number")+
  ggsave(here("Week_07","Output","Lecture_Map.pdf"))
