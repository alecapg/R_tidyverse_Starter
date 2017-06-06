# Loading the tidyverse package 

ggplot(data = gapminder)+
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp))

ggplot(data = gapminder)+
  geom_jitter(mapping = aes(x = gdpPercap, y = lifeExp, color = continent))

ggplot(data = gapminder)+
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent, size = pop))

# alpha sets the transparency, in the function eas() we specify things specific to the data and we put inside it things that vary through the data. Outside one puts the generic properties

ggplot(data = gapminder)+
  geom_point(mapping = aes(x = log(gdpPercap), y = lifeExp), alpha = 0.1, size = 2, color = 'blue')

ggplot(data = gapminder)+
  geom_line(mapping = aes(x = log(gdpPercap), y = lifeExp, group = country, color = continent))

ggplot(data = gapminder)+
  geom_line(mapping = aes(x = year, y = lifeExp, group = country, color = continent))

ggplot(data = gapminder)+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp))

# the order of the geom_... matters and it tells you the layer of visualisation

ggplot(data = gapminder)+
  geom_jitter(mapping = aes(x = continent, y = lifeExp, color = continent))+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent))

ggplot(data = gapminder)+
  geom_boxplot(mapping = aes(x = continent, y = lifeExp, color = continent))+
  geom_jitter(mapping = aes(x = continent, y = lifeExp, color = continent))

#more compactly
ggplot(data = gapminder, mapping = aes(x = continent, y = lifeExp, color = continent))+
  geom_jitter()+
  geom_boxplot(alpha = 0.4)

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp, color = continent))+
  geom_jitter(alpha = 0.2)+
  geom_smooth(method = 'lm')

#now hide the color dependence in the linear fit

ggplot(data = gapminder, mapping = aes(x = log(gdpPercap), y = lifeExp))+
  geom_jitter(mapping = aes(color = continent), alpha = 0.2)+
  geom_smooth(method = 'lm')

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))+
  geom_point()+
  geom_smooth()+
  scale_x_log10()+
  facet_wrap(~ continent)
    
ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))+
  geom_point()+
  geom_smooth(method = 'lm')+
  scale_x_log10()+
  facet_wrap(~ continent)

# now filtering the data

gapminder2007 <- filter(gapminder, year==2007)

ggplot(data = gapminder2007)+
  geom_bar(mapping = aes(x = continent))# this counts by default and use it as a y

ggplot(data = gapminder2007)+
  geom_bar(mapping = aes(x = continent), stat = 'count') # does the same thing

gapminder2007Oceania <- filter(gapminder, year==2007, continent=='Oceania')

ggplot(data = gapminder2007Oceania)+
  geom_bar(mapping = aes(x = country, y=pop), stat = 'identity') 

# the same thing can be done with geaom_col that has identity by default

ggplot(data = gapminder2007Oceania)+
  geom_col(mapping = aes(x = country, y=pop))

gapminder2007Asia <- filter(gapminder, year==2007, continent=='Asia')

ggplot(data = gapminder2007Asia)+
  geom_col(mapping = aes(x = country, y=pop))# not easy to read, let's improve

ggplot(data = gapminder2007Asia)+
  geom_col(mapping = aes(x = country, y=pop))+
  coord_flip()

# let's do something fancy

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color=continent, size = pop/10^6))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)

#now we make it more readble adding lables

ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp, color=continent, size = pop/10^6))+
  geom_point()+
  scale_x_log10()+
  facet_wrap(~ year)+
  labs(title = 'Life expectancy vs GDP per capita over time',
       subtitles = 'In the last 50 years life expectancy has improved in most countries of the world',
       caption='source: Gapminder foundation',
       x = 'GDP per capita, in “000 of $',
       y='life expentancy in years',
       color='Continent',
       size='population in milions')

#Now on can save our plot
  
ggsave('my_fancy_plot.png',path='Plots')
