setwd(mainPath)
pkgLoad("dplyr")
tags = read.table(paste(dataToLoadPath,"/EXAMPLES_participants.txt",sep=""), sep = ";")
ID = DTM$dimnames$Docs
ID = gsub(pattern = ".txt.bas", replacement = "", x = ID)
attributes_matrix$uuid_h2 = ID
attributes_matrix$uuid_h2 = as.factor(attributes_matrix$uuid_h2)
colnames(tags) = c("uuid_h2", "Tags")
tags$uuid_h2 = as.factor(tags$uuid_h2)
data_tagged = inner_join(attributes_matrix, tags, by = "uuid_h2")

Tags_table <- table(data_tagged$uuid_h2, as.character(data_tagged$Tags))

Classes<-apply(as.matrix(Tags_table),MARGIN = 1, function(x){ifelse(x[1]>x[2],0,ifelse(x[1]==x[2],NA,1))})

table(Classes,useNA = "always")

IDs_and_Classes <- data.frame(names(Classes),Classes)

inner_join(data_tagged, IDs_and_Classes, by = c("uuid_h2"="names.Classes.")) %>%
	filter(!is.na(Classes)) %>% 
	dplyr::select(-Tags) %>%
	unique()->data_tagged_clean

data_tagged_clean$uuid_h2 <- as.factor(data_tagged_clean$uuid_h2)
