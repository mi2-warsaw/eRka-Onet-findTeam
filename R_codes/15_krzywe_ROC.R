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


kolory <- colors()[sample(1:640,6)]
roc(bayes_prawd_test, test$Classes, lty=5, lwd=2, main="Porównanie krzywych ROC")
roc2(bayes_prawd_test_interpunction, test$Classes, col=kolory[1],lty=5, lwd=2)
roc2(bayes_prawd_test_interpunction_Boruta, test$Classes, col=kolory[2],lty=5, lwd=2)
roc2(lda_test, test$Classes, col=kolory[3],lty=5, lwd=2)
roc2(lda_test_interpunction, test$Classes, col=kolory[4],lty=5, lwd=2)
roc2(lda_test_interpunction_Boruta, test$Classes, col=kolory[5],lty=5, lwd=2)


legend(0.6,0.5, 
			 c("Bayes_ALL","Bayes_ALL_int","Bayes_Boruta_int")#,
			 	#"LDA_ALL","LDA_ALL_int","LDA_Boruta_int"),
			 ,lty=2,
			 lwd=2,
			 col=c("red",kolory[1:5]))

