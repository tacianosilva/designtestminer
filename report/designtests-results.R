# Carregamento dos Resultados dos Testes

results_random = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_sample.txt')
results_starry = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_starred.txt')
results_full = rbind(results_random, results_starry)
