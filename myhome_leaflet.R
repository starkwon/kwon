#leaflet 그리기
install.packages("ggmap")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("leaflet")

library(ggmap)
library(ggplot2)
library(dplyr)
library(leaflet)

register_google(key='AIzaSyD8k2DWC_7yFHCrH6LDR3RfITsmWMEqC8c')

yjhome = geocode(enc2utf8("월드컵북로38길54"), source = "google")
mk <- yjhome
cen <- c(mk$lon, mk$lat)


msg <- '<strong><a>나의 집</a></strong><hr>내가 사는 곳 ㅎㅎ</hr>'
map <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 17) %>% addTiles() %>% addCircles(lng = mk$lon, lat = mk$lat, color='green', popup = msg )
map


install.packages("htmlwidgets")
library(htmlwidgets)
saveWidget(map, file="c:/Rstudy/myhomemap.html")
