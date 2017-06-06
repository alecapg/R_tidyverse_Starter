library('tidyverse')
library('readxl')

gapminder <- read_csv(file = 'Data/gapminder-FiveYearData.csv')
# gapminder data are organised in a tidy format.

#the following sintax work just on mac. On other operating systems one should have two separate download.file or worse one should directly download them from the server gapminder.

download.file(url = c("http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0TAlJeCEzcGQ&output=xlsx", 
                      "http://docs.google.com/spreadsheet/pub?key=phAwcNAVuyj0NpF2PTov2Cw&output=xlsx"), 
              destfile = c("Data/indicator undata total_fertility.xlsx", 
                           "Data/indicator gapminder infant_mortality.xlsx"))

raw_fert <- read_excel(path='Data/indicator undata total_fertility.xlsx',sheet='Data')
#raw fertility data are in a wide format.
raw_infantMort <-read_excel(path='Data/indicator gapminder infant_mortality.xlsx')
#raw infant mortality are wide.

#we can make our data tidy by using gather

fert <- raw_fert %>% 
  rename(country=`Total fertility rate`) %>% 
  gather(key=year,value=fert,-country) %>%  
  mutate(year=as.integer(year))
