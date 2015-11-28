library(tm)
Dir = DirSource(directory = '', encoding = "UTF-8")
stopwords = readLines("Polish_stopwords.exc")
corpus = VCorpus(Dir)
corpus = tm_map(corpus, removePunctuation)
corpus = tm_map(corpus, removeWords, stopwords)
DTM = DocumentTermMatrix(corpus)

