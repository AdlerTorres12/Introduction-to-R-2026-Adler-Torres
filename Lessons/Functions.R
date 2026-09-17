library("ggplot2")
install.packages("dp1yr")
library(ggplot2)
install.packages("ggplot2")
library("ggplot2")
fahrenheit_to_celsius <- function (temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
}
fahrenheit_to_celsius(100)


data_storms <- read.csv("storms.csv")

head(storms)
head(storms)
data_storms
head(storms)
head(data_storms)
summary(data_storms)
#creating a new subset
hurricane <- data_storms[data_storms$status == "hurricane",]
head(hurricane)

View(data_storms)
# select specific columns
hurricane <- hurricane[, c("name" , "year" , "category" , "pressure" , "wind")]
head(hurricane)

#create a function to classify wind velocity
classify_wind <- function(wind) {
  if(wind<80){
  "low"
  }else if(wind<110){
    "moderate"
  }else {
    "high"
  }

}

hurricane$windclass <- sapply(
  hurricane$wind,
  classify_wind
)

head(hurricane, 20)

table(hurricane$windclass)
