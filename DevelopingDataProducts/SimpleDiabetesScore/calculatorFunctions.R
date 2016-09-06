#  BMI Categories: 
#   Underweight = <18.5
#   Normal weight = 18.5–24.9 
#   Overweight = 25–29.9 
#   Obesity = BMI of 30 or greater

bmi <- function(input) {
  # 1 ft = 0.3048 meters
  if (input$standardUnits) {
    heightInMeters <- (input$heightMajor + (input$heightMinor / 12))* 0.3048
  } else {
    heightInMeters <- input$heightMajor + (input$heightMinor / 100)
  }
  
  # 1 lb = 0.453592 kg
  if (input$standardUnits) {
    weightInKgs <- input$weight * 0.453592
  } else {
    weightInKgs <- input$weight
  }
  
  #print(length(heightInMeters))
  #print(heightInMeters)
  if (length(heightInMeters) > 0 && !is.na(heightInMeters) && heightInMeters > 0 &&
      length(weightInKgs) > 0 && !is.na(weightInKgs) && weightInKgs > 0) {
    #  BMI = kg / m ^ 2
    weightInKgs / (heightInMeters ^ 2)
  } else {
    0
  }
}

# A score 9 and above indicates a high risk of type 2 diabetes
# maximum score: 20

diabetesScore <- function(input) {
  #   Age (years)	: enter person's age in years				
  #     - 45–54	2
  #     - 55–64	3
  
  if (input$age < 45 | input$age > 64) {
    score <- 0
  } else if (input$age >= 45 & input$age <= 54) {
    score <- 2
  } else {
    # age is between 54 and 64
    score <- 3
  }
  
  #   BMI (kg/m^2): enter person's weight in pounds or kgs
  #                 enter person's height in meters or feet/inches
  #                 calc kg and meters
  #                 1 lb = 0.453592 kg
  #                 1 ft = 0.3048 meters
  #                 BMI = kg / m ^ 2
  #     - >25 to 30: 1
  #     - >30:	3
  bmiResult <- bmi(input)
  if (bmiResult > 25 & bmiResult <= 30) {
    score <- score + 1
  } else if (bmiResult > 30) {
    score <- score + 3
  } 
  
  #   Waist circumference (cm)	
  #         enter person's gender
  #         enter person's waist in centimeters or inches
  #         calc cm
  #     - Men, 94 to <102; women, 80 to <88:	3
  #     - Men, ≥102; women, ≥88: 4
  if (input$standardUnits) {
    waistInCms <- (input$waistMeasurement / 12) * 0.3048
  } else {
    waistInCms <- input$waistMeasurement
  }
  
  if (length(waistInCms) > 0 && !is.na(waistInCms)) {
    if (input$male) {
      if (waistInCms >= 94 & waistInCms < 102) {
        score <- score + 3
      } else if (waistInCms >= 102) {
        score <- score + 4
      } 
    } else {
      #female
      if (waistInCms >= 80 & waistInCms < 88) {
        score <- score + 3
      } else if (waistInCms >= 88) {
        score <- score + 4
      } 
    }
  }
  
  #   Use of blood pressure medication:	2
  #       yes/no
  if (input$bloodPressureMedication) {
    score <- score + 2
  } 
  
  #   History of high blood glucose:	5
  #       yes/no
  if (input$highGlucose) {
    score <- score + 5
  } 
  
  #   Physical activity <4 h/week:	2
  #       yes/no
  if (input$notPhysicallyActive) {
    score <- score + 2
  }
  
  #   Not Daily fruit, vegetables, berries:	2
  #       yes/no
  if (!input$eatWell) {
    score <- score + 1
  }
  
  score
  
}

testData <- function() {
  testData <- vector("list", length = 11)
  names(testData) <- c('heightMajor',
                       'heightMinor',
                       'weight',
                       'standardUnits',
                       'age',
                       'waistMeasurement',
                       'bloodPressureMedication',
                       'male',
                       'highGlucose',
                       'eatWell',
                       'notPhysicallyActive')
  testData$heightMajor <- 6
  testData$heightMinor <- 0
  testData$weight <- 250
  testData$standardUnits <- TRUE
  testData$age <- 59
  testData$waistMeasurement <- 33
  testData$bloodPressureMedication <- FALSE
  testData$male <- FALSE
  testData$highGlucose <- FALSE
  testData$eatWell <- FALSE
  testData$notPhysicallyActive <- TRUE

  testData
}