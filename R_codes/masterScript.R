mainPath = "/Users/a/Moje/Nauka/eRka_Onet_findTeam_clean"
codesPath = paste(mainPath,"/R_codes",sep="")
dataToSavePath = paste(mainPath,"/Dane/",sep="")
dataToLoadPath = paste(mainPath,"/prepared_data_small/",sep="")
predictionPath = paste(mainPath,"/Predykcje/",sep="")
plotsPath = paste(mainPath,"/Wykresy/",sep="")

testRunBool = FALSE

sourceWithSettingWD <- function(scriptName){
	setwd(codesPath)
	ptm <- proc.time()
	source(scriptName)
	print(proc.time()-ptm)
	setwd(mainPath)
}

saveObjectToFile <- function(object){
	save(object, file = paste(dataToSavePath, deparse(substitute(object)), ".rda",sep=""))
}

savePredToFile <- function(predictions){
        write.table(predictions, file = paste(predictionPath, deparse(substitute(predictions)), ".csv",sep=""), quote=FALSE, row.names=FALSE)
}

pkgLoad <- function(x)
{
	if (!require(x,character.only = TRUE))
	{
		install.packages(x)
		if(!require(x,character.only = TRUE)) stop("Package not found")
	}
	#now load library and suppress warnings
	suppressPackageStartupMessages(library(x,character.only = TRUE))
}


sourceWithSettingWD("01_getText.R")

saveObjectToFile(DTM)
saveObjectToFile(corpusFull)

sourceWithSettingWD("02_toDFtoMatrix.R")

saveObjectToFile(DTM95)
saveObjectToFile(DTM99)
saveObjectToFile(DTM_df)
saveObjectToFile(corpus)

otherAttributes <-c()

sourceWithSettingWD("03_addEndSignRatio.R")
sourceWithSettingWD("03_addNumberRatio.R")
sourceWithSettingWD("03_addTextLength.R")
attributes_matrix <- cbind(DTM_df, otherAttributes)

#TODO: Warningi, że za duże i nie da się wyplotować!
#U mnie mieliło przez ponad godzinę i musiałem wyłączyć.
#sourceWithSettingWD("03_wordcloud_graphs.R")

#saveObjectToFile(ap.d_sorted)
#save(ap.d_sorted, file = "Aplikacja/ap.d_sorted.rda")

#TODO: inner_join wywala warningi
sourceWithSettingWD("04_addTags.R")

saveObjectToFile(data_tagged_clean)

sourceWithSettingWD("05_splitData.R")

saveObjectToFile(train)
saveObjectToFile(test)

#dev.off() wywalał mi errora: QuartzBitmap_Output - unable to open file 'Wykresy/Boruta_selection.png'
#Zakomentowałem.
#Jeśli ustawię testRunBool na true to dostaję taki error:
#Błąd w`$<-.data.frame`(`*tmp*`, "shadow.Boruta.decision", value = c(0,  : 
#zamiana ma 26 wierszy, dane mają 15
#

sourceWithSettingWD("07_variableSelection.R")

saveObjectToFile(train_Boruta)
saveObjectToFile(train_labels)
saveObjectToFile(test_Boruta)

if(testRunBool){
	saveObjectToFile(test_labels)
}

train_IDs <- train$uuid_h2
test_IDs <- test$uuid_h2

train <- train_Boruta
test <- test_Boruta

# Nie mam pojęcia co się tam dzieje przy przypisywaniu do knn_pred_to_file. 
# wydaje mi się, że używanie tutaj "levels" nie jest szczególnie poprawne.
sourceWithSettingWD("08_knnClassifier.R")
savePredToFile(knn_pred_to_file)

sourceWithSettingWD("08_GLM.R")
savePredToFile(glm_pred_to_file)

sourceWithSettingWD("08_naiveBayes.R")
savePredToFile(bayes_pred_to_file)

sourceWithSettingWD("08_svm.R")
savePredToFile(svm_pred_to_file)

sourceWithSettingWD("08_LDA_QDA.R")
savePredToFile(lda_pred_to_file)

sourceWithSettingWD("08_RandomForest.R")
savePredToFile(RF_pred_to_file)

sourceWithSettingWD("09_combineResults.R")
savePredToFile(final_predictions_vote)
savePredToFile(final_predictions_mean)
