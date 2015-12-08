pkgLoad("tm")
pkgLoad("pbapply")
setwd(mainPath)

Dir = DirSource(directory = paste(dataToLoadPath,'/docs_collection_baseform2/',sep=""),
								encoding = "Windows-1250")
stopwords = readLines("Pomocnicze/Polish_stopwords.txt")
stopwords <- tolower(stopwords)
corpus = VCorpus(Dir)
corpus = tm_map(corpus, content_transformer(tolower))
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords)
DTM = DocumentTermMatrix(corpus)

