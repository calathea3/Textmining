require(shiny)
require(data.table)
require(ggplot2)

source("./nextwordpredictionfunctions.R")

shinyServer(function(input, output) {  
  
  output$text <- renderText({
    input$do
    isolate(cleanWords(input$text))
  })
  output$CandidatesPlot <- renderPlot({ 
    input$do
    candidates <- prediction(cleanWords(isolate(input$text)))
    ggplot(candidates, aes(x = reorder(rest,score), y = score, colour = source)) + coord_flip() +
      geom_bar(stat = "identity", fill = "gold") + theme_bw() +
      ggtitle("Candidates for next word: Top 5 scores") +labs(x = "", y = "") + 
      geom_text(aes(label=round(score,5)))
  })
})
