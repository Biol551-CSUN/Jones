#First Laboratory Assignment with biogeochemistry data from maunalua
#Name: Jesse Jones
#Date: 2023-02-16
###Libraries###
library(tidyverse) #loads these libraries
library(here)
chemdata <- read_csv(here("Week_04","data","chemicaldata_maunalua.csv")) #reads the csv file to make a dataframe when I type "chemdata"
view(chemdata)

chemdata_lab <- chemdata %>% #makes a new dataframe
  filter(complete.cases(.)) %>% #remove NAs from dataset
  separate(col=Tide_time, #Separates Tide_time column into two separate columns
      into=c("Tide","Time"), #Name of these columns
      sep="_", #the character used to separate the column
      remove=TRUE) %>% #removes the original Tide_time column from dataframe
  filter(Tide=="High") %>% #selects for only high tide data (no low tide data)
  pivot_longer(c(Phosphate,NN), #Associates phosphate and NN data with one another? (I forgot what exactly this does)
               names_to="Variables", #name of the column with the character data of Phosphate and NN
               values_to="Values") %>% #name of the column with the values from Phosphate and NN
  group_by(Variables, Site, Temp_in, Time) %>% #groups the data from these columns together
  summarise(Mean_Values=mean(Values)) #calculates the mean of the values and creates a mean_values column
chemdata_lab %>% #loads this dataframe, then
  ggplot(aes(x=Temp_in, y=Mean_Values))+ #creates a plot in ggplot, specifying the data for x and y axes
  geom_point()+ #the kind of plot I'm creating (scatterplot)
  facet_grid(Site~Variables,scale="free") + #create subplots, organized by the variables and by the site
  labs(title="Change in Temperature by Change in Chemical Parameters During High Tide", #title of the plot
       subtitle="No Detectable Correlation", #plot subtitle
       y="Mean umol/L", x="Temperature in Situ (Celcius)")+ #x and y axis titles
  theme_light()+ #change the theme of the plot
ggsave(here("Week_04","Output","Week4b_Homework.png"), #save location and file creation
       width=11,height=8.5) #specify the length and width in inches of the file
