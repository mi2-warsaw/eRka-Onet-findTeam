#Getting Punctuation

setwd("/Users/a/Moje/Nauka/Tabloidy/prepared_data2/docs_collection_raw//")

library(tm)
library(openNLP)
library(stringi)

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

countRatio <- function(end_sign_table){
number_of_end_signs <- sum(end_sign_table$freq)
tabloid_sign_table <- subset(end_sign_table,end_sign_table$sign!=".")

if(nrow(tabloid_sign_table) !=0 ) {
  number_of_tabloid_signs <- sum(tabloid_sign_table$freq)
}else{
  number_of_tabloid_signs <- 0
}
return(number_of_tabloid_signs/number_of_end_signs)
}

getTabloidSignRatio <- function(filename){
  endSignTable <- getEndSignTable(filename)
  ratio <- countRatio(endSignTable)
  return(ratio)
}

setwd("/Users/a/Moje/Nauka/Tabloidy/prepared_data2/docs_collection_raw/")

IDList <- train$uuid_h2
IDList <- paste(IDList, ".txt",sep="")
ratioVector <-c()

for (i in 1:length(IDList)){
	ratioVector <- c(ratioVector, getTabloidSignRatio(IDList[i]))
}	

otherColumns <-c()

EndSignRatio <- ratioVector
otherColumns <- cbind(otherColumns,EndSignRatio)	

setwd("/Users/a/eRka-Onet-findTeam/")
save(test_interpunction,file="Dane/test_interpunction.rda")
save(train_interpunction,file="Dane/train_interpunction.rda")



#Getting Length
myDTM <- DTM_tagged %>% select(-uuid_h2, -Tags)
sentLength <- rowSums(myDTM)
otherColumns <- cbind(otherColumns,sentLength)	


#Getting Numbers
setwd("/Users/a/Moje/Nauka/Tabloidy/prepared_data2/docs_collection_raw//")

getNumberCount <- function(filename){
	
	text_vector <- readChar(filename, file.info(filename)$size)
	text_vector <- substring(text_vector, seq(1,nchar(text_vector),1), seq(1,nchar(text_vector),1))
	text_number_or_not <- regexpr(pattern="[[:digit:]]", text_vector)
	text_number_positions <- which(text_number_or_not %in% 1)
	number_vector <- text_vector[text_number_positions]
	
	number_table <- as.data.frame(table(number_vector))
	if(dim(number_table)[1]==0){
		return(0)
	}
	else{
	names(number_table) <- c("number", "count")
	countSum <- sum(number_table$count)
	return (countSum)
	}
}


myfname = "1852551900.txt"

getNumberCount(myfname)

IDList <- DTM_tagged$uuid_h2
IDList <- paste(IDList, ".txt",sep="")
numberCountVector <-c()

for (i in 1:length(IDList)){
	numberCountVector <- c(numberCountVector, getNumberCount(IDList[i]))
}	

numberRatio <- numberCountVector/sentLength
otherColumns <- cbind(otherColumns,numberRatio)	
