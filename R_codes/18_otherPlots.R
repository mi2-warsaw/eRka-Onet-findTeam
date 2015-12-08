#Checking the meaning of the interpunction
library("tidyr")
ESRLabels <- cbind(DTM_tagged_interpunction$Classes, DTM_tagged_interpunction$EndSignRatio)
ESRLabels <- as.data.frame(ESRLabels)
names(ESRLabels) <- c("Tabl", "Ratio")


ESRLabels %>%
	gather()->ESRLabels2

ggplot(ESRLabels, aes(factor(Tabl),Ratio) ) +
	geom_boxplot()