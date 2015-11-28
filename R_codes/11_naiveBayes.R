load('Dane/train.rda')
load('Dane/train_interpunction.rda')
load('Dane/train_Boruta.rda')
load('Dane/test.rda')
load('Dane/test_interpunction.rda')
load('Dane/test_Boruta.rda')
library(e1071)
bayesAll <- naiveBayes(Classes~.,data=train[,-348], laplace=0.2)
bayesAll_interpunction <- naiveBayes(Classes~.,
																		 data=train_interpunction[,-348], laplace=0.2)
bayesAll_interpunction_Boruta <- naiveBayes(Classes~.,
																		 data=train_Boruta, laplace=0.2)
	

bayes_prawd_test <- predict(bayesAll, newdata=test[,-c(348:349)], type="raw")[,2]
bayes_prawd_test_interpunction <- predict(bayesAll_interpunction, newdata=test_interpunction[-c(348:349)], type="raw")[,2]
bayes_prawd_test_interpunction_Boruta <- predict(bayesAll_interpunction_Boruta, newdata=test_Boruta, type="raw")[,2]

library(ROCR)

save(bayes_prawd_test, file = "Predykcje/bayes_prawd_test.rda")
save(bayes_prawd_test_interpunction, file = "Predykcje/bayes_prawd_test_interpunction.rda")
save(bayes_prawd_test_interpunction_Boruta, file = "Predykcje/bayes_prawd_test_interpunction_Boruta.rda")
