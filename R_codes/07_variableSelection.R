# seleckja zmiennych

pkgLoad("Boruta")
pkgLoad("dplyr")
dataForBoruta <- train[!(colnames(train) %in% colnames(otherAttributes))]
dataForBoruta <- dplyr::select(dataForBoruta, -Classes)
dataForBoruta <- dplyr::select(dataForBoruta, -uuid_h2)
dataForBoruta <- dataForBoruta[complete.cases(dataForBoruta), ]
Boruta.mod <- Boruta(Classes~., data = dataForBoruta)


png("Wykresy/Boruta_selection.png", width=2000,height=800)
plot(Boruta.mod, las = "2")
#dev.off()

print(getSelectedAttributes(Boruta.mod, withTentative = TRUE)) -> importantFeatures
#cat(importantFeatures, sep=",")
allFeatures <- c(importantFeatures,colnames(otherAttributes),"Classes")


train_Boruta <- train[,colnames(train) %in% allFeatures]
test_Boruta <- test[,colnames(test) %in% allFeatures]

train_labels <- train_Boruta$Classes

if(testRunBool){
	test_labels <- test$Classes
}
