library(dplyr)

install.packages("KoNLP")
install.packages("rlang")
library(KoNLP)

useSystemDic()
useSejongDic()
useNIADic()

word_data <- readLines("c:/Rstudy/공구.txt")
word_data
Encoding(word_data)<-'UTF-8'
View(word_data)
word_data = gsub("[[:digit:]]", "", word_data)
word_data = gsub("[A-Z]", "", word_data)
word_data = gsub("[a-z]", "", word_data)
word_data = gsub("공구.", "", word_data)
word_data = gsub("[[:punct:]]", "", word_data)
word_data = gsub("ㅜ", "", word_data)
word_data = gsub("요", "", word_data)
word_data = gsub("부탁", "", word_data)
word_data = gsub("해주", "", word_data)
word_data = gsub("세요", "", word_data)
word_data = gsub("ㅏ", "", word_data)
word_data = gsub("", "", word_data)

word_data = word_data[word_data!=""]

useSejongDic()
word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F)
word_data2
word_data3 <- extractNoun(word_data)
word_data3

undata <- unlist(word_data2)
undata2 <- Filter(function(x) {nchar(x) >= 2& nchar(x) <= 5}, undata)
word_table2 <- as.data.frame(table(undata2))

install.packages("wordcloud")
library(wordcloud)


windowsFonts(lett=windowsFont("휴먼옛체"))
wordcloud(word_table2$undata2, word_table2$Freq, family="lett",
min.freq = 2, 
random.order = FALSE, 
rot.per = 0.4, scale = c(1, 1), 
colors = rainbow(7))