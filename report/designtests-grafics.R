library(ggplot2)
source("designtests-projects.R")

#qplot(sumario_random$R1, geom="histogram", binwidth = 1, main = "Histogram for R1", xlab = "Number of Fails")
qplot(sumario_random$R2, geom="histogram", binwidth = 1, main = "Histogram for R2", xlab = "Number of Fails")
#qplot(sumario_random$R3, geom="histogram", binwidth = 1, main = "Histogram for R3", xlab = "Number of Fails")
qplot(sumario_random$R4, geom="histogram", binwidth = 1, main = "Histogram for R4", xlab = "Number of Fails")
qplot(sumario_random$R5, geom="histogram", binwidth = 1, main = "Histogram for R5", xlab = "Number of Fails")
qplot(sumario_random$R6, geom="histogram", binwidth = 1, main = "Histogram for R6", xlab = "Number of Fails")
qplot(sumario_random$R7, geom="histogram", binwidth = 1, main = "Histogram for R7", xlab = "Number of Fails")
qplot(sumario_random$R8, geom="histogram", binwidth = 1, main = "Histogram for R8", xlab = "Number of Fails")


ggplot(data=sumario_random, aes(sumario_random$R2)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R2") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_random, aes(sumario_random$R4)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R4") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_random, aes(sumario_random$R5)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R5") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_random, aes(sumario_random$R6)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R6") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_random, aes(sumario_random$R7)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R7") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_random, aes(sumario_random$R8)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R8") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R2)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R2 Starred") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R4)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R4 Starred") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R5)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R5 Starred") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R6)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R6 Starred") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R7)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R7 Starred") +
  labs(x="Total of Fails", y="Count")

ggplot(data=sumario_star, aes(sumario_star$R8)) + 
  geom_histogram(breaks=seq(1, 15, by =1),
                 col="red", 
                 aes(fill=..count..)) +
  labs(title="Histogram for R8 Starred") +
  labs(x="Total of Fails", y="Count")
