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
