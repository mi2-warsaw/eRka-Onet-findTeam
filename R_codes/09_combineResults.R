#MEAN
final_predictions_mean <- c()

for(i in 1:dim(test)[1]){
        currentPrediction <- 0 
        currentPrediction <- currentPrediction+as.numeric(knn_pred_to_file[i,2])
        currentPrediction <- currentPrediction+as.numeric(glm_pred_to_file[i,2])
        currentPrediction <- currentPrediction+as.numeric(bayes_pred_to_file[i,2])
        currentPrediction <- currentPrediction+as.numeric(svm_pred_to_file[i,2])
        currentPrediction <- currentPrediction+as.numeric(lda_pred_to_file[i,2])
        currentPrediction <- currentPrediction+as.numeric(RF_pred_to_file[i,2])
        currentPrediction <- currentPrediction/6
        if(currentPrediction>0.5){
                new_pred <- c(knn_pred_to_file[i,1], "1")
        }
        else{
                new_pred <- c(knn_pred_to_file[i,1], "0")
        }
        final_predictions_mean <- rbind(final_predictions_mean, new_pred)
}

colnames(final_predictions_mean) <- c("uuid_h2", "wsp_tab")


#VOTING
final_predictions_vote <- c()

for(i in 1:dim(test)[1]){
        currentPrediction <- 0 
        currentPrediction <- currentPrediction+round(as.numeric(knn_pred_to_file[i,2]))
        currentPrediction <- currentPrediction+round(as.numeric(glm_pred_to_file[i,2]))
        currentPrediction <- currentPrediction+round(as.numeric(bayes_pred_to_file[i,2]))
        currentPrediction <- currentPrediction+round(as.numeric(svm_pred_to_file[i,2]))
        currentPrediction <- currentPrediction+round(as.numeric(lda_pred_to_file[i,2]))
        currentPrediction <- currentPrediction+round(as.numeric(RF_pred_to_file[i,2]))
        if(currentPrediction<3){
                new_pred <- c(knn_pred_to_file[i,1], "0")
        }
        else if(currentPrediction>3){
                new_pred <- c(knn_pred_to_file[i,1], "1")
        }
        else if(currentPrediction==3){
                new_pred <- c(knn_pred_to_file[i,1], knn_pred_to_file[i,2])
        }
        final_predictions_vote <- rbind(final_predictions_vote, new_pred)
}

colnames(final_predictions_vote) <- c("uuid_h2", "wsp_tab")

