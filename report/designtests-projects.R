#Script R para gerar os Dados agragados

results_random = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_sample.txt')
results_star = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_starred.txt')

#Agregar os resultados por Entidade - Número de Entidades por Projeto
entitiesByProj_random = aggregate(results_random$class, list(projeto = results_random$project), FUN = function(x) length(unique(x)))

# Número de testes por Projeto
testesByProj_random = aggregate(results_random$class, list(projeto = results_random$project), length)

# Número de testes que falharam
results_projects = aggregate(results_random$project, list(projeto = results_random$project, resultado = results_random$result), length)
testsFail <- results_projects[which(results_projects$resultado == 'false'),]
testsFail["resultado"] <- NULL

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
falhasR5.1 <- falhas[which(falhas$rule == 'HashCodeAndEqualsRule'),]
failsR5.1 = aggregate(falhasR5.1$rule, list(projeto = falhasR5.1$project), length)

# Número de falhas da regra 5.2 - HashCodeAndEqualsNotUseIdentifierPropertyRule
falhasR5.2 <- falhas[which(falhas$rule == 'HashCodeAndEqualsNotUseIdentifierPropertyRule'),]
failsR5.2 = aggregate(falhasR5.2$rule, list(projeto = falhasR5.2$project), length)

# Número de falhas da regra 6 - UseSetCollectionRule
falhasR6 <- falhas[which(falhas$rule == 'UseSetCollectionRule'),]
failsR6 = aggregate(falhasR6$rule, list(projeto = falhasR6$project), length)

# Número de falhas da regra 7 - ImplementsSerializableRule
falhasR7 <- falhas[which(falhas$rule == 'ImplementsSerializableRule'),]
failsR7 = aggregate(falhasR7$rule, list(projeto = falhasR7$project), length)

# Tabela com a sumarização de dados
# Projeto, Numero de Entidades, Numero de entidade com falhas, Numero de testes falhos, R1

colnames(entitiesByProj_random) <- c("project", "numEntities")
colnames(entitiesFail) <- c("project", "failEntities")
colnames(testsFail) <- c("project", "failTests")
colnames(rulesFail) <- c("project", "failRules")
colnames(failsR1) <- c("project", "R1")
colnames(failsR2) <- c("project", "R2")
colnames(failsR3) <- c("project", "R3")
colnames(failsR4) <- c("project", "R4")
colnames(failsR5.1) <- c("project", "R5.1")
colnames(failsR5.2) <- c("project", "R5.2")
colnames(failsR6) <- c("project", "R6")
colnames(failsR7) <- c("project", "R7")

sumario_random = merge(entitiesByProj_random, entitiesFail, all.x=TRUE, incomparables = NULL)
sumario_random[is.na(sumario_random)] <- 0
sumario_random["entities fail proportion"] <- round((sumario_random$failEntities / sumario_random$numEntities) * 100, digits = 1)

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
sumario_random = merge(sumario_random, failsR5.1, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR5.2, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR6, all.x=TRUE, incomparables = NULL)
sumario_random = merge(sumario_random, failsR7, all.x=TRUE, incomparables = NULL)

sumario_random[is.na(sumario_random)] <- 0

write.csv(sumario_random, file = "/home/taciano/dev/workspace/designtestminer/datasets/analysis/sumario_random.csv", row.names=TRUE)

# Agregados do Sumário - Amostra Randômica

agregados_random <- data.frame("func" = c("sum", "mean", "median"))
agregados_random["numEntities"] <- c(sum(sumario_random$numEntities), mean(sumario_random$numEntities), median(sumario_random$numEntities))
agregados_random["failEntities"] <- c(sum(sumario_random$failEntities), mean(sumario_random$failEntities), median(sumario_random$failEntities))

agregados_random["entities fail proportion"] <- c(NA, 
                                                  mean(sumario_random$`entities fail proportion`), median(sumario_random$`entities fail proportion`))

agregados_random["failTests"] <- c(sum(sumario_random$failTests), mean(sumario_random$failTests), median(sumario_random$failTests))

agregados_random["tests fail proportion"] <- c(NA, 
                                               mean(sumario_random$`tests fail proportion`), median(sumario_random$numEntities))

agregados_random["failRules"] <- c(sum(sumario_random$failRules), mean(sumario_random$failRules), median(sumario_random$failRules))

agregados_random["rules fail proportion"] <- c(NA, 
                                               mean(sumario_random$`rules fail proportion`), median(sumario_random$`rules fail proportion`))

x <- sumario_random$`tests fail proportion`
h<-hist(x, col="red", xlab="Número de Entidades Por Projeto",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2) 

x <- sumario_random$`rules fail proportion`
h<-hist(x, col="red", xlab="Número de Entidades Por Projeto",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2) 

# Amostra de Projetos Estrelados
results_star_projects = aggregate(results_star$project, list(resultado = results_star$result, projeto = results_star$project), length)

