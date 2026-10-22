# Mid term (10/22)
# Lecture Data
# Critical values

install.packages("BSDA")
library(BSDA)

# This is normally distributed data
z.test(sample_mean, 
       alternative = "greater",
       mu = 15,
       sigma.x = 0.25)
sample_mean <- c(15.84, 15.33, 15.58)
# For not normally distributed data, you should use wilcox test. 
