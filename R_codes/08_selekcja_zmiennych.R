# seleckja zmiennych
load("Dane/train.rda")
load("Dane/test.rda")
library(Boruta)
Boruta.mod <- Boruta(Classes~., data = train[,-348])


png("Wykresy/Boruta_selection.png", width=2000,height=800)
plot(Boruta.mod, las = "2")
dev.off()

print(getSelectedAttributes(Boruta.mod, withTentative = TRUE)) -> impFeatures
cat(impFeatures, sep=",")
library(dplyr)

load("Dane/train_interpunction.rda")
load("Dane/test_interpunction.rda")

train_interpunction %>%
	select(dodać,dotyczyć,europejski,gra,gwiazda,kobieta,kraj,mężczyzna,należeć,
				 naprawdę,poinformować,polski,
					poniedziałek,ręka,robić,ruch,sierpień,szczęście,wyglądać,
				 zdjęcie,zmiana,zobaczyć, Classes, EndSignRatio) -> train_Boruta


test_interpunction %>%
	select(dodać,dotyczyć,europejski,gra,gwiazda,kobieta,kraj,mężczyzna,należeć,
				 naprawdę,poinformować,polski,
				 poniedziałek,ręka,robić,ruch,sierpień,szczęście,wyglądać,
				 zdjęcie,zmiana,zobaczyć, Classes,EndSignRatio) -> test_Boruta

save(train_Boruta, file = "train_Boruta.rda")
save(test_Boruta, file = "test_Boruta.rda")
