pkgLoad("tm")
pkgLoad("Matrix") 

removeSparseTerms(DTM, sparse = 0.95) -> DTM95
removeSparseTerms(DTM, sparse = 0.99) -> DTM99


mat <- sparseMatrix(i=DTM95$i, j=DTM95$j, x=DTM95$v, dims=c(DTM95$nrow, DTM95$ncol))
colnames(mat) <- DTM95$dimnames$Terms

as.data.frame(as.matrix(mat)) -> DTM_df

mat <- sparseMatrix(i=DTM$i, j=DTM$j, x=DTM$v, dims=c(DTM$nrow, DTM$ncol))
as.data.frame(as.matrix(mat)) -> DTM_df_full
