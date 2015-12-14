pkgLoad("caTools")

if(testRunBool){
split = sample.split(data_tagged_clean$Classes, SplitRatio = 0.6)
train = data_tagged_clean[split==TRUE,]
test = data_tagged_clean[split==FALSE,]
}else{
	train = data_tagged_clean
	test = attributes_matrix
}



