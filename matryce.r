
### SCRIPTS USED TO PREPARE SOME OF THE DATA


# library(devtools)
# install_github("hadley/xml2")


## BASE FORM PREPARATION

library(xml2)
tagFilesPath <- "c:/_Dane/MARATON/prepared_data/docs_collection_tagged"

tagFiles <- list.files(path=tagFilesPath,pattern="*.tag",full.names=T,recursive=F)

baseFiles <- gsub("_tagged","_baseform2",tagFiles)
baseFiles <- gsub(".tag",".bas",baseFiles)
 
for (i in 1:length(tagFiles)) {
 doc <- read_xml(tagFiles[i],encoding="UTF-8");
 write(paste(xml_text(xml_find_all(doc,"//tok/lex[@disamb][1]/base")),collapse=" "),file=baseFiles[i]);
 if (i%%1000==0) {gc()}
}

rm(doc)
gc()

## CTAG EXTRACTION

ctagFiles <- gsub("_tagged","_basectag",tagFiles)
ctagFiles <- gsub("txt.tag","txt.bctag",ctagFiles)

for (i in 1:length(tagFiles)) {
 doc <- read_xml(tagFiles[i],encoding="UTF-8");
 write(paste(xml_text(xml_find_all(doc,"//tok/lex[@disamb][1]/ctag")),collapse="\n"),file=ctagFiles[i]);
 if (i%%1000==0) {gc()}
}

rm(doc)
gc()


## BASIC TERM STATISTICS

library(stringr)

for (i in 1:length(ctagFiles)) {
    docN <- ctagFiles[i]
    docSize <- file.info(docN)$size
    if (docSize>2) {
        doc <- readChar(docN,docSize)
        doc.firsts <- lapply(strsplit(strsplit(doc,"\r\n")[[1]],":"), function(f) f[[1]][1])
        uuid_h2 <- str_match(docN,'[0-9]{10}')[1][1]
        sum_terms <- sum(table(unlist(doc.firsts)))
        write.table(cbind(uuid_h2,data.frame(table(unlist(doc.firsts))/sum_terms),sum_terms), 
              "c:/_Dane/MARATON/prepared_data/ARTICLES_termstats.dat",
              row.names=F,append=T,col.names=F,sep="\t",quote=F)
    }
}

rm(doc)
rm(docN)
rm(docSize)
rm(ctf.first)
rm(uuid_h2)
rm(sum_terms)
gc()

