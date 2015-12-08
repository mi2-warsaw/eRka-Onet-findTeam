pkgLoad("class")
pkgLoad("gmodels")

knn_pred <- knn(dplyr::select(train,-Classes), test, cl = train_labels, k=5)

knn_pred_to_file <- cbind(levels(test_IDs), levels(knn_pred))
colnames(knn_pred_to_file) <- c("id", "prediction")

if(testRunBool){
	sum(knn_pred == test_labels)/length(test_labels)
}