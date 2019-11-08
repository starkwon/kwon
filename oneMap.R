# leaflet과 우리나라 행정구역 지도 활용
# # RStudio 를 재기동한다.
install.packages("devtools") 
devtools::install_github("cardiomoon/Kormaps")
library(Kormaps)

library(ggmap)
library(ggplot2)
library(dplyr)
library(leaflet)

DONG<-read.csv('c:/RStudy/one.csv')
head(DONG)
data(korpopmap3)
Encoding(names(korpopmap3))<-'UTF-8'
Encoding(korpopmap3@data$name_eng)<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'

korpopmap3@data<-korpopmap3@data[c(1:18),] 
korpopmap3@polygons<-korpopmap3@polygons[c(1:18)] 

korpopmap3@data$name<-gsub('·','',korpopmap3@data$name) 
colnames(DONG)<-c('구별','name','일인가구')
dong<- DONG %>%filter(구별=='종로구')

korpopmap3@data<-merge(korpopmap3@data,dong,by.x='name',sort=FALSE)
mymap <- korpopmap3@data
mypalette <- colorNumeric(palette ='RdYlBu' , domain = mymap$'일인가구')
mypopup <- paste0(mymap$name,'<br> 1인가구: ',mymap$'일인가구')

map10 <- NULL
map10 <-leaflet(korpopmap3) %>% 
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
map10	

install.packages("htmlwidgets")
library(htmlwidgets)
saveWidget(map10, file="c:/Rstudy/onemap.html")