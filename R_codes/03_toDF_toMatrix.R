library(tm)

removeSparseTerms(DTM, sparse = 0.95) -> DTM95
removeSparseTerms(DTM, sparse = 0.99) -> DTM99

library(Matrix)

library("Matrix") 
mat <- sparseMatrix(i=DTM95$i, j=DTM95$j, x=DTM95$v,
												dims=c(DTM95$nrow, DTM95$ncol))
dim(mat)
colnames(mat) <- DTM95$dimnames$Terms


as.data.frame(as.matrix(mat)) -> DTM_df

save(DTM, file = "Dane/DTM.rda")
save(DTM95, file = "Dane/DTM95.rda")
save(DTM99, file = "Dane/DTM99.rda")
save(DTM_df, file = "Dane/DTM_df.rda")
save(corpus, file = "Dane/corpus.rda")
