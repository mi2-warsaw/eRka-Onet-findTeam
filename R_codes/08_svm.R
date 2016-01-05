pkgLoad("e1071")

chosenKernel <- "linear"

svm_classifier <- svm(Classes ~ ., train, type="C", kernel=chosenKernel, probability=TRUE)

svm_pred_raw <- predict(svm_classifier, test, probability=TRUE)
svm_pred <- attr(svm_pred_raw,"probabilities")[,2]

svm_pred_to_file <- cbind(levels(test_IDs), svm_pred)
colnames(svm_pred_to_file) <- c("id", "prediction")


if(testRunBool){
        svm_accuracy <- sum(round(svm_pred) == test_labels)/length(test_labels)
}
