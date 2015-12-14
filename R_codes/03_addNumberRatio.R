#Getting Numbers

getNumberCount <- function(text_vector){
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


numberCount <-c()

for (i in 1:dim(DTM)[1]){
        text_vector <- unlist(get("content",corpusFull)[i])[1]
        numberCount <- c(numberCount, getNumberCount(text_vector))
}

textLength <- rowSums(DTM_df_full)
numberRatio <- numberCount/textLength
otherAttributes <- cbind(otherAttributes,numberRatio)	
