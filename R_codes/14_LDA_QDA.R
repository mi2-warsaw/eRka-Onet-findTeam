load('Dane/train.rda')
load('Dane/train_interpunction.rda')
load('Dane/train_Boruta.rda')
load('Dane/test.rda')
load('Dane/test_interpunction.rda')
load('Dane/test_Boruta.rda')

library(MASS)
mod_lda_train <- lda(Classes~., data=train[,-c(11, 65, 152,348)])
mod_lda_train_interpunction <- lda(Classes~., data=train_interpunction[,-c(11, 65, 152,348)])
mod_lda_train_interpunction_Boruta <- lda(Classes~.,
																					data=train_Boruta)
lda_test <- predict(mod_lda_train, newdata=test[,-c(11, 65, 152,348)])$posterior[,2]
lda_test_interpunction <- predict(mod_lda_train_interpunction, newdata=test_interpunction[,-c(11, 65, 152,348)])$posterior[,2]
lda_test_interpunction_Boruta <- predict(mod_lda_train_interpunction_Boruta, newdata=test_Boruta)$posterior[,2]

save(lda_test, file = "Predykcje/lda_test.rda")
save(lda_test_interpunction, file = "Predykcje/lda_test_test.rda")
save(lda_test_interpunction_Boruta, file = "Predykcje/lda_test_test_Boruta.rda")
