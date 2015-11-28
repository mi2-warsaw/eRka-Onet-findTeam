find_treshold = function(predykcja_klasy, klasy_prawdziwe){
	treshold = NULL
	Result = 0
	for (i in seq(0,1,by = 0.01)){
		x = tabela(predykcja_klasy>i, klasy_prawdziwe)
		Wynik = procent(x)
		if (Wynik>Result){
			treshold = i
			Result <- Wynik
		}
		cat(i, "\n ")
		cat(treshold, "\n ")
		
	}
	return(procent(tabela(predykcja_klasy>treshold, klasy_prawdziwe)))
	
}