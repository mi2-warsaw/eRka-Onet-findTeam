#Getting Punctuation

setwd(paste(dataToLoadPath,"docs_collection_raw/",sep=""))

pkgLoad("tm")
pkgLoad("openNLP")
pkgLoad("stringi")

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

IDListTest <- test$uuid_h2
IDListTest <- paste(IDListTest, ".txt",sep="")
ratioVectorTest <-c()

for (i in 1:length(IDListTest)){
	ratioVectorTest <- c(ratioVectorTest, getTabloidSignRatio(IDListTest[i]))
}	

otherColumnsTest <-c()

EndSignRatioTest <- ratioVectorTest
otherColumnsTest <- cbind(otherColumnsTest,EndSignRatioTest)
colnames(otherColumnsTest) <- "EndSignRatio"

IDListTrain <- train$uuid_h2
IDListTrain <- paste(IDListTrain, ".txt",sep="")
ratioVectorTrain <-c()

for (i in 1:length(IDListTrain)){
	ratioVectorTrain <- c(ratioVectorTrain, getTabloidSignRatio(IDListTrain[i]))
}	

otherColumnsTrain <-c()

EndSignRatioTrain <- ratioVectorTrain
otherColumnsTrain <- cbind(otherColumnsTrain,EndSignRatioTrain)	
colnames(otherColumnsTrain) <- "EndSignRatio"

#Getting Length
if(testRunBool){
myTest <- test %>% dplyr::select(-uuid_h2, -Classes)
}else{
	myTest <- test %>% dplyr::select(-uuid_h2)
}
sentLengthTest <- rowSums(myTest)
otherColumnsTest <- cbind(otherColumnsTest, sentLengthTest)	
colnames(otherColumnsTest)[2]<-"sentLength"

if(testRunBool){
myTrain <- train %>% dplyr::select(-uuid_h2, -Classes)
}else{
	myTrain <- train %>% dplyr::select(-uuid_h2)
}

sentLengthTrain <- rowSums(myTrain)
otherColumnsTrain <- cbind(otherColumnsTrain,sentLengthTrain)	
colnames(otherColumnsTrain)[2]<-"sentLength"


#Getting Numbers

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

######

IDListTest <- test$uuid_h2
IDListTest <- paste(IDListTest, ".txt",sep="")
numberCountVectorTest <-c()

for (i in 1:length(IDListTest)){
	numberCountVectorTest <- c(numberCountVectorTest, getNumberCount(IDListTest[i]))
}

numberRatioTest <- numberCountVectorTest/sentLengthTest
otherColumnsTest <- cbind(otherColumnsTest,numberRatioTest)	
colnames(otherColumnsTest)[3]<-"numberRatio"

IDListTrain <- train$uuid_h2
IDListTrain <- paste(IDListTrain, ".txt",sep="")
numberCountVectorTrain <-c()

for (i in 1:length(IDListTrain)){
	numberCountVectorTrain <- c(numberCountVectorTrain, getNumberCount(IDListTrain[i]))
}	

numberRatioTrain <- numberCountVectorTrain/sentLengthTrain 
otherColumnsTrain  <- cbind(otherColumnsTrain,numberRatioTrain)	
colnames(otherColumnsTrain)[3]<-"numberRatio"

additionalFeatures<-colnames(otherColumnsTest)

trainExtended <- cbind(train,otherColumnsTrain)
testExtended <- cbind(test, otherColumnsTest)

