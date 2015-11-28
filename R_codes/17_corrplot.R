load('Dane/train_Boruta.rda')
library(corrplot)

corrplot(cor(train_Boruta), order = "AOE")
