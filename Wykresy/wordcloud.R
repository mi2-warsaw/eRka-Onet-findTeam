library(wordcloud)
library(Matrix)
words = colnames(DTM_df)
frequencies = colSums(DTM_df)
wordcloud(words, freq = frequencies, max.words = 100, colors = brewer.pal(name = "Accent", n = 8))