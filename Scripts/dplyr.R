#dplyer containes methods to manipulate data, for example filter. This file contains some examples of usage of dplyr

library('tidyverse')
library('maps')

gapminder <- read_csv(file = 'Data/gapminder-FiveYearData.csv')

# ' %>% ' has the same function of '\\' in mathematica. Shortcut to %>% is shift+cmd+m

rep('This is an example',times=3)#repeat

#is the same as

'This is an example' %>% rep(times=3)

year_country_gdp <- select(gapminder,year,country,gdpPercap) # select few specified variables from the dataset
head(year_country_gdp) # shows the head of the dataset

#equivalently
year_country_gdp <- gapminder %>% select(year,country,gdpPercap)

#now we do a plot of filtered data

gapminder %>% 
  filter(year==2002) %>% 
  ggplot(mapping = aes(x=continent,y=pop))+
  geom_boxplot()

year_country_gdp_euro <- gapminder %>% filter(continent=='Europe') %>% 
  select(year,country,gdpPercap)

#group by function allows us to do that for every country

gapminder %>% group_by(continent)

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))#creates a small dataset that contains the mean of the gdp per capita.

gapminder %>% 
  summarize(mean_gdpPercap=mean(gdpPercap))#gives a unique mean for all the dataset

gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdpPercap=mean(gdpPercap)) %>%
  ggplot(mapping = aes(x=continent,y=mean_gdpPercap))+
  geom_point()
  
#Let's introduce mutate

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  head()

gapminder %>% 
  mutate(gdp_billion=gdpPercap*pop/10^9) %>% 
  group_by(continent,year) %>% 
  summarise(mean_gdp_billion=mean(gdp_billion))

#visulise the average life expenctancy on the map of the world

map_data('world') %>% 
  head()
#note that in this map the country is called region

gapminder_country_summary <- gapminder %>% 
  group_by(country) %>% 
  summarise(mean_lifeExp = mean(lifeExp))

map_data('world') %>% 
  rename(country=region) %>% 
  left_join(gapminder_country_summary, by='country') %>%   #we will say more in the tidyr explanation about this function
  ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group,fill=mean_lifeExp))+
  scale_fill_gradient(low='blue',high='red')+#sets range of colours
  coord_equal()

#The missing country are due to different lable of the country, e.g. USA and United States of America