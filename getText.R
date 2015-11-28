library(tm)
Dir = DirSource(directory = '', encoding = "UTF-8")
corpus = VCorpus(Dir)
DTM = DocumentTermMatrix(corpus)

