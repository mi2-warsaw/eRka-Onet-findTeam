pkgLoad("caTools")

if(testRunBool){
split = sample.split(DTM_tagged_clean$Classes, SplitRatio = 0.6)
train = DTM_tagged_clean[split==TRUE,]
test = DTM_tagged_clean[split==FALSE,]
}else{
	train = DTM_tagged_clean
	test = DTM_df
}



