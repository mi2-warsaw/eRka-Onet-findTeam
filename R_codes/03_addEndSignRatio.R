getPunctuation <- function(x)
{
        x <- get("content",x)
        x <- substring(x, seq(1,nchar(x),1), seq(1,nchar(x),1))
        m <- regexpr("[[:punct:]]",x)
        regmatches(x,m)
}
getEndSignTable <- function(text_vector){
        
        if(text_vector==""){
                text_vector<-"."
        }
        text_vector <- substring(text_vector, seq(1,nchar(text_vector),1), seq(1,nchar(text_vector),1))
        text_punctuation_or_not <- regexpr(pattern="[[:punct:]]", text_vector)
        text_punctuation_positions <- which(text_punctuation_or_not %in% 1)
        punctuation_vector <- text_vector[text_punctuation_positions]
        
        punctuation_table <- as.data.frame(table(punctuation_vector))
        if(dim(punctuation_table)[1]==0){
                punctuation_table  <- as.data.frame(table(c(".")))
        }
        
        names(punctuation_table) <- c("sign", "freq")
        end_sign_table <- subset(punctuation_table,punctuation_table$sign %in% c(".", "!", "?","..."))
        if(dim(end_sign_table)[1]==0){
                end_sign_table  <- as.data.frame(table(c(".")))
                names(end_sign_table) <- c("sign", "freq")
        }
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
getTabloidSignRatio <- function(text_vector){
        endSignTable <- getEndSignTable(text_vector)
        ratio <- countRatio(endSignTable)
        return(ratio)
}

endSignRatio <-c()

for (i in 1:dim(DTM)[1]){
        text_vector <- unlist(get("content",corpusFull)[i])[1]
        endSignRatio <- c(endSignRatio, getTabloidSignRatio(text_vector))
}


otherAttributes <- cbind(otherAttributes, endSignRatio)
