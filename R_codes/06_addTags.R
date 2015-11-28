library(dplyr)
tags = read.table("EXAMPLES_participants.txt", sep = ";")
ID = DTM$dimnames$Docs
ID = gsub(pattern = ".txt.bas", replacement = "", x = ID)
DTM_df$uuid_h2 = ID
DTM_df$uuid_h2 = as.factor(DTM_df$uuid_h2)
colnames(tags) = c("uuid_h2", "Tags")
tags$uuid_h2 = as.factor(tags$uuid_h2)
DTM_tagged = inner_join(DTM_df, tags, by = "uuid_h2")

Tags_table <- table(DTM_tagged$uuid_h2, as.character(DTM_tagged$Tags))

Classes<-apply(as.matrix(Tags_table),MARGIN = 1, function(x){ifelse(x[1]>x[2],0,ifelse(x[1]==x[2],NA,1))})

table(Classes,useNA = "always")

cos <- data.frame(names(Classes),Classes)
inner_join(DTM_tagged, cos, by = c("uuid_h2"="names.Classes."))%>%
	filter(!is.na(Classes)) %>% 
	select(-Tags) %>%
	unique()->DTM_tagged_clean