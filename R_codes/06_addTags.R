library(dplyr)
tags = read.table("EXAMPLES_participants.txt", sep = ";")
ID = DTM$dimnames$Docs
ID = gsub(pattern = ".txt.bas", replacement = "", x = ID)
DTM_df$uuid_h2 = ID
DTM_df$uuid_h2 = as.factor(DTM_df$uuid_h2)
colnames(tags) = c("uuid_h2", "Tags")
tags$uuid_h2 = as.factor(tags$uuid_h2)
DTM_tagged = inner_join(DTM_df, tags, by = "uuid_h2")

