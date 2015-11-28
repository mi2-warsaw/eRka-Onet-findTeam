#Regresja logistyczna na train, test

library(ROCR)
Glin_base = glm(Classes~., data = train[,c(1:347,349)], family = "binomial")
GLpred = predict(object = Glin_base, newdata = test, type = "response")

library(glmnet)



apply(z, MARGIN = 2, function(x) as.numeric(as.character(x))) -> z2
as.matrix(train[,-c(349,350)]) -> z
y <- as.factor(as.character(train$Classes))
colnames(z) <- paste0("a", colnames(z))
Glin_best = cv.glmnet(x = z2,
											y = as.character(y),
											family = "binomial")
c = as.matrix(test[,-c(349,350)])
d <- as.factor(as.character(test$Classes))
apply(c, MARGIN = 2, function(x) as.numeric(as.character(x))) -> c2



Glin_best_pred = predict(Glin_best, newx = c2, s="lambda.min", type="response")
prediction = prediction(Glin_best_pred, as.numeric(test$Classes))
performance = performance(prediction, "tpr", "fpr")
plot(performance)
table(test$Classes, Glin_best_pred>0.3)

#Regresja logistyczna na train_Boruta, test_Boruta
Bor_glm = glm(Classes~., data = train_Boruta[,1:23], family = "binomial")
Bor_pred = predict(Bor_glm, newdata = test_Boruta, type = "response")
Bor_prediction = prediction(Bor_pred, as.numeric(test_Boruta$Classes))
Bor_perf= performance(Bor_prediction, "tpr", "fpr")
plot(Bor_perf)
table(Bor_pred>0.55, test_Boruta$Classes)
performance(Bor_prediction, "auc")@y.values[[1]]

GLM_Boruta = data.frame(Id = test$uuid_h2, Prediction = Bor_pred)
write.csv(x = GLM_Boruta, file = "Predykcje/GLM")


Glin_best_Bor = cv.glmnet(x = as.matrix(train_Boruta[,1:22]),
											y = train_Boruta$Classes,
											family = "binomial")
apply(as.matrix(test_Boruta[,1:22]), MARGIN = 2, function(x) as.numeric(as.character(x))) -> x2
Glin_best_pred_Bor = predict(Glin_best_Bor, newx = x2, s="lambda.min", type="response")
predictionBor = prediction(Glin_best_pred_Bor, as.numeric(test_Boruta$Classes))
performance = performance(predictionBor, "tpr", "fpr")
plot(performance)
performance(predictionBor, "auc")@y.values[[1]] #Użycie cv.glmnet niewiele zmienia




