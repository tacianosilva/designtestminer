#Script R para gerar os Dados agragados sobre as Entidades Persistentes

results = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_sample.txt')
results_star = read.csv('/home/taciano/dev/workspace/designtestminer/datasets/results/tests_results_starred.txt')

#Resultados por Entidade Persistente

# ----------------- Primeira Amostra - Random ----------------------

#Agregar os resultados por Entidade
results_entities_random = aggregate(results$project, list(resultado = results$result, entidade = results$class), length)

#Agregar os resultados por Entidade
entitiesByProj_random = aggregate(results$class, list(resultado = results$project), FUN = function(x) length(unique(x)))

#Média de Entidades Persistentes por Projeto
soma_random_1 = sum(entitiesByProj_random$x)
media_random_1 = mean(entitiesByProj_random$x)

#Total de Testes por Entidade (Sempre 8 que é o número de regras)
results_entities_random_total = aggregate(results$class, list(resultado = results$class), length)
colnames(results_entities_random_total) <- c("entidade", "total")

#Filtrando pelas regras que falharam
results_entities_random.falhou <- results_entities_random[which(results_entities_random$resultado == 'false'),]
results_entities_random.falhou["resultado"] <- NULL
colnames(results_entities_random.falhou) <- c("entidade", "falhou")

#Juntando os totais com a tabela de falhas
results_entities_random_falhou = merge(results_entities_random_total, results_entities_random.falhou, all.x=TRUE, incomparables = NULL)
results_entities_random_falhou[is.na(results_entities_random_falhou)] <- 0
results_entities_random_falhou["proporcao"] <- results_entities_random_falhou$falhou / results_entities_random_falhou$total

# Proporção Média de Entidades com Falhas
media_random_2 = mean(results_entities_random_falhou$proporcao)

# ----------------- Segunda Amostra - Starred ----------------------

#Agregar os resultados por Entidade
results_entities_starred = aggregate(results_star$project, list(resultado = results_star$result, entidade = results_star$class), length)

#Agregar os resultados por Entidade
entitiesByProj_starred = aggregate(results_star$class, list(resultado = results_star$project), FUN = function(x) length(unique(x)))

#Média de Entidades Persistentes por Projeto
soma_atar_1 = sum(entitiesByProj_starred$x)
media_atar_1 = mean(entitiesByProj_starred$x)

#Total de Testes por Entidade (Sempre 8 que é o número de regras)
results_entities_starred_total = aggregate(results_star$class, list(resultado = results_star$class), length)
colnames(results_entities_starred_total) <- c("entidade", "total")

#Filtrando pelas regras que falharam
results_entities_starred.falhou <- results_entities_starred[which(results_entities_starred$resultado == 'false'),]
results_entities_starred.falhou["resultado"] <- NULL
colnames(results_entities_starred.falhou) <- c("entidade", "falhou")

#Juntando os totais com a tabela de falhas
results_entities_starred_falhou = merge(results_entities_starred_total, results_entities_starred.falhou, all.x=TRUE, incomparables = NULL)
results_entities_starred_falhou[is.na(results_entities_starred_falhou)] <- 0
results_entities_starred_falhou["proporcao"] <- results_entities_starred_falhou$falhou / results_entities_starred_falhou$total

# Proporção Média de Entidades com Falhas
media_star_2 = mean(results_entities_starred_falhou$proporcao)

