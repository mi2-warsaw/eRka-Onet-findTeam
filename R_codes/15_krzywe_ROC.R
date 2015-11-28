# krzywe ROC
library(ROCR)

roc <- function(pred_prawdopod, prawdziwe_klasy,...){
	pred <- prediction(pred_prawdopod, prawdziwe_klasy)
	perf <- performance(pred, measure="tpr",x.measure="fpr")
	plot(perf,col="red",...)
	abline(0,1)
	lines(c(0.5,0.5),c(-0.1,1.1),lty=2,col="green")
}
auc <- function(pred_prawdopod, prawdziwe_klasy){
	pred <- prediction(pred_prawdopod, prawdziwe_klasy)
	performance(pred, "auc")@y.values[[1]] 
}


roc2 <- function(pred_prawdopod, prawdziwe_klasy,...){
	pred <- prediction(pred_prawdopod, prawdziwe_klasy)
	perf <- performance(pred, measure="tpr",x.measure="fpr")
	plot(perf,...,add=TRUE)
}



kolory <- brewer.pal(8,"Dark2")
#roc(bayes_prawd_test, test$Classes, lty=5, lwd=2, main="Porównanie krzywych ROC")
roc(bayes_prawd_test_interpunction, test$Classes, lty=5, lwd=2, main="Porównanie krzywych ROC")
roc2(bayes_prawd_test_interpunction_Boruta, test$Classes, col=kolory[2],lty=5, lwd=2)
#roc2(lda_test, test$Classes, col=kolory[3],lty=5, lwd=2)
roc2(lda_test_interpunction, test$Classes, col=kolory[3],lty=5, lwd=2)
roc2(lda_test_interpunction_Boruta, test$Classes, col=kolory[4],lty=5, lwd=2)
roc2(GLM_Boruta[,2], test$Classes, col=kolory[5],lty=5, lwd=2)
roc2(Rf_results[,2], test$Classes, col=kolory[6],lty=5, lwd=2)
roc2(test_pred_prob, test$Classes, col=kolory[7],lty=5, lwd=2)

all_classificators <- data.frame(bayes_prawd_test_interpunction,
																 bayes_prawd_test_interpunction_Boruta,
																 lda_test_interpunction,
																 lda_test_interpunction_Boruta,
																 GLM_Boruta[,2],
																 Rf_results[,2],
																 test_pred_prob)

rowMeans(all_classificators) -> srednie
save(srednie, file = "Predykcje/srednie.rda")
roc2(srednie, test$Classes, col=kolory[8],lty=5, lwd=2)


legend(0.6,0.5, 
			 c("Bayes_A","Bayes_B",
			 	"LDA_A","LDA_B","GLM_B",
			 	"Random Forests",	"SVM Linear", "Srednie"),
			 ,lty=2,
			 lwd=2,
			 col=c("red",kolory[2:8]))

