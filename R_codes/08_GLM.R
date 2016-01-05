#Regresja logistyczna na train, test

glm_model = glm(Classes~., data = train, family = "binomial")
glm_pred = predict(glm_model, newdata = test, type = "response")

glm_pred_to_file <- cbind(levels(test_IDs), glm_pred)
colnames(glm_pred_to_file) <- c("id", "prediction")


if(testRunBool){
        GLM_accuracy <- sum(round(glm_pred) == test_labels)/length(test_labels)
}

