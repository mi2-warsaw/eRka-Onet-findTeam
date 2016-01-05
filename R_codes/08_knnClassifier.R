pkgLoad("class")
pkgLoad("gmodels")

if(testRunBool){
        knn_pred <- knn(dplyr::select(train,-Classes), dplyr::select(test,-Classes), cl = train_labels, k=5)
} else{
        knn_pred <- knn(dplyr::select(train,-Classes), test, cl = train_labels, k=5)
}

knn_pred_to_file <- cbind(levels(test_IDs), levels(knn_pred))
colnames(knn_pred_to_file) <- c("id", "prediction")

if(testRunBool){
	knn_accuracy <- sum(knn_pred == test_labels)/length(test_labels)
}