# seleckja zmiennych

pkgLoad("Boruta")
dataForBoruta <- dplyr::select(train, -Classes)
Boruta.mod <- Boruta(Classes~., data = dataForBoruta)


png("Wykresy/Boruta_selection.png", width=2000,height=800)
plot(Boruta.mod, las = "2")
#dev.off()

print(getSelectedAttributes(Boruta.mod, withTentative = TRUE)) -> importantFeatures
#cat(importantFeatures, sep=",")
allFeatures <- c(importantFeatures,additionalFeatures)
pkgLoad("dplyr")

train_Boruta <- trainExtended[,colnames(trainExtended) %in% allFeatures]
test_Boruta <- testExtended[,colnames(testExtended) %in% allFeatures]


train_Boruta <- cbind(train_Boruta, Classes=trainExtended$Classes)
train_labels <- trainExtended$Classes

if(testRunBool){
	test_labels <- testExtended$Classes
}