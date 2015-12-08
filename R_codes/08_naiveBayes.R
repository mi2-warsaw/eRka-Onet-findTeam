pkgLoad("e1071")

bayes <- naiveBayes(Classes~.,data=train, laplace=0.2)
bayes_pred <- predict(bayes, newdata=test, type="raw")[,2]

bayes_pred_to_file <- cbind(levels(test_IDs), bayes_pred)
colnames(bayes_pred_to_file) <- c("id", "prediction")