mainPath = "/Users/a/eRka-Onet-findTeam"
codesPath = "/Users/a/eRka-Onet-findTeam/R_codes"
dataToSavePath = "/Users/a/eRka-Onet-findTeam/Dane/"
dataToLoadPath = "/Users/a/eRka-Onet-findTeam/prepared_data_small/"
predictionPath = "/Users/a/eRka-Onet-findTeam/Predykcje/"
plotsPath = "/USers/a/eRka-Onet-findTeam/Wykresy/"

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
	save(predictions, file = paste(predictionPath, deparse(substitute(predictions)), ".rda",sep=""))
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

save(DTM, file = paste(dataToLoadPath,"/DTM.rda",sep=""))

sourceWithSettingWD("02_toDFtoMatrix.R")

saveObjectToFile(DTM95)
saveObjectToFile(DTM99)
saveObjectToFile(DTM_df)
saveObjectToFile(corpus)

#TODO: Warningi, że za duże i nie da się wyplotować!
#U mnie mieliło przez ponad godzinę i musiałem wyłączyć.
#sourceWithSettingWD("03_wordcloud_graphs.R")

#saveObjectToFile(ap.d_sorted)
#save(ap.d_sorted, file = "Aplikacja/ap.d_sorted.rda")

#TODO: inner_join wywala warningi
sourceWithSettingWD("04_addTags.R")

saveObjectToFile(DTM_tagged)
saveObjectToFile(DTM_tagged_clean)

sourceWithSettingWD("05_splitData.R")

saveObjectToFile(train)
saveObjectToFile(test)

sourceWithSettingWD("06_getOtherParameters.R")

saveObjectToFile(additionalFeatures)
saveObjectToFile(trainExtended)
saveObjectToFile(testExtended)
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
