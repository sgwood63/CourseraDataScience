#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# This is a calculator for the Diabetes Risk Score

# http://care.diabetesjournals.org/content/26/3/725#T1

# The Diabetes Risk Score is a simple, fast, inexpensive, 
# noninvasive, and reliable tool to identify individuals 
# at high risk for type 2 diabetes.

# Score generation logic

# Ask subject questions below. For each question,
# add relevant score to total
# show "High Risk" or "Not High Risk"
#

#   sum(score) >= 9: high risk

# conversions with datamart package

library(shiny)
source("calculatorFunctions.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
#  output$text1 <- renderText({ 
#    paste("You have selected standardUnits:", input$standardUnits)
#  })
#  output$text2 <- renderText({ 
#    paste("You have selected male:", input$male)
#  })
#  output$text3 <- renderText({ 
#    paste("You have selected height:", input$heightMajor)
#  })
#  output$text4 <- renderText({ 
#   paste("You have selected height in feet:", input$heightInFeet)
#  })
#  output$text5 <- renderText({ 
#    paste("You have selected height inches:", input$heightInches)
#  })
#  output$text6 <- renderText({ 
#    paste("You have selected weight:", input$weight)
#  })
#  output$text7 <- renderText({ 
#    paste("You have selected weight in lbs:", input$weightInPounds)
#  })
#  output$text8 <- renderText({ 
#    paste("You have selected high blood pressure medication:", input$bloodPressureMedication)
#  })
#  output$text9 <- renderText({ 
#    paste("You have selected high glucose levels:", input$highGlucose)
#  })
#  output$text10 <- renderText({ 
#    paste("You have selected not physcially active:", input$notPhysicallyActive)
#  })
#  output$text10.5 <- renderText({ 
#    paste("You have selected eat fruit, vegetables or berries daily:", input$eatWell)
#  })
  
  heightMajorText <- reactive({
    if (input$standardUnits == TRUE) {
      units <- '(feet)'
    } else {
      units <- '(meters)'
    }
    h5(paste("What is the person's height?", units))
  })
  
  output$heightMajorInput <- renderUI({
    numericInput("heightMajor", 
               label = heightMajorText(),
               min = 20,
               max = 72,
               value = 5)
  })
  
  
  heightMinorText <- reactive({
    if (input$standardUnits == TRUE) {
      units <- '(inches)'
    } else {
      units <- '(centimeters)'
    }
    h5(units)
  })
  
  output$heightMinorInput <- renderUI({
    numericInput("heightMinor", 
                             label = heightMinorText(),
                             min = 0,
                             max = 11.99,
                             value = 0)
  })
  
  weightText <- reactive({
    if (input$standardUnits == TRUE) {
      units <- '(lbs)'
    } else {
      units <- '(kgs)'
    }
    h5(paste("What is the person's weight?", units))
  })
  
  output$weightInput <- renderUI({
    numericInput("weight", 
               label = weightText(),
               min = 10,
               max = 1000,
               value = 120)
  })
  
  waistText <- reactive({
    if (input$standardUnits == TRUE) {
      units <- '(inches)'
    } else {
      units <- '(cm)'
    }
    h5(paste("What is the person's waist measurement?", units))
  })
  
  output$waistInput <- renderUI({
    numericInput("waistMeasurement", 
               label = waistText(),
               min = 20,
               max = 72,
               value = 50)
  })

  thisBMI <- reactive({
    round(bmi(input), digits = 1)
  })
  
  BMIRating <- reactive({
    
    calcBMI <- thisBMI()
    
    if (calcBMI < 18.5) {
      ranking <- 'is underweight.'
    } else if (calcBMI < 24.9) {
      ranking <- 'has normal weight.'
    } else if (calcBMI < 29.9) {
      ranking <- 'is overweight.'
    } else {
      ranking <- 'is obese.'
    }
    ranking
  })
  
  output$text11 <- renderUI({ 
    HTML(paste("<h4>A Body Mass Index (BMI) of:", thisBMI(), " - indicates the person", BMIRating(), "</h4>"))
  })

  dbScore <- reactive({
    diabetesScore(input)
  })
  
  DBRating <- reactive({
    score <- dbScore()
    if (score < 9) {
       'normal'
    } else {
      '<span style="color:red">HIGH</span>'
      #'HIGH'
    }
  })
  
  output$text12 <- renderUI({
    HTML(paste("<h3>Diabetes Risk Score:", dbScore(), "<br/><br/>Indicates the person has a", DBRating(), 
                              "risk of Type 2 diabetes.</h3>")
    )
  })
  
})

