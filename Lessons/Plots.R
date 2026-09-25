
# Plots in Base R ---------------------------------------------------------

data(DNase)
View(DNase)

head(DNase, 3)
?DNase

mean_density <- aggregate(density~conc,
                          data=DNase,
                          FUN=mean)
barplot(
  height = mean_density$density,
  names.arg = mean_density$conc,
  col = "lightblue",
  border = "grey30",
  main = "Mean DNase I Activity by Concentration",
  xlab = "Concentration (mg/mL)",
  ylab = "Mean Opctical Density",
  las = 2,
  cex.names = 0.5
)
