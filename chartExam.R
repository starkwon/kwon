install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)

#1
click <- read.table("product_click.log")
ct = table(click$V2)
png(filename="clicklog1.png", height=400, width=700, bg="white")
par(mar=c(5,5,5,5), mfrow=c(1,1)) 
barplot(ct,main="세로바 그래프 실습", xlab="상품ID",ylab="클릭수",col=terrain.colors(10))
dev.off() 


#2
st = strptime(click$V1, "%Y%m%d%H%M")
fm = format(st, "%H")
tb = table(fm)
View(tb)
png(filename="clicklog2.png", height=400, width=700, bg="white")
pie(tb,labels=paste(as.numeric(rownames(tb)) ,"~", as.numeric(rownames(tb))+1),col=rainbow(17), main="파이그래프실습")
dev.off() 

