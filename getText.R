library(magrittr)
list.files('C:/Users/Lenovo/Desktop/prepared_data2/docs_collection_baseform2') %>%
        grep('txt', x = ., value = T) %>%
        file.path('C:/Users/Lenovo/Desktop/prepared_data2/docs_collection_baseform2' ,.) %>% 
        sapply(function(element){
                readLines(element) %>% 
                        assign( x = tail(strsplit(element, "/")[[1]],1), 
                                value = .,
                                envir = .GlobalEnv)
        }) %>% invisible()

ls() -> files

listP <- list()
for(i in files){
        listP[[i]] <- get(i, envir = .GlobalEnv)
}

do.call(rbind, listP) -> pliki_df
