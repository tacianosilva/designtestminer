# sudo apt-get install r-cran-plyr
# install.packages('ggplot2')
library(ggplot2)
source("designtests-projects.R")

#qplot(sumario_random$R1, geom="histogram", binwidth = 1, main = "Histogram for R1", xlab = "Number of Fails")

createHistogram = function(df, coluna, titulo) {
  ggplot(data=df, aes(coluna)) + 
    geom_histogram(breaks=seq(0, max(coluna)+1, by =1),
                   col="black", 
                   aes(fill=..count..)) +
    labs(title=titulo) +
    labs(x="Total of Fails", y="Count")  
}

createHistogram(sumario_random, sumario_random$R2, "Histogram for R2")
createHistogram(sumario_random, sumario_random$R4, "Histogram for R4")
createHistogram(sumario_random, sumario_random$R5, "Histogram for R5")
createHistogram(sumario_random, sumario_random$R6, "Histogram for R6")
createHistogram(sumario_random, sumario_random$R7, "Histogram for R7")
createHistogram(sumario_random, sumario_random$R8, "Histogram for R8")

createHistogram(sumario_star, sumario_star$R2, "Histogram for R2")
createHistogram(sumario_star, sumario_star$R4, "Histogram for R4")
createHistogram(sumario_star, sumario_star$R5, "Histogram for R5")
createHistogram(sumario_star, sumario_star$R6, "Histogram for R6")
createHistogram(sumario_star, sumario_star$R7, "Histogram for R7")
createHistogram(sumario_star, sumario_star$R8, "Histogram for R8")
