# Carregar os resultados (results_epol)
source("designtests-results.R")

# Número de testes por Projeto
testsByProj_epol = aggregate(results_epol$class, list(projeto = results_epol$project), length)

# Número de testes que falharam
results_projects = aggregate(results_epol$project, list(projeto = results_epol$project, resultado = results_epol$result), length)
testsFail <- results_projects[which(results_projects$resultado == 'false'),]
testsFail["resultado"] <- NULL

#Agregar os resultados por Entidade - Número de Entidades por Projeto
entitiesByProj_epol = aggregate(results_epol$class, list(projeto = results_epol$project), FUN = function(x) length(unique(x)))

# Número de entidades que falharam
falhas <- results_epol[which(results_epol$result == 'false'),]
entitiesFail = aggregate(falhas$class, list(projeto = falhas$project), FUN = function(x) length(unique(x)))

# Número de regras que falharam
rulesFail = aggregate(falhas$rule, list(projeto = falhas$project), FUN = function(x) length(unique(x)))

# Número de falhas da regra 1 - NoArgumentConstructorRule
falhasR1 <- falhas[which(falhas$rule == 'NoArgumentConstructorRule'),]
failsR1 = data.frame(unique(falhas$project))
failsR1["num"] = 0

# Número de falhas da regra 2 - ProvideIdentifierPropertyRule
falhasR2 <- falhas[which(falhas$rule == 'ProvideIdentifierPropertyRule'),]
failsR2 = data.frame(unique(falhas$project))
failsR2["num"] = 0

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
failsR8 = data.frame(unique(falhas$project))
failsR8["num"] = 0

# Tabela com a sumarização de dados
# Projeto, Numero de Entidades, Numero de entidade com falhas, Numero de testes falhos, R1

colnames(entitiesByProj_epol) <- c("project", "numEntities")
colnames(entitiesFail) <- c("project", "failEntities")
colnames(testsByProj_epol) <- c("project", "numTests")
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

sumario_epol = merge(entitiesByProj_epol, entitiesFail, all.x=TRUE, incomparables = NULL)
sumario_epol[is.na(sumario_epol)] <- 0
sumario_epol["entities fail proportion"] <- round((sumario_epol$failEntities / sumario_epol$numEntities) * 100, digits = 1)

sumario_epol = merge(sumario_epol, testsByProj_epol, all.x=TRUE, incomparables = NULL)

sumario_epol = merge(sumario_epol, testsFail, all.x=TRUE, incomparables = NULL)
sumario_epol[is.na(sumario_epol)] <- 0
sumario_epol["tests fail proportion"] <- round((sumario_epol$failTests / (sumario_epol$numEntities * 8)) * 100, digits = 1)

sumario_epol = merge(sumario_epol, rulesFail, all.x=TRUE, incomparables = NULL)
sumario_epol[is.na(sumario_epol)] <- 0
sumario_epol["rules fail proportion"] <- round((sumario_epol$failRules / 8) * 100, digits = 1)

sumario_epol = merge(sumario_epol, failsR1, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR2, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR3, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR4, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR5, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR6, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR7, all.x=TRUE, incomparables = NULL)
sumario_epol = merge(sumario_epol, failsR8, all.x=TRUE, incomparables = NULL)

sumario_epol[is.na(sumario_epol)] <- 0

#cor.test(sumario_epol$R2, sumario_epol$R4, method="spearman")
#cor.test(sumario_epol$R2, sumario_epol$R6, method="spearman")
#cor.test(sumario_epol$R2, sumario_epol$R7, method="spearman")
#cor.test(sumario_epol$R2, sumario_epol$R8, method="spearman")

#cor.test(sumario_epol$R4, sumario_epol$R6, method="spearman")
#cor.test(sumario_epol$R4, sumario_epol$R7, method="spearman")
#cor.test(sumario_epol$R4, sumario_epol$R8, method="spearman")

#cor.test(sumario_epol$R6, sumario_epol$R7, method="spearman")
#cor.test(sumario_epol$R6, sumario_epol$R8, method="spearman")

#cor.test(sumario_epol$R7, sumario_epol$R8, method="spearman")

write.csv(sumario_epol, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/sumario_epol.csv", row.names=TRUE)

#Agregados do Sumário - Amostra Randômica e Amostra Estrelada

agregados <- data.frame("func" = c("sum", "mean", "median"))

agregados["numEntities"] <- c(sum(sumario_epol$numEntities), mean(sumario_epol$numEntities), median(sumario_epol$numEntities))
agregados["failEntities"] <- c(sum(sumario_epol$failEntities), mean(sumario_epol$failEntities), median(sumario_epol$failEntities))

valor1 = (sum(sumario_epol$failEntities) / sum(sumario_epol$numEntities))


agregados["entities fail proportion"] <- c(valor1, 
                                           mean(sumario_epol$`entities fail proportion`), median(sumario_epol$`entities fail proportion`))

agregados["numTests"] <- c(sum(sumario_epol$numTests), mean(sumario_epol$numTests), median(sumario_epol$numTests))
agregados["failTests"] <- c(sum(sumario_epol$failTests), mean(sumario_epol$failTests), median(sumario_epol$failTests))

valor2 = sum(sumario_epol$failTests) / sum(sumario_epol$numTests)

agregados["tests fail proportion"] <- c(valor2, 
                                        mean(sumario_epol$`tests fail proportion`), median(sumario_epol$`tests fail proportion`))

agregados["failRules"] <- c(sum(sumario_epol$failRules), mean(sumario_epol$failRules), median(sumario_epol$failRules))

agregados["rules fail proportion"] <- c(sum(sumario_epol$failRules) / (1 * 8), 
                                        mean(sumario_epol$`rules fail proportion`), median(sumario_epol$`rules fail proportion`))

