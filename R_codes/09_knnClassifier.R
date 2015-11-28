library("tidyr")
ESRLabels <- cbind(DTM_tagged_interpunction$Classes, DTM_tagged_interpunction$EndSignRatio)
ESRLabels <- as.data.frame(ESRLabels)
names(ESRLabels) <- c("Tabl", "Ratio")


ESRLabels %>%
	gather()->ESRLabels2

ggplot(ESRLabels, aes(factor(Tabl),Ratio) ) +
	geom_boxplot()

library("class")
library("gmodels")

trainingSet <-train_interpunction$EndSignRatio
testSet <-test_interpunction$EndSignRatio

train_labels <- train_interpunction$Classes
test_labels <- test_interpunction$Classes

test_pred <- knn(trainingSet, testSet, cl = train_labels, k=5)

CrossTable(test_labels,test_pred)

ir_z <- as.data.frame(scale(ir_r[,-5]))

ir_train <- head(ir_z,nrow(ir_z)-A)
ir_test <- tail(ir_z,A)
# re-classify test cases
ir_test_pred <- knn(ir_train, ir_test, ir_train_labels,k=9)

# Create the cross tabulation of predicted vs. actual
CrossTable(ir_test_labels,ir_test_pred)

#Percentage of well clasified cases:
sum(ir_test_labels==ir_test_pred)/A