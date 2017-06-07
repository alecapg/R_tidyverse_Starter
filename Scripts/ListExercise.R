mod <- lm(lifeExp~gdpPercap, data=gapminder_plus)
str(mod)#has a very complex structure of list of lists.
mod$df.residual
#or
mod[[8]]
#or
mod[['df.residual']]
#give the same thing
mod$qr$qr[1]
str(mod$qr$qr[1])
mod$qr$qr[[1]]
str(mod$qr$qr[[1]])#in this case this is a matrix so all the things are equivalent
mod$qr$qr[1,1]

gapminder_plus %>% 
  group_by(continent) %>% 
  summarise(mean_lifeExp=mean(lifeExp),
            min_le=min(lifeExp),
            max_le=max(lifeExp))
#Now we are going to identify the outlyers in gapminder_plus. First we plot.
gapminder_plus %>% 
  ggplot()+
  geom_line(mapping = aes(x=year,y=lifeExp,group=country,color=continent))+
  geom_smooth(mapping = aes(x=year,y=lifeExp),method = 'lm')+
  facet_wrap(~continent)

by_country<-gapminder_plus %>%
  group_by(continent,country) %>% #if I dont group also by continent I lose the info
  nest()

by_country$data[[1]]#contains the data for Afganistan.
#we have subdatasets to build the linear model for each country
#map(lis,function)
library(purrr)
detach('package:maps')#the earlier loaded maps is detached because of conflicts
map(1:3, sqrt)

model_by_country1<-by_country %>% 
  mutate(model=map(data, ~lm(lifeExp~year,data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) 

model_by_country1$summr[[1]]#summary of linear model of Afganistan

#to extract info from the summary
model_by_country<-by_country %>% 
  mutate(model=map(data, ~lm(lifeExp~year,data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% 
  arrange(r.squared)
#let's visualise the problem
model_by_country %>% ggplot()+
  geom_jitter(mapping=aes(x=continent,y=r.squared))

model_by_country_small_rs<-by_country %>% 
  mutate(model=map(data, ~lm(lifeExp~year,data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% 
  arrange(r.squared) %>% filter(r.squared<.52) %>% 
  select(country) %>% 
  left_join(gapminder_plus)


model_by_country_small_rs %>% 
  ggplot()+
  geom_line(mapping = aes(x=year,y=lifeExp,group=country,color=country))

#let's repeat the exercise for the life expectancy depndence from gdpPercap
model_lifeExp_gdp<-by_country %>% 
  mutate(model=map(data, ~lm(lifeExp~log(gdpPercap),data=.x))) %>% 
  mutate(summr=map(model,broom::glance)) %>% 
  unnest(summr) %>% 
  arrange(r.squared)

model_lifeExp_gdp %>% ggplot()+
  geom_jitter(mapping=aes(x=continent,y=r.squared))

model_lifeExp_gdp_small_rs<-model_lifeExp_gdp%>% filter(r.squared<.1) %>% 
  select(country) %>% 
  left_join(gapminder_plus)

model_lifeExp_gdp_small_rs%>% 
  ggplot()+
  geom_point(mapping = aes(x=log(gdpPercap),y=lifeExp,color=country))
#all this is exploration, not statistical analysis. We are trying to identify the outliers.

#let's see how to save data. we use saveRDS is to save complex stuff that will be only readable in R
saveRDS(by_country,"Data/by_country_tibble.rds")
#to read it
my_fresh_by_country <-readRDS("Data/by_country_tibble.rds")

#to save a normal dataframe
write_csv(gapminder2007,"Data/gapminder2007.csv")

#let's put the outlyers of lifeExp~year on a map
map_data('Africa') %>% 
  head()

country_summary <- model_by_country_small_rs %>% 
  group_by(country) %>% 
  summarise(mean_lifeExp = mean(lifeExp))

map_data('world') %>% 
  rename(country=region) %>% 
  left_join(country_summary, by='country') %>%   #we will say more in the tidyr explanation about this function
  ggplot()+
  geom_polygon(aes(x=long,y=lat,group=group,fill=mean_lifeExp))+
  scale_fill_gradient(low='blue',high='red')+#sets range of colours
  coord_equal()
