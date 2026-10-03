library(readxl)

coronary <- read_excel("Lessons/coronary.xlsx")

head(coronary)
View(coronary)

plot(
  coronary$dbp ~ coronary$chol,
  type = "p",
  col = "purple",
  lwd = 1.5,
  xlab = "Total Cholesterol (mmol/L)",
  ylab = "Diastolic Blood Pressure (mmHg)",
  main = "Relationship between Cholesterol and Diastolic BP"
)

abline(lm(dbp ~ chol, data = coronary),
       col = "red", lwd = 2, lty = 2)

spearman_result <- cor.test(
  coronary$chol,
  coronary$dbp,
  method = "spearman",
  exact = FALSE
)

spearman_result

shapiro.test(coronary$chol)


coronary <- coronary[order(coronary$age), ]

plot(coronary$age, coronary$chol,
     type = "l",
     col = "blue",
     lwd = 2,
     xlab = "Age (years)",
     ylab = "Colesterol (mmol/L)",
     main = "Colesterol vs Age")

plot(coronary$age, coronary$chol,
     type = "l")

hist(coronary$age,
     main = "mi histograma")

boxplot(coronary$chol)
