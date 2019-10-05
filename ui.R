require(shiny)

shinyUI(fluidPage(
  
  titlePanel("Prediction of next word:"),
  sidebarLayout(

    sidebarPanel(
      h2("Input"),
      textInput("text", label = h3("Text input"), value = "Please Try"),
      hr(),
      helpText("Enter two English words seperated by a space and click Predict. The first trial might take a bit of time. Please be patient."),
      actionButton("do", "Predict")
      
      ),

    mainPanel(
      h2("Output"),
      p(span("Next words candidates for: ") , textOutput("text", inline=TRUE)),
      p(""),
      plotOutput("CandidatesPlot") 
      )
  )
))