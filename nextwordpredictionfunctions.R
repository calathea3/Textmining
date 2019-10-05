require(tm)
require(data.table)
require(ngram)

# read scores for ngrams
trigram<-fread("trigram.csv",key="prefix")
bigram<-fread("bigram.csv",key="prefix")
unigram<-fread("unigram.csv")

# clean input
cleanWords = function(x) {
  x <- tolower(x)
  x <- gsub("(ht|f)tp(s?)://\\S+", "", x)
  x <- gsub("www(.*)[.][a-z]+|www.", " ", x)
  x <- gsub("[@#]\\S+", "", x)
  x <- gsub("^rt |^rt:", " ", x)
  x <- gsub("[[:punct:]]", "", x)
  x <- gsub("^\\s+|\\s+$", "", x)
  return(x)
}

# top 10 scores per ngram
outputTrigram = function(x){
  subset(trigram, prefix == x)[1:10,.(score,rest,source='Trigram')]
}

outputBigram = function(x){
  subset(bigram, prefix == x)[1:10,.(score,rest,source='Bigram')]
}

outputUnigram = function(x){
  unigram[1:10,.(score,rest=tok,source='Unigram')]
}

lastWords = function(x, wordCount) {
  #splits input into words and counts words
  tmp <- strsplit(x, " ", fixed=TRUE)[[1]]
  paste(tail(tmp,wordCount),collapse=" ")
}

prediction = function(x){
  # takes the cleaned input 
  # collects the matching 10 trigrams and 10 unigrams with the max scores and the unigrams with the top 10 max scores
  # sorts trigrams, bigrams and unigrams descending by score and deduplicates list
  # extracts the top 5 scores overall  
  
  res <- rbind(outputUnigram(x), outputBigram(lastWords(x,1)))
  if(wordcount(x) > 1) {
    res <- rbind(res, outputTrigram(lastWords(x,2)),use.names=F)
  }
  
  res <- res[order(-res$score)]
  res <- unique(res, by="rest")
  res <- res[1:5]
  return(res)
}
