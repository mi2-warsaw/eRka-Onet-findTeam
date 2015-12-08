setwd(mainPath)
removeSparseTerms(DTM, sparse = 0.99) -> DTM99
pkgLoad("XML")
pkgLoad("tm")
pkgLoad("wordcloud")
pkgLoad("RColorBrewer")
mat <- sparseMatrix(i=DTM99$i, j=DTM99$j, x=DTM99$v,
										dims=c(DTM99$nrow, DTM99$ncol))

ap.m <- as.matrix(mat)
ap.v <- colSums(ap.m)
ap.d <- data.frame(word = DTM99$dimnames$Terms,freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png(paste(plotsPath,"/wordcloud_version1.png",sep=""), width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3,
					max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()

pkgLoad("dplyr")
ap.d %>%
	arrange(desc(freq)) -> ap.d_sorted

ap.d_sorted[-c(1:100),] -> ap.d2

png(paste(plotsPath,"/wordcloud_version2.png",sep=""), width=1280,height=800)
wordcloud(ap.d2$word,ap.d2$freq, scale=c(8,.2),min.freq=3,
					max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()


