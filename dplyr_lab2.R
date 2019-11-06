install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

#1-1
nrow(mpg)
ncol(mpg)

#1-2
head(mpg, 10)

#1-3
tail(mpg, 10)

#1-4
View(mpg)

#1-5
summary(mpg)

#1-6
str(mpg)


#2
mpg = rename(mpg, "city" = "cty", "highway" = "hwy")
mpg %>%
  select(city, highway)

#3-1
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)

#3-2
midwest = rename(midwest, "total" = "poptotal", "asian" = "popasian")
View(midwest)

#3-3
midwest = midwest %>%
  mutate(asianpertotal = (asian/total)*100) 
View(midwest)

#3-4
meanasian = midwest %>%
summarise(mean(asianpertotal))

midwest = midwest %>%
  mutate(grade = ifelse(asianpertotal > meanasian[,1], "large", "small"))

#4-1
View(mpg)
meanhwy = mpg %>%
  summarise(mean(highway))

mpg %>%
  filter(displ >= 5 | displ <= 4) %>%
  mutate(g= ifelse(displ>=5, "5이상", "4이하")) %>% 
  group_by(g) %>% 
  summarise(meanhwy = mean(highway))
  
#4-2
audicity = mpg %>%
  filter(manufacturer == "audi") %>%
   summarise(mean(city))

toyotacity = mpg %>%
  filter(manufacturer == "toyota") %>%
  summarise(mean(city))

win = ifelse(audicity[,1] > toyotacity[,1], "audi", "toyota")

#4-3
chevolethgy = mpg %>%
  filter(manufacturer == "chevrolet") %>%
  summarise(mean(highway))

fordhgy = mpg %>%
  filter(manufacturer == "ford") %>%
  summarise(mean(highway))

hondahgy = mpg %>%
  filter(manufacturer == "honda") %>%
  summarise(mean(highway))

chevolethgy 
fordhgy
hondahgy

#5-1
mpg %>% select(class, city)

#5-2
suvcty = mpg %>%
  filter(class == "suv") %>%
  summarise(mean(city))

compactcty = mpg %>%
  filter(class == "compact") %>%
  summarise(mean(city))

classwin = ifelse(suvcty[,1] < compactcty[,1], "compactcty", "suvcty")

#6-1
audihwy = mpg %>%
  filter(manufacturer == "audi") %>%
  arrange(desc(highway))
audihwy[1,2]

#6-2
head(audihwy,5)


