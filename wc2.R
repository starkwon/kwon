library(dplyr)
library(KoNLP)
install.packages("wordcloud2")
library(wordcloud2)
install.packages("htmlwidgets")
library(htmlwidgets)

useSejongDic()
data <- readLines("c:/Rstudy/yes24.txt")


data <- sapply(data, extractNoun, USE.NAMES = F)
data
undata <- unlist(data)
undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
word_table2 <- as.data.frame(table(undata2))

result<-wordcloud2(word_table2, minSize=10, rotateRatio = 1, size=0.8, backgroundColor = "black")
saveWidget(result,"wc.html",title="WORDCLOUD2 실습", selfcontained = F)
