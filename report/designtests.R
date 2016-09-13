#Script R para gerar os Dados agragados

results = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_sample.txt')
results_star = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_starred.txt')

results_rules = aggregate(results$rule, list(resultado = results$result, regra = results$rule), length)
results_rules_total = aggregate(results$rule, list(resultado = results$rule), length)
colnames(results_rules_total) <- c("regra", "total")

results_rules.falhou <- results_rules[which(results_rules$resultado == 'false'),]
results_rules.falhou["resultado"] <- NULL
colnames(results_rules.falhou) <- c("regra", "falhou")

results_rules_falhou = merge(results_rules_total, results_rules.falhou, all.x=TRUE, incomparables = NULL)
results_rules_falhou[is.na(results_rules_falhou)] <- 0
results_rules_falhou["proporcao"] <- results_rules_falhou$falhou / results_rules_falhou$total

results_star_rules = aggregate(results_star$rule, list(resultado = results_star$result, regra = results_star$rule), length)
results_star_rules_total = aggregate(results_star$rule, list(resultado = results_star$rule), length)
colnames(results_star_rules_total) <- c("regra", "total")

results_star_rules.falhou <- results_star_rules[which(results_star_rules$resultado == 'false'),]
results_star_rules.falhou["resultado"] <- NULL
colnames(results_star_rules.falhou) <- c("regra", "falhou")

results_star_rules_falhou = merge(results_star_rules_total, results_star_rules.falhou, all.x=TRUE, incomparables = NULL)
results_star_rules_falhou[is.na(results_star_rules_falhou)] <- 0
results_star_rules_falhou["proporcao"] <- results_star_rules_falhou$falhou / results_star_rules_falhou$total

results_projects = aggregate(results$project, list(resultado = results$result, projeto = results$project), length)
results_star_projects = aggregate(results_star$project, list(resultado = results_star$result, projeto = results_star$project), length)

results_total = aggregate(results$project, list(resultado = results$project), length)
colnames(results_total) <- c("projeto", "total")
results_star_total = aggregate(results_star$project, list(resultado = results_star$project), length)
colnames(results_star_total) <- c("projeto", "total")

results_projects.passou <- results_projects[which(results_projects$resultado == 'true'),]
results_projects.falhou <- results_projects[which(results_projects$resultado == 'false'),]

results_star_projects.passou <- results_star_projects[which(results_star_projects$resultado == 'true'),]
results_star_projects.falhou <- results_star_projects[which(results_star_projects$resultado == 'false'),]

results_projects.falhou["resultado"] <- NULL
colnames(results_projects.falhou) <- c("projeto", "falhou")
results_proj_falhou = merge(results_total, results_projects.falhou, all.x=TRUE, incomparables = NULL)
results_proj_falhou[is.na(results_proj_falhou)] <- 0
results_proj_falhou["proporcao"] <- results_proj_falhou$falhou / results_proj_falhou$total

results_star_projects.falhou["resultado"] <- NULL
colnames(results_star_projects.falhou) <- c("projeto", "falhou")
results_star_proj_falhou = merge(results_star_total, results_star_projects.falhou, all.x=TRUE, incomparables = NULL)
results_star_proj_falhou[is.na(results_star_proj_falhou)] <- 0
results_star_proj_falhou["proporcao"] <- results_star_proj_falhou$falhou / results_star_proj_falhou$total

#Resultados de proporções de falhas por tipo de amostra

amostra1 = results_proj_falhou["projeto"]
amostra2 = results_star_proj_falhou["projeto"]

#Totais
violacoes.random_totalDeFalhas = sum(results_proj_falhou$falhou)
violacoes.random_totalDeAcertos = sum(results_projects.passou$x)
violacoes.random_totalDeTestes = sum(results_proj_falhou$total)
violacoes.random_MediaDeFalhasProjects = mean(results_proj_falhou$proporcao)

violacoes.random_MediaDeFalhasRules = mean(results_rules_falhou$proporcao)

violacoes.stared_totalDeFalhas = sum(results_star_proj_falhou$falhou)
violacoes.stared_totalDeAcertos = sum(results_star_projects.passou$x)
violacoes.stared_totalDeTestes = sum(results_star_proj_falhou$total)
violacoes.stared_MediaDeFalhas = mean(results_star_proj_falhou$proporcao)

amostra1["proporcao"] <- results_proj_falhou["proporcao"]
amostra1["tipo"] <- "random"

amostra2["proporcao"] <- results_star_proj_falhou["proporcao"]
amostra2["tipo"] <- "starred"

falhas <- rbind(amostra1, amostra2)

library(lawstat)

# Teste de homocedastidade (Homogeneidade da variância)
levene.test(falhas$proporcao, falhas$tipo)

# Testes de Normalidade
shapiro.test(amostra1$proporcao)
shapiro.test(amostra2$proporcao)

shapiro.test(falhas$proporcao)

# Teste da Igualdade das médias
t.test(falhas$proporcao ~ falhas$tipo, paired=FALSE, var.equal=TRUE)

# Gráfico com as médias dos projetos
boxplot(falhas$proporcao ~ falhas$tipo, data=falhas, main="Failure proportions of Projects", xlab="Samples", ylab="Proportions")

# Testa se duas ou mais amostras de distribuições normais têm as mesmas médias.
# As variâncias não são necessariamente assumida como sendo igual.
oneway.test(falhas$proporcao ~ falhas$tipo, data=falhas, na.action=na.omit, var.equal=TRUE)

anova(falhas$proporcao ~ falhas$tipo, data=falhas)

write.csv(results_proj_falhou, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/results_proportions.txt", row.names=FALSE)
write.csv(results_star_proj_falhou, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/results_star_proportions.txt", row.names=FALSE)
write.csv(results_rules_falhou, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/results_rules_proportions.txt", row.names=FALSE)
write.csv(results_star_rules_falhou, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/results_star_rules_proportions.txt", row.names=FALSE)
