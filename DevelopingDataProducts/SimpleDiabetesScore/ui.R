#
# This is the user-interface definition of a Shiny web application:
# 
# "A simple Type 2 diabetes likelihood test"

# You can run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("A simple Type 2 diabetes likelihood test"),
  fluidRow(
    column(10, offset = 1,
      p("This calculator indicates a person's risk of Type 2 diabetes, based on a few questions."),
      p("It is based on the Diabetes Risk Score from Finnish research in 2003",
        a("http://care.diabetesjournals.org/content/26/3/725")),
      p(),
      p("Body Mass Index is also calculated.")
    )
  ),
  hr(),

  fluidRow(
    
    column(6,
       numericInput("age", 
                    label = h5("What is the person's age (years)?"),
                    min = 0,
                    max = 125,
                    value = 40),
       
       radioButtons("male", label = h5("What is the person's gender?"),
                    choices = list("Male" = TRUE, "Female" = FALSE)),
       checkboxInput("bloodPressureMedication", "Does the person take high blood pressure medication?", FALSE),
       checkboxInput("highGlucose", "Does the person have a history of high glucose levels in their blood?", FALSE),
       checkboxInput("notPhysicallyActive", "Is the person physically active less than 4 hours per week?", FALSE),
       checkboxInput("eatWell", "Does the person eat fruits, vegetables or berries daily?", FALSE)
    ),
    column(6,
           
           selectInput("standardUnits", label = h5("Measurement Basis"), 
                       choices = list("Standard (feet, inches, lbs)" = TRUE, "Metric (meters, cm, kg)" = FALSE)),
           
           uiOutput("heightMajorInput"),
           
           uiOutput("heightMinorInput"),
           
           uiOutput("weightInput"),
           
           uiOutput("waistInput")
  )),
  hr(),
  fluidRow(
         #textOutput("text1"),
         #textOutput("text2"),
         #textOutput("text3"),
         #textOutput("text4"),
         #textOutput("text5"),
         #textOutput("text6"),
         #textOutput("text7"),
         #textOutput("text8"),
         #textOutput("text9"),
         #textOutput("text10"),
         #textOutput("text10.5"),
         p(),
         htmlOutput("text11"),
         p(),
         htmlOutput("text12")
  )
))
