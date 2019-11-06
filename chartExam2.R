#1
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)

mpg <- as.data.frame(ggplot2::mpg)
plot(mpg$cty, mpg$hwy, xlab="도시연비", ylab="고속도로연비", xlim=c(10, 35), ylim=c(15, 45),type="p", pch=3, lty=0)


#2
drt = table(mpg$drv)
barplot(drt, col = rainbow(3))

#3
par(xpd=T, mar=par()$mar+c(0,0,0,1));   
boxplot(hwy~manufacturer,data=mpg, las = 2, xlab="", ylab="고속도로연비", ylim=c(5,40), cex.axis=0.8, col=heat.colors(15))
title(main = "*제조사별 고속도로 연비*", col.main="purple")