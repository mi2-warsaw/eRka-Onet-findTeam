pkgLoad("MASS")

mod_lda <- lda(Classes~., data=train)
lda_pred <- predict(mod_lda, newdata=test)$posterior[,2]

lda_pred_to_file <- cbind(levels(test_IDs), lda_pred)
colnames(lda_pred_to_file) <- c("id", "prediction")