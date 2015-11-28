load('Dane/train.rda')
load('Dane/train_interpunction.rda')
bayes <- naiveBayes(class~.,data=Train, laplace=0.2)
@
	
	Predykcja na zbiorze testowym, klasy i prawdopodobieństwo przynależności do klasy 1:
	<<>>=
	bayes_pred <- predict(bayes, newdata=Test)
bayes_prawd <- predict(bayes, newdata=Test, type="raw")[,2]