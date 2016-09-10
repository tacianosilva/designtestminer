# Carregar os resultados (results_random, results_starry, results_full)
source("designtests-results.R")
# install.packages('VennDiagram')
library(VennDiagram)

# Script para calcular interseção de entidades com as mesmas violações arquiteturais

# Selecionando os testes que falham
fails_full <- results_full[which(results_full$result == 'false'),]

# Número de entidades que falham na regra 1 - NoArgumentConstructorRule
fails_entities_R1 <- fails_full[which(fails_full$rule == 'NoArgumentConstructorRule'),]
fails_entities_R1 <- data.frame(unique(fails_full$class))
fails_entities_R1["R1"] = 0
colnames(fails_entities_R1) <- c("entities", "R1")

# Número de entidades que falham na regra 2 - ProvideIdentifierPropertyRule
fails_entities_R2 <- fails_full[which(fails_full$rule == 'ProvideIdentifierPropertyRule'),]
fails_entities_R2 = aggregate(fails_entities_R2$rule, list(entities = fails_entities_R2$class), length)
colnames(fails_entities_R2) <- c("entities", "R2")

# Número de falhas da regra 3 - NoFinalClassRule
fails_entities_R3 <- fails_full[which(fails_full$rule == 'NoFinalClassRule'),]
fails_entities_R3 = data.frame(unique(fails_full$class))
fails_entities_R3["R3"] <- 0
colnames(fails_entities_R3) <- c("entities", "R3")

# Número de falhas da regra 4 - ProvideGetsSetsFieldsRule
fails_entities_R4 <- fails_full[which(fails_full$rule == 'ProvideGetsSetsFieldsRule'),]
fails_entities_R4 = aggregate(fails_entities_R4$rule, list(entities = fails_entities_R4$class), length)
colnames(fails_entities_R4) <- c("entities", "R4")

# Número de falhas da regra 5 - HashCodeAndEqualsRule
fails_entities_R5 <- fails_full[which(fails_full$rule == 'HashCodeAndEqualsRule'),]
fails_entities_R5 = aggregate(fails_entities_R5$rule, list(entities = fails_entities_R5$class), length)
colnames(fails_entities_R5) <- c("entities", "R5")

# Número de falhas da regra 6 - HashCodeAndEqualsNotUseIdentifierPropertyRule
fails_entities_R6 <- fails_full[which(fails_full$rule == 'HashCodeAndEqualsNotUseIdentifierPropertyRule'),]
fails_entities_R6 = aggregate(fails_entities_R6$rule, list(entities = fails_entities_R6$class), length)
colnames(fails_entities_R6) <- c("entities", "R6")

# Número de falhas da regra 7 - UseSetCollectionRule
fails_entities_R7 <- fails_full[which(fails_full$rule == 'UseSetCollectionRule'),]
fails_entities_R7 = aggregate(fails_entities_R7$rule, list(entities = fails_entities_R7$class), length)
colnames(fails_entities_R7) <- c("entities", "R7")

# Número de falhas da regra 8 - ImplementsSerializableRule
fails_entities_R8 <- fails_full[which(fails_full$rule == 'ImplementsSerializableRule'),]
fails_entities_R8 = aggregate(fails_entities_R8$rule, list(entities = fails_entities_R8$class), length)
colnames(fails_entities_R8) <- c("entities", "R8")

d = merge(fails_entities_R1, fails_entities_R2, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R3, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R4, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R5, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R6, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R7, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0
d = merge(d, fails_entities_R8, all.x=TRUE, incomparables = NULL)
d[is.na(d)] <- 0

# Criando os subconjuntos de projetos que falharam em determinada regra.
subsetR1 <- subset(d, d$R1 > 0)
subsetR2 <- subset(d, d$R2 > 0)
subsetR3 <- subset(d, d$R3 > 0)
subsetR4 <- subset(d, d$R4 > 0)
subsetR5 <- subset(d, d$R5 > 0)
subsetR6 <- subset(d, d$R6 > 0)
subsetR7 <- subset(d, d$R7 > 0)
subsetR8 <- subset(d, d$R8 > 0)

subR2R4 <- subset(d, d$R2 > 0 & d$R4 > 0)
subR2R5 <- subset(d, d$R2 > 0 & d$R5 > 0)
subR2R6 <- subset(d, d$R2 > 0 & d$R6 > 0)
subR2R7 <- subset(d, d$R2 > 0 & d$R7 > 0)
subR2R8 <- subset(d, d$R2 > 0 & d$R8 > 0)

subR4R5 <- subset(d, d$R4 > 0 & d$R5 > 0)
subR4R6 <- subset(d, d$R4 > 0 & d$R6 > 0)
subR4R7 <- subset(d, d$R4 > 0 & d$R7 > 0)
subR4R8 <- subset(d, d$R4 > 0 & d$R8 > 0)
subR5R6 <- subset(d, d$R5 > 0 & d$R6 > 0)

subR6R7 <- subset(d, d$R6 > 0 & d$R7 > 0)
subR6R8 <- subset(d, d$R6 > 0 & d$R8 > 0)
subR7R8 <- subset(d, d$R7 > 0 & d$R8 > 0)

subR2R4R5 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R5 > 0)
subR2R4R6 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R6 > 0)
subR2R4R7 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R7 > 0)
subR2R4R8 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R8 > 0)
subR2R5R6 <- subset(d, d$R2 > 0 & d$R5 > 0 & d$R6 > 0)
subR2R6R7 <- subset(d, d$R2 > 0 & d$R6 > 0 & d$R7 > 0)
subR2R6R8 <- subset(d, d$R2 > 0 & d$R6 > 0 & d$R8 > 0)
subR2R7R8 <- subset(d, d$R2 > 0 & d$R7 > 0 & d$R8 > 0)
subR4R6R7 <- subset(d, d$R4 > 0 & d$R6 > 0 & d$R7 > 0)
subR4R6R8 <- subset(d, d$R4 > 0 & d$R6 > 0 & d$R8 > 0)
subR4R7R8 <- subset(d, d$R4 > 0 & d$R7 > 0 & d$R8 > 0)
subR4R5R6 <- subset(d, d$R4 > 0 & d$R5 > 0 & d$R6 > 0)
subR6R7R8 <- subset(d, d$R6 > 0 & d$R7 > 0 & d$R8 > 0)

subR2R4R5R6 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R5 > 0 & d$R6 > 0)
subR2R4R6R7 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R6 > 0 & d$R7 > 0)
subR2R4R6R8 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R6 > 0 & d$R8 > 0)
subR2R4R7R8 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R7 > 0 & d$R8 > 0)
subR2R6R7R8 <- subset(d, d$R2 > 0 & d$R6 > 0 & d$R7 > 0 & d$R8 > 0)
subR4R6R7R8 <- subset(d, d$R4 > 0 & d$R6 > 0 & d$R7 > 0 & d$R8 > 0)

subR2R4R6R7R8 <- subset(d, d$R2 > 0 & d$R4 > 0 & d$R6 > 0 & d$R7 > 0 & d$R8 > 0)

#
#png("diagramaVennR2R4.png",width=800, height=600)
grid.newpage()
draw.pairwise.venn(area1 = nrow(subsetR2), 
                   area2 = nrow(subsetR4), 
                   cross.area = nrow(subR2R4),
                   category = c("R2", "R4"),
                   fill = c("skyblue", "pink1"))
#dev.off()

grid.newpage()
#png("diagramaVennR7R8.png",width=800, height=600)
draw.pairwise.venn(area1 = nrow(subsetR7), 
                   area2 = nrow(subsetR8), 
                   cross.area = nrow(subR7R8),
                   category = c("R7", "R8"),
                   fill = c("skyblue", "pink1"))

#dev.off()

grid.newpage()
#png("diagramaVennR2R4R6.png",width=800, height=600)
draw.triple.venn(area1 = nrow(subsetR2), 
                 area2 = nrow(subsetR4), 
                 area3 = nrow(subsetR6), 
                 n12 = nrow(subR2R4), 
                 n23 = nrow(subR4R6), 
                 n13 = nrow(subR2R6), 
                 n123 = nrow(subR2R4R6), 
                 category = c("R2", "R4", "R6"), 
                 fill = c("skyblue", "pink1", "mediumorchid"))
#dev.off()

grid.newpage()
draw.triple.venn(area1 = nrow(subsetR2), 
                 area2 = nrow(subsetR4), 
                 area3 = nrow(subsetR5), 
                 n12 = nrow(subR2R4), 
                 n23 = nrow(subR4R5), 
                 n13 = nrow(subR2R5), 
                 n123 = nrow(subR2R4R5), 
                 category = c("R2", "R4", "R5"), 
                 fill = c("skyblue", "pink1", "mediumorchid"))

grid.newpage()
#png("diagramaVennR2R4R5R6.png",width=800, height=600)
draw.quad.venn(area1 = nrow(subsetR2), 
               area2 = nrow(subsetR4), 
               area3 = nrow(subsetR5), 
               area4 = nrow(subsetR6),
               n12 = nrow(subR2R4), 
               n13 = nrow(subR2R5), 
               n14 = nrow(subR2R6),
               n23 = nrow(subR4R5),
               n24 = nrow(subR4R6),
               n34 = nrow(subR5R6),
               n123 = nrow(subR2R4R5), 
               n124 = nrow(subR2R4R6),
               n134 = nrow(subR2R5R6),
               n234 = nrow(subR4R5R6),
               n1234 = nrow(subR2R4R5R6),
               category = c("R2", "R4", "R5", "R6"), 
               fill = c("skyblue", "pink1", "mediumorchid", "green"))
#dev.off()

grid.newpage()
#png("diagramaVennR2R4R6R7R8.png",width=800, height=600)
draw.quintuple.venn(area1 = nrow(subsetR2), 
                    area2 = nrow(subsetR4), 
                    area3 = nrow(subsetR6), 
                    area4 = nrow(subsetR7),
                    area5 = nrow(subsetR8),
                    n12 = nrow(subR2R4), 
                    n13 = nrow(subR2R6),
                    n14 = nrow(subR2R7),
                    n15 = nrow(subR2R8),
                    n23 = nrow(subR4R6),
                    n24 = nrow(subR4R7),
                    n25 = nrow(subR4R8),
                    n34 = nrow(subR6R7),
                    n35 = nrow(subR6R8),
                    n45 = nrow(subR7R8),
                    n123 = nrow(subR2R4R6),
                    n124 = nrow(subR2R4R7),
                    n125 = nrow(subR2R4R8),
                    n134 = nrow(subR2R6R7),
                    n135 = nrow(subR2R6R8),
                    n145 = nrow(subR2R7R8),
                    n234 = nrow(subR4R6R7),
                    n235 = nrow(subR4R6R8),
                    n245 = nrow(subR4R7R8),
                    n345 = nrow(subR6R7R8),
                    n1234 = nrow(subR2R4R6R7),
                    n1235 = nrow(subR2R4R6R8),
                    n1245 = nrow(subR2R4R7R8),
                    n1345 = nrow(subR2R6R7R8),
                    n2345 = nrow(subR4R6R7R8),
                    n12345 = nrow(subR2R4R6R7R8),
                    category = c("R2", "R4", "R6", "R7", "R8"), 
                    fill = c("skyblue", "pink1", "mediumorchid", "green", "yellow")
)
#dev.off()

