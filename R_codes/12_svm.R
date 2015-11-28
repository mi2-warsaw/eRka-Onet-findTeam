library(kernlab)
library(e1071)

chosenKernel <- "linear"

svm_classifier <- svm(Classes ~ ., train_Boruta, type="C", kernel=chosenKernel, probability=TRUE)

test_pred_raw <- predict(svm_classifier, test_Boruta, probability=TRUE)
test_pred_prob <- attr(test_pred_raw,"probabilities")[,2]
test_pred <- ifelse(test_pred_prob>0.5,1,0)
sum(test_pred == test_labels)/length(test_labels)

save(test_pred_prob,file="Dane/svm_test_Boruta.rda")
