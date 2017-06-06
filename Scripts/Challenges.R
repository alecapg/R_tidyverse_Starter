# Morning first day challenges: challenge 6: boxplot and density2d

#box plot of life expentancy by year

ggplot(data = gapminder)+
  geom_boxplot(mapping = aes(x = as.factor(year), y = lifeExp))

ggplot(data = gapminder)+
  geom_boxplot(mapping = aes(x = as.factor(year), y = log(gdpPercap)))

ggplot(data = gapminder)+
  geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap)))

ggplot(data = gapminder)+
  geom_density2d(mapping = aes(x = lifeExp, y = log(gdpPercap), color = continent))

#callenge 7: faceting by year and making a linear fit

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))+
  geom_point()+
  geom_smooth(method = 'lm')+
  scale_x_log10()+
  facet_wrap(~ year)

#Afternoon first day challenges: challenge 1
year_lifeExp_gdp_norway <- gapminder %>% filter(country=='Norway') %>% 
  select(year,lifeExp,gdpPercap)

#challenge 2
#visual solution
gapminder %>% 
  filter(continent=='Asia') %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  ggplot(mapping = aes(x=country,y=mean_lifeExp))+
  geom_point()+ 
  coord_flip()
#now we find the max and the min
gapminder %>% 
  filter(continent=='Asia') %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  filter(mean_lifeExp==min(mean_lifeExp)|mean_lifeExp==max(mean_lifeExp))
#for Europe
gapminder %>% 
  filter(continent=='Europe') %>% 
  group_by(country) %>% 
  summarize(mean_lifeExp=mean(lifeExp)) %>%
  ggplot(mapping = aes(x=country,y=mean_lifeExp))+
  geom_point()+ 
  coord_flip()
