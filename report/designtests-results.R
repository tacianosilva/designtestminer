# Carregamento dos Resultados dos Testes

#setwd("/home/taciano/dev/workspace/designtestminer/datasets/results")
setwd("/local_home/tacianosilva/workspace/designtestminer/datasets/results")

results_random = read.csv(paste(getwd(),'/tests_results_sample.txt', sep = ""))
results_starry = read.csv(paste(getwd(),'/tests_results_starred.txt', sep = ""))
results_full = rbind(results_random, results_starry)
