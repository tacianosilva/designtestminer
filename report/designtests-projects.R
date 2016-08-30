#Script R para gerar os Dados agragados

results_random = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_sample.txt')
results_star = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_starred.txt')

# Número de testes por Projeto
testsByProj_random = aggregate(results_random$class, list(projeto = results_random$project), length)

# Número de testes que falharam
results_projects = aggregate(results_random$project, list(projeto = results_random$project, resultado = results_random$result), length)
testsFail <- results_projects[which(results_projects$resultado == 'false'),]
testsFail["resultado"] <- NULL

#Agregar os resultados por Entidade - Número de Entidades por Projeto
entitiesByProj_random = aggregate(results_random$class, list(projeto = results_random$project), FUN = function(x) length(unique(x)))

# Número de entidades que falharam
falhas <- results_random[which(results_random$result == 'false'),]
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

colnames(entitiesByProj_random) <- c("project", "numEntities")
colnames(entitiesFail) <- c("project", "failEntities")
colnames(testsByProj_random) <- c("project", "numTests")
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

sumario_random = merge(entitiesByProj_random, entitiesFail, all.x=TRUE, incomparables = NULL)
sumario_random[is.na(sumario_random)] <- 0
sumario_random["entities fail proportion"] <- round((sumario_random$failEntities / sumario_random$numEntities) * 100, digits = 1)

sumario_random = merge(sumario_random, testsByProj_random, all.x=TRUE, incomparables = NULL)

sumario_random = merge(sumario_random, testsFail, all.x=TRUE, incomparables = NULL)
sumario_random[is.na(sumario_random)] <- 0
sumario_random["tests fail proportion"] <- round((sumario_random$failTests / (sumario_random$numEntities * 8)) * 100, digits = 1)

sumario_random = merge(sumario_random, rulesFail, all.x=TRUE, incomparables = NULL)
sumario_random[is.na(sumario_random)] <- 0
sumario_random["rules fail proportion"] <- round((sumario_random$failRules / 8) * 100, digits = 1)

sumario_random = merge(sumario_random, failsR1, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR2, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR3, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR4, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR5, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR6, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR7, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR8, all.x=TRUE, incomparables = NULL)

sumario_random[is.na(sumario_random)] <- 0

write.csv(sumario_random, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/sumario_random.csv", row.names=TRUE)

# Amostra de Projetos Estrelados
results_star_projects = aggregate(results_star$project, list(resultado = results_star$result, projeto = results_star$project), length)

# Número de testes por Projeto
testsByProj_star = aggregate(results_star$class, list(projeto = results_star$project), length)

# Número de testes que falharam
results_projects_star = aggregate(results_star$project, list(projeto = results_star$project, resultado = results_star$result), length)
testsFail_star <- results_projects_star[which(results_projects_star$resultado == 'false'),]
testsFail_star["resultado"] <- NULL

#Agregar os resultados por Entidade - Número de Entidades por Projeto
entitiesByProj_star = aggregate(results_star$class, list(projeto = results_star$project), FUN = function(x) length(unique(x)))

# Número de entidades que falharam
falhas_star <- results_star[which(results_star$result == 'false'),]
entitiesFail_star = aggregate(falhas_star$class, list(projeto = falhas_star$project), FUN = function(x) length(unique(x)))

# Número de regras que falharam
rulesFail_star = aggregate(falhas_star$rule, list(projeto = falhas_star$project), FUN = function(x) length(unique(x)))

# Número de falhas da regra 1 - NoArgumentConstructorRule
falhasR1_star <- falhas_star[which(falhas_star$rule == 'NoArgumentConstructorRule'),]
failsR1_star = data.frame(unique(falhas_star$project))
failsR1_star["num"] = 0

# Número de falhas da regra 2 - ProvideIdentifierPropertyRule
falhasR2_star <- falhas_star[which(falhas_star$rule == 'ProvideIdentifierPropertyRule'),]
failsR2_star = aggregate(falhasR2_star$rule, list(projeto = falhasR2_star$project), length)

# Número de falhas da regra 3 - NoFinalClassRule
falhasR3_star <- falhas_star[which(falhas_star$rule == 'NoFinalClassRule'),]
failsR3_star = data.frame(unique(falhas_star$project))
failsR3_star["num"] <- 0

# Número de falhas da regra 4 - ProvideGetsSetsFieldsRule
falhasR4_star <- falhas_star[which(falhas_star$rule == 'ProvideGetsSetsFieldsRule'),]
failsR4_star = aggregate(falhasR4_star$rule, list(projeto = falhasR4_star$project), length)

# Número de falhas da regra 5 - HashCodeAndEqualsRule
falhasR5_star <- falhas_star[which(falhas_star$rule == 'HashCodeAndEqualsRule'),]
failsR5_star = aggregate(falhasR5_star$rule, list(projeto = falhasR5_star$project), length)

# Número de falhas da regra 6 - HashCodeAndEqualsNotUseIdentifierPropertyRule
falhasR6_star <- falhas_star[which(falhas_star$rule == 'HashCodeAndEqualsNotUseIdentifierPropertyRule'),]
failsR6_star = aggregate(falhasR6_star$rule, list(projeto = falhasR6_star$project), length)

# Número de falhas da regra 7 - UseSetCollectionRule
falhasR7_star <- falhas_star[which(falhas_star$rule == 'UseSetCollectionRule'),]
failsR7_star = aggregate(falhasR7_star$rule, list(projeto = falhasR7_star$project), length)

# Número de falhas da regra 8 - ImplementsSerializableRule
falhasR8_star <- falhas_star[which(falhas_star$rule == 'ImplementsSerializableRule'),]
failsR8_star = aggregate(falhasR8_star$rule, list(projeto = falhasR8_star$project), length)

# Tabela com a sumarização de dados
# Projeto, Numero de Entidades, Numero de entidade com falhas, Numero de testes falhos, R1

colnames(entitiesByProj_star) <- c("project", "numEntities")
colnames(entitiesFail_star) <- c("project", "failEntities")
colnames(testsByProj_star) <- c("project", "numTests")
colnames(testsFail_star) <- c("project", "failTests")
colnames(rulesFail_star) <- c("project", "failRules")
colnames(failsR1_star) <- c("project", "R1")
colnames(failsR2_star) <- c("project", "R2")
colnames(failsR3_star) <- c("project", "R3")
colnames(failsR4_star) <- c("project", "R4")
colnames(failsR5_star) <- c("project", "R5")
colnames(failsR6_star) <- c("project", "R6")
colnames(failsR7_star) <- c("project", "R7")
colnames(failsR8_star) <- c("project", "R8")

sumario_star = merge(entitiesByProj_star, entitiesFail_star, all.x=TRUE, incomparables = NULL)
sumario_star[is.na(sumario_star)] <- 0
sumario_star["entities fail proportion"] <- round((sumario_star$failEntities / sumario_star$numEntities) * 100, digits = 1)

sumario_star = merge(sumario_star, testsByProj_star, all.x=TRUE, incomparables = NULL)

sumario_star = merge(sumario_star, testsFail_star, all.x=TRUE, incomparables = NULL)
sumario_star[is.na(sumario_star)] <- 0
sumario_star["tests fail proportion"] <- round((sumario_star$failTests / (sumario_star$numEntities * 8)) * 100, digits = 1)

sumario_star = merge(sumario_star, rulesFail_star, all.x=TRUE, incomparables = NULL)
sumario_star[is.na(sumario_star)] <- 0
sumario_star["rules fail proportion"] <- round((sumario_star$failRules / 8) * 100, digits = 1)

sumario_star = merge(sumario_star, failsR1_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR2_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR3_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR4_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR5_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR6_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR7_star, all.x=TRUE, incomparables = NULL)
sumario_star = merge(sumario_star, failsR8_star, all.x=TRUE, incomparables = NULL)

sumario_star[is.na(sumario_star)] <- 0

write.csv(sumario_star, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/sumario_star.csv", row.names=TRUE)

# Agregados do Sumário - Amostra Randômica e Amostra Estrelada

agregados <- data.frame("func" = c("sum-random", "mean-random", "median-random", "sum-starred", "mean-starred", "median-starred"))

agregados["numEntities"] <- c(sum(sumario_random$numEntities), mean(sumario_random$numEntities), median(sumario_random$numEntities),
                                     sum(sumario_star$numEntities), mean(sumario_star$numEntities), median(sumario_star$numEntities))
agregados["failEntities"] <- c(sum(sumario_random$failEntities), mean(sumario_random$failEntities), median(sumario_random$failEntities),
                                      sum(sumario_star$failEntities), mean(sumario_star$failEntities), median(sumario_star$failEntities))

valor1 = (sum(sumario_random$failEntities) / sum(sumario_random$numEntities))
valor2 = (sum(sumario_star$failEntities) / sum(sumario_star$numEntities))

agregados["entities fail proportion"] <- c(valor1, 
                                                  mean(sumario_random$`entities fail proportion`), median(sumario_random$`entities fail proportion`),
                                                  valor2, 
                                                  mean(sumario_star$`entities fail proportion`), median(sumario_star$`entities fail proportion`))

agregados["numTests"] <- c(sum(sumario_random$numTests), mean(sumario_random$numTests), median(sumario_random$numTests),
                                  sum(sumario_star$numTests), mean(sumario_star$numTests), median(sumario_star$numTests))
agregados["failTests"] <- c(sum(sumario_random$failTests), mean(sumario_random$failTests), median(sumario_random$failTests),
                                   sum(sumario_star$failTests), mean(sumario_star$failTests), median(sumario_star$failTests))

valor3 = sum(sumario_random$failTests) / sum(sumario_random$numTests)
valor4 = sum(sumario_star$failTests) / sum(sumario_star$numTests)

agregados["tests fail proportion"] <- c(valor3, 
                                               mean(sumario_random$`tests fail proportion`), median(sumario_random$numEntities),
                                               valor4, 
                                               mean(sumario_star$`tests fail proportion`), median(sumario_star$numEntities))

agregados["failRules"] <- c(sum(sumario_random$failRules), mean(sumario_random$failRules), median(sumario_random$failRules),
                                   sum(sumario_star$failRules), mean(sumario_star$failRules), median(sumario_star$failRules))

agregados["rules fail proportion"] <- c(sum(sumario_random$failRules) / (40 * 8), 
                                               mean(sumario_random$`rules fail proportion`), median(sumario_random$`rules fail proportion`),
                                               sum(sumario_star$failRules) / (40 * 8), 
                                               mean(sumario_star$`rules fail proportion`), median(sumario_star$`rules fail proportion`))

x <- sumario_random$failRules
h<-hist(x, breaks = 8, col="red", xlab="Número de Entidades Por Projeto",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2) 

x <- sumario_random$`rules fail proportion`
h<-hist(x, breaks = 10, col="red", xlab="Número de Entidades Por Projeto",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2) 