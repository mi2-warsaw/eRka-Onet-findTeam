setwd("/Users/a/Moje/Nauka/Tabloidy/prepared_data2/docs_collection_raw//")

library(tm)
library(openNLP)
library(stringi)
filename <- "1852915256.txt"

getEndSignTable <- function(filename){

text_vector <- readChar(filename, file.info(filename)$size)
text_vector <- substring(text_vector, seq(1,nchar(text_vector),1), seq(1,nchar(text_vector),1))
text_punctuation_or_not <- regexpr(pattern="[[:punct:]]", text_vector)
text_punctuation_positions <- which(text_punctuation_or_not %in% 1)
punctuation_vector <- text_vector[text_punctuation_positions]

punctuation_table <- as.data.frame(table(punctuation_vector))
names(punctuation_table) <- c("sign", "freq")
end_sign_table <- subset(punctuation_table,punctuation_table$sign %in% c(".", "!", "?","..."))


return (end_sign_table)
}

countCoefficient <- function(end_sign_table){
number_of_end_signs <- sum(end_sign_table$freq)
exlamation_sign_table <- subset(end_sign_table,end_sign_table$sign!=".")

if(nrow(exlamation_sign_table) !=0 ) {
  number_of_exclamations <- sum(exlamation_sign_table$freq)
}else{
  number_of_exclamations <- 0
}
return(number_of_exclamations/number_of_end_signs)
}

getExclamationCoefficient <- function(filename){
  endSignTable <- getEndSignTable(filename)
  coeff <- countCoefficient(endSignTable)
  return(coeff)
}

rawFiles <- list.files(pattern="18*.txt",full.names=T,recursive=F)

for (i in 1:5) {
  coeff <- getExclamationCoefficient(rawFiles[i])
  print(coeff)
}
