pkgLoad("randomForest")
pkgLoad("ROCR")
RF = randomForest(train$Classes~., data = train)
RF_pred = predict(RF, newdata = test, type = "response")

RF_pred_to_file <- cbind(levels(test_IDs), RF_pred)
colnames(RF_pred_to_file) <- c("id", "prediction")
