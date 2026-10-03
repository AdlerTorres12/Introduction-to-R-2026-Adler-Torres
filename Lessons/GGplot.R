#GGplot is very useful

read.csv(Lessons/tyre.csv)
?mtcars
library(read.csv)
library(ggplot2)
read.csv(tyre.csv)
read.csv("Lessons/books.csv")  
books <- read.csv("Lessons/books.csv")
tyre <- read.csv("Lessons/tyre.csv")
head(tyre)
head(books)
summary(tyre)
?fill
?ggplot
homework_plot <- ggplot(data = tyre,
       aes(x=Brands, y= Mileage)) + 
         geom_boxplot(fill = colors) +
  labs(x= "Brand of Tires",
       y= "Miles"
       ) +
  theme_classic() +
  theme(legend.position = 'none') +
  theme(
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    axis.title.x = element_text(size = 14, face = "bold"),
    axis.title.y = element_text(size = 14, face = "bold"),
    axis.text.x = element_text(size = 12),
    axis.text.y = element_text(size = 12)
  )
  
colors = c("grey", "magenta", "pink", "orange" )
# You need ggplot, aes and geom for a graph. 
# When you only have two groups, you would like to analyze them with a T-test, but when you have more then two, then an ANOVA would be better.

# Statistical Analysis
summary(tyre)
mod <- aov(Mileage ~ Brands, data = tyre)
mod
summary(mod)
summary.aov(mod)

resid_anova <- residuals(mod)

shapiro.test(resid_anova)

# Assumption: Your data come from a normal distribution.
# p-value more then 0.05 = your data is not satistically different from a normal distribution. Which is good cause it means you can use an ANOVA.
# Step 1 = Create a model aov()
# Step 2 = Check for Normality of the residuals.
# Step 3 = Tukey Test
# ggsave ( Enter, filename = _______, plot = name of function, width = __, height = __, dpi = ___)

TukeyHSD(mod)

homework_plot

ggsave(
  filename = "GGplot_In_Class_Plot.png",
  plot = homework_plot,
  width = 8, height = 6, dpi = 500)
