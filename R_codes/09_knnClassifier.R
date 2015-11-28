#Checking the meaning of the interpunction
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

boruta_full <- rbind(train_Boruta, test_Boruta)

train_labels <- train_Boruta$Classes
test_labels <- test_Boruta$Classes

test_pred <- knn(train_Boruta, test_Boruta, cl = train_labels, k=5)

CrossTable(test_labels,test_pred)

train_Boruta %>% select(-Classes) -> train_Boruta_scaled

train_Boruta_scaled <- scale(train_Boruta_scaled)
attrs <- attributes(train_Boruta_scaled)
scale_center <- attr(train_Boruta_scaled,"scaled:center")
scale_scale <- attr(train_Boruta_scaled,"scaled:scale")
train_Boruta_scaled <- as.data.frame(train_Boruta_scaled)

test_Boruta %>% select(-Classes) -> test_Boruta_scaled
test_Boruta_scaled <- scale(test_Boruta_scaled, scale = scale_scale, center = scale_center)


test_pred_scaled <- knn(train_Boruta_scaled, test_Boruta_scaled, train_labels,k=5)

# Create the cross tabulation of predicted vs. actual
CrossTable(test_pred_scaled,test_labels)

#Percentage of well clasified cases:
sum(test_labels==test_pred)/length(test_labels)
sum(test_labels==test_pred_scaled)/length(test_labels)



