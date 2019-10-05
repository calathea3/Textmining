# Welcome!
 

In this repo you find the code for a textmining exercise.
The goal was to predict the next word for English text.

For your orientation:


- stupidbackoffscore.Rmd: read in the source data and calculates the score. The output are three files (trigram, bigram, unigram) which are the input for the shiny app

- the code for the shiny app (https://hn317.shinyapps.io/ShinyNgram/)
* ui.R
* server.R
* nextwordpredictionfunctions.R: the functions necessary to retrieve the candidates for the user input

- textmining presentation incl images