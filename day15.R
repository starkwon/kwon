# leaflet과 우리나라 행정구역 지도 활용
# # RStudio 를 재기동한다.
install.packages("devtools") 
devtools::install_github("cardiomoon/Kormaps")
library(Kormaps)

library(ggmap)
library(ggplot2)
library(dplyr)
library(leaflet)



names(korpopmap1)
names(korpopmap2)
names(korpopmap3)
Encoding(names(korpopmap1))<-'UTF-8'
Encoding(names(korpopmap2))<-'UTF-8'
Encoding(names(korpopmap3))<-'UTF-8'
names(korpopmap1)
names(korpopmap2)
names(korpopmap3)

head(korpopmap1,1)
head(korpopmap2,1)
head(korpopmap3,1)

Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8'

korpopmap2@data <- korpopmap2@data[-26:-251,]
korpopmap2@polygons<-korpopmap2@polygons[-26:-251]
mymap <- korpopmap2@data
head(mymap)
View(korpopmap2)

crime <- read.csv('c:/Rstudy/2017crime.csv')
head(crime)
palette1<-colorNumeric(palette = 'Oranges', domain = crime$살인_발생)
popup1 <- paste0(mymap$name,'<br> 살인 : ',crime$살인_발생, '건')
map4<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup1, color=~palette1(crime$살인_발생), group='살인')
map4


palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(mymap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map5<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력')
map5


palette3<-colorNumeric(palette = 'Reds', domain = crime$범죄_발생_총합)
popup3 <- paste0(mymap$name,'<br> 범죄_발생_총합 : ',crime$범죄_발생_총합, '건')
map6<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')

map6

palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(mymap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map8<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력') %>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')
#중복되게 작성. 하지만 팝업은 마지막 범죄 발생 총합이 뜸
map8

DONG<-read.csv('c:/RStudy/one.csv')
head(DONG)
data(korpopmap3)
Encoding(names(korpopmap3))<-'UTF-8'
Encoding(korpopmap3@data$name_eng)<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'

korpopmap3@data<-korpopmap3@data[c(67:81),] 
korpopmap3@polygons<-korpopmap3@polygons[c(67:81)] 

korpopmap3@data$name<-gsub('·','',korpopmap3@data$name) 
colnames(DONG)<-c('구별','name','일인가구')
dong<- DONG %>%filter(구별=='광진구')

korpopmap3@data<-merge(korpopmap3@data,dong,by.x='name',sort=FALSE)
mymap <- korpopmap3@data
mypalette <- colorNumeric(palette ='RdYlBu' , domain = mymap$'일인가구')
mypopup <- paste0(mymap$name,'<br> 1인가구: ',mymap$'일인가구')

map7 <- NULL
map7<-leaflet(korpopmap3) %>% 
  addTiles() %>% 
  setView(lat=37.52711, lng=126.987517, zoom=12) %>%
  addPolygons(stroke =FALSE,
              smoothFactor = 0.2,
              fillOpacity = .9,
              popup = mypopup,
              color = ~mypalette(mymap$일인가구)) %>% 
  addLegend( values = ~mymap$일인가구,
             pal =mypalette ,
             title = '인구수',
             opacity = 1)
map7	

#install.packages("htmlwidgets")
#library(htmlwidgets)
saveWidget(map7, file="m.html")


library(ggplot2)
ggplot(data = iris, aes(x = Petal.Width, y= Petal.Length, col=Species)) + geom_point() 
ggsave("ggtest.png")


install.packages("leaflet")
library(leaflet)

View(quakes)
str(quakes)

data = quakes[1:20,]
leaflet() %>% addTiles() %>%
  addMarkers(data$long, data$lat, popup = paste("지진 강도 : ",as.character(data$mag)), label = as.character(data$mag))


getColor <- function(quakes) {
  result <- sapply(quakes$mag, function(mag) {
    if(mag <= 4) {
      "green"
    } else if(mag <= 5) {
      "orange"
    } else {
      "red"
    } })
  return(result)
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(data)
)

leaflet() %>% addTiles() %>%
  addAwesomeMarkers(data$long, data$lat, icon=icons, label = as.character(data$mag))


#install.packages("RColorBrewer")
library(RColorBrewer)

for(col_i in c('YlGn','RdPu', 'PuRd', 'BrBG', 'RdBu', 'RdYlBu', 'Set3', 'Set1')){
  print(col_i)
  print(brewer.pal(n = 5, name = col_i))
}

#
