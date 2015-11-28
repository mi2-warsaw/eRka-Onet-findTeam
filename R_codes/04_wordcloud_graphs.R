removeSparseTerms(DTM, sparse = 0.99) -> DTM99
require(XML)
require(tm)
require(wordcloud)
require(RColorBrewer)
mat <- sparseMatrix(i=DTM99$i, j=DTM99$j, x=DTM99$v,
										dims=c(DTM99$nrow, DTM99$ncol))

ap.m <- as.matrix(mat)
ap.v <- sort(colSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = DTM99$dimnames$Terms,freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("wordcloud_version1.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3,
					max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()

ap.d2 <- ap.d[-c(1:32),]
png("wordcloud_version2.png", width=1280,height=800)
wordcloud(ap.d2$word,ap.d2$freq, scale=c(8,.2),min.freq=3,
					max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()