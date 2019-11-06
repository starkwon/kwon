install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)

#7-1
mpg$hwycty = mpg$hwy + mpg$cty
#7-2
mpg$mhwycty = mpg$hwycty/2
#7-3
mpg %>% 
  arrange(desc(mhwycty)) %>% 
  head(3)
#7-4
mpg %>%
 mutate(mm=(mpg$hwy+mpg$cty)/2)%>%
  group_by(mm)%>%
  arrange(desc(mm)) %>% 
  head(3)

#8-1
mpg %>% 
  group_by(class) %>% 
  summarise(mean(cty))
#8-2
mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))
#8-3
mpg %>% 
  group_by(manufacturer) %>% 
  summarise(mean_hwy = mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3) 
#8-4
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))

#9-1
fuel = data.frame(fl = c("c","d","e","p","r"),
                  price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22),
                  stringsAsFactors = F)
fuel
mpg_new <- left_join(mpg, fuel, by = "fl")

#9-2
mpg_new %>% 
  head(5)

#10-1
midwest <- as.data.frame(ggplot2::midwest)
midwest$nonadult = {1-(midwest$popadults/midwest$poptotal)}*100

#10-2
midwest %>% 
  arrange(desc(nonadult)) %>% 
  select(county, nonadult) %>% 
  head(5) 
  
#10-3
midwest$crit = ifelse(midwest$nonadult>40, "large",
                      ifelse(midwest$nonadult <40&midwest$nonadult>=30, "middle","small"))

#10-4
midwest$asiantot = (midwest$popasian/midwest$poptotal)*100
midwest %>% 
  arrange(asiantot) %>% 
  select(state,county,asiantot) %>% 
  head(10)
  
#11-1
mpg = as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212), "hwy"] <- NA
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

#11-2
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

#12-1
mpg = as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"]<-"k"
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42)
mpg$drv <- ifelse(mpg$drv == "k", NA, mpg$drv)
table(is.na(mpg$drv))

#12-2
boxplot(mpg$cty)
mpg$cty = ifelse(mpg$cty >= 9 & mpg$cty <= 26, mpg$cty, NA)
boxplot(is.na(mpg$cty))

#12-3
mpg %>% 
  filter(!is.na(drv) & !is.na(cty)) %>% 
  group_by(drv) %>% 
  summarise(mean(cty))