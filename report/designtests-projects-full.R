# Carregar os resultados (results_random, results_starry, results_full)
source("designtests-results.R")

# Número de testes por Projeto
testsByProj_full = aggregate(results_full$class, list(projeto = results_full$project), length)

# Número de testes que falharam
results_projects = aggregate(results_full$project, list(projeto = results_full$project, resultado = results_full$result), length)
testsFail <- results_projects[which(results_projects$resultado == 'false'),]
testsFail["resultado"] <- NULL

#Agregar os resultados por Entidade - Número de Entidades por Projeto
entitiesByProj_full = aggregate(results_full$class, list(projeto = results_full$project), FUN = function(x) length(unique(x)))

# Número de entidades que falharam
falhas <- results_full[which(results_full$result == 'false'),]
entitiesFail = aggregate(falhas$class, list(projeto = falhas$project), FUN = function(x) length(unique(x)))

# Número de regras que falharam
rulesFail = aggregate(falhas$rule, list(projeto = falhas$project), FUN = function(x) length(unique(x)))

# Número de falhas da regra 1 - NoArgumentConstructorRule
falhasR1 <- falhas[which(falhas$rule == 'NoArgumentConstructorRule'),]
failsR1 = data.frame(unique(falhas$project))
failsR1["num"] = 0

# Número de falhas da regra 2 - ProvideIdentifierPropertyRule
falhasR2 <- falhas[which(falhas$rule == 'ProvideIdentifierPropertyRule'),]
failsR2 = aggregate(falhasR2$rule, list(projeto = falhasR2$project), length)

# Número de falhas da regra 3 - NoFinalClassRule
falhasR3 <- falhas[which(falhas$rule == 'NoFinalClassRule'),]
failsR3 = data.frame(unique(falhas$project))
failsR3["num"] <- 0

# Número de falhas da regra 4 - ProvideGetsSetsFieldsRule
falhasR4 <- falhas[which(falhas$rule == 'ProvideGetsSetsFieldsRule'),]
failsR4 = aggregate(falhasR4$rule, list(projeto = falhasR4$project), length)

# Número de falhas da regra 5.1 - HashCodeAndEqualsRule
falhasR5 <- falhas[which(falhas$rule == 'HashCodeAndEqualsRule'),]
failsR5 = aggregate(falhasR5$rule, list(projeto = falhasR5$project), length)

# Número de falhas da regra 6 - HashCodeAndEqualsNotUseIdentifierPropertyRule
falhasR6 <- falhas[which(falhas$rule == 'HashCodeAndEqualsNotUseIdentifierPropertyRule'),]
failsR6 = aggregate(falhasR6$rule, list(projeto = falhasR6$project), length)

# Número de falhas da regra 7 - UseSetCollectionRule
falhasR7 <- falhas[which(falhas$rule == 'UseSetCollectionRule'),]
failsR7 = aggregate(falhasR7$rule, list(projeto = falhasR7$project), length)

# Número de falhas da regra 8 - ImplementsSerializableRule
falhasR8 <- falhas[which(falhas$rule == 'ImplementsSerializableRule'),]
failsR8 = aggregate(falhasR8$rule, list(projeto = falhasR8$project), length)

# Tabela com a sumarização de dados
# Projeto, Numero de Entidades, Numero de entidade com falhas, Numero de testes falhos, R1

colnames(entitiesByProj_full) <- c("project", "numEntities")
colnames(entitiesFail) <- c("project", "failEntities")
colnames(testsByProj_full) <- c("project", "numTests")
colnames(testsFail) <- c("project", "failTests")
colnames(rulesFail) <- c("project", "failRules")
colnames(failsR1) <- c("project", "R1")
colnames(failsR2) <- c("project", "R2")
colnames(failsR3) <- c("project", "R3")
colnames(failsR4) <- c("project", "R4")
colnames(failsR5) <- c("project", "R5")
colnames(failsR6) <- c("project", "R6")
colnames(failsR7) <- c("project", "R7")
colnames(failsR8) <- c("project", "R8")

sumario_full = merge(entitiesByProj_full, entitiesFail, all.x=TRUE, incomparables = NULL)
sumario_full[is.na(sumario_full)] <- 0
sumario_full["entities fail proportion"] <- round((sumario_full$failEntities / sumario_full$numEntities) * 100, digits = 1)

sumario_full = merge(sumario_full, testsByProj_full, all.x=TRUE, incomparables = NULL)

sumario_full = merge(sumario_full, testsFail, all.x=TRUE, incomparables = NULL)
sumario_full[is.na(sumario_full)] <- 0
sumario_full["tests fail proportion"] <- round((sumario_full$failTests / (sumario_full$numEntities * 8)) * 100, digits = 1)

sumario_full = merge(sumario_full, rulesFail, all.x=TRUE, incomparables = NULL)
sumario_full[is.na(sumario_full)] <- 0
sumario_full["rules fail proportion"] <- round((sumario_full$failRules / 8) * 100, digits = 1)

sumario_full = merge(sumario_full, failsR1, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR2, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR3, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR4, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR5, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR6, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR7, all.x=TRUE, incomparables = NULL)
sumario_full = merge(sumario_full, failsR8, all.x=TRUE, incomparables = NULL)

sumario_full[is.na(sumario_full)] <- 0

cor.test(sumario_full$R2, sumario_full$R4, method="spearman")
cor.test(sumario_full$R2, sumario_full$R6, method="spearman")
cor.test(sumario_full$R2, sumario_full$R7, method="spearman")
cor.test(sumario_full$R2, sumario_full$R8, method="spearman")

cor.test(sumario_full$R4, sumario_full$R6, method="spearman")
cor.test(sumario_full$R4, sumario_full$R7, method="spearman")
cor.test(sumario_full$R4, sumario_full$R8, method="spearman")

cor.test(sumario_full$R6, sumario_full$R7, method="spearman")
cor.test(sumario_full$R6, sumario_full$R8, method="spearman")

cor.test(sumario_full$R7, sumario_full$R8, method="spearman")

write.csv(sumario_full, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/sumario_full.csv", row.names=TRUE)

#Agregados do Sumário - Amostra Randômica e Amostra Estrelada

agregados <- data.frame("func" = c("sum", "mean", "median"))

agregados["numEntities"] <- c(sum(sumario_full$numEntities), mean(sumario_full$numEntities), median(sumario_full$numEntities))
agregados["failEntities"] <- c(sum(sumario_full$failEntities), mean(sumario_full$failEntities), median(sumario_full$failEntities))

valor1 = (sum(sumario_full$failEntities) / sum(sumario_full$numEntities))


agregados["entities fail proportion"] <- c(valor1, 
                                           mean(sumario_full$`entities fail proportion`), median(sumario_full$`entities fail proportion`))

agregados["numTests"] <- c(sum(sumario_full$numTests), mean(sumario_full$numTests), median(sumario_full$numTests))
agregados["failTests"] <- c(sum(sumario_full$failTests), mean(sumario_full$failTests), median(sumario_full$failTests))

valor2 = sum(sumario_full$failTests) / sum(sumario_full$numTests)

agregados["tests fail proportion"] <- c(valor2, 
                                        mean(sumario_full$`tests fail proportion`), median(sumario_full$`tests fail proportion`))

agregados["failRules"] <- c(sum(sumario_full$failRules), mean(sumario_full$failRules), median(sumario_full$failRules))

agregados["rules fail proportion"] <- c(sum(sumario_full$failRules) / (77 * 8), 
                                        mean(sumario_full$`rules fail proportion`), median(sumario_full$`rules fail proportion`))

