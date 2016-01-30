# krzywe ROC
pkgLoad("ROCR")
pkgLoad("RColorBrewer")

roc <- function(pred_probability, true_classes,...){
	pred <- prediction(pred_probability, true_classes)
	perf <- performance(pred, measure="tpr",x.measure="fpr")
	plot(perf,col="red",...)
	abline(0,1)
	lines(c(0.5,0.5),c(-0.1,1.1),lty=2,col="green")
}
auc <- function(pred_probability, true_classes){
	pred <- prediction(pred_probability, true_classes)
	performance(pred, "auc")@y.values[[1]] 
}


roc2 <- function(pred_probability, true_classes,...){
	pred <- prediction(pred_probability, true_classes)
	perf <- performance(pred, measure="tpr",x.measure="fpr")
	plot(perf,...,add=TRUE)
}


graphics.off()

colors <- brewer.pal(8,"Dark2")
roc(bayes_pred, test$Classes, lty=5, lwd=2, main="ROC curves comparision")
roc2(glm_pred, test$Classes, col=colors[3],lty=5, lwd=2)
roc2(lda_pred, test$Classes, col=colors[4],lty=5, lwd=2)
roc2(RF_pred, test$Classes, col=colors[5],lty=5, lwd=2)
roc2(svm_pred, test$Classes, col=colors[6],lty=5, lwd=2)

all_classifiers <- data.frame(bayes_pred, glm_pred, lda_pred, RF_pred, svm_pred)

rowMeans(all_classifiers) -> mean_results
save(mean_results, file = "Predykcje/mean_results.rda")
roc2(mean_results, test$Classes, col=colors[8],lty=5, lwd=2)


legend(0.6,0.5, c("Bayes","GLM", "LDA","RD","SVM", "Mean"),lty=2, lwd=2, col=c("red",colors[2:8]))

