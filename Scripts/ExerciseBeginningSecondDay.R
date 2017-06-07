library(tidyverse)

download.file(url = "https://raw.githubusercontent.com/dmi3kno/SWC-tidyverse/master/data/gapminder_plus.csv", 
              destfile = "Data/gapminder_plus.csv")

#this containes the joint data of the files on fertility and mortality

gapminder_plus <- read_csv(file = 'Data/gapminder_plus.csv')


gapminder_plus %>% 
  filter(continent=='Africa',year==2007) %>% 
  mutate(babies_dead=infantMort*pop/10^3) %>% 
  filter(babies_dead>2*10^6) %>% 
  select(country) %>% 
  left_join(gapminder_plus) %>% 
  mutate(babies_dead=infantMort*pop/10^3,gdp_bln=gdpPercap/1e9,pop_mln=pop/1e6) %>% 
  select(-c(continent,pop,babies_dead)) %>% 
  gather(key=variable,value=values, -c(country,year)) %>% 
  ggplot()+ #. plece the data dropped by the pipe in that position. In this case is superfluos since if absent it always drop it in the first position, that in this case is data
  geom_text(data=. %>% filter(year==2007) %>% group_by(variable) %>% 
              mutate(max_value=max(values)) %>%  
              filter(values==max_value),mapping=aes(x=year-10,y=values,color=country,label=country))+#the shift is for the sake of visualisation
  geom_line(mapping=aes(x=year,y=values,color=country))+
  facet_wrap(~variable,scales = 'free_y')+
  labs(title='adfd',subtitle='xc',caption='gdhs',y=NULL,x='Year')+
  theme_bw()+
  theme(legend.position = 'none')
  

