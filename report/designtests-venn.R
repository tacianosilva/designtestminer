# install.packages('VennDiagram')
library(VennDiagram)
source("designtests-projects.R")

# Link: https://rstudio-pubs-static.s3.amazonaws.com/13301_6641d73cfac741a59c0a851feb99e98b.html

d <- rbind(sumario_random, sumario_star)

# Criando os subconjuntos de projetos que falharam em determinada regra.
subsetR1 <- subset(d, d$R1 > 0, select = project)
subsetR2 <- subset(d, d$R2 > 0, select = project)
subsetR3 <- subset(d, d$R3 > 0, select = project)
subsetR4 <- subset(d, d$R4 > 0, select = project)
subsetR5 <- subset(d, d$R5 > 0, select = project)
subsetR6 <- subset(d, d$R6 > 0, select = project)
subsetR7 <- subset(d, d$R7 > 0, select = project)
subsetR8 <- subset(d, d$R8 > 0, select = project)

subR2R4 <- subset(d, d$R2 > 0 & d$R4 > 0)
subR2R5 <- subset(d, d$R2 > 0 & d$R5 > 0)
subR2R6 <- subset(d, d$R2 > 0 & d$R6 > 0)
subR2R7 <- subset(d, d$R2 > 0 & d$R7 > 0)
subR2R8 <- subset(d, d$R2 > 0 & d$R8 > 0)

subR4R5 <- subset(d, d$R4 > 0 & d$R5 > 0)
subR4R6 <- subset(d, d$R4 > 0 & d$R6 > 0)
subR4R7 <- subset(d, d$R4 > 0 & d$R7 > 0)
subR4R8 <- subset(d, d$R4 > 0 & d$R8 > 0)

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
                   lty = "blank",
                   fill = c("skyblue", "pink1"))
#dev.off()

grid.newpage()
png("diagramaVennR7R8.png",width=800, height=600)
draw.pairwise.venn(area1 = nrow(subsetR7), 
                   area2 = nrow(subsetR8), 
                   cross.area = nrow(subR7R8),
                   category = c("R7", "R8"),
                   fill = c("skyblue", "pink1"))

dev.off()

grid.newpage()
png("diagramaVennR2R4R6.png",width=800, height=600)
draw.triple.venn(area1 = nrow(subsetR2), 
                 area2 = nrow(subsetR4), 
                 area3 = nrow(subsetR6), 
                 n12 = nrow(subR2R4), 
                 n23 = nrow(subR4R6), 
                 n13 = nrow(subR2R6), 
                 n123 = nrow(subR2R4R6), 
                 category = c("R2", "R4", "R6"), 
                 fill = c("skyblue", "pink1", "mediumorchid"))
dev.off()

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
png("diagramaVennR2R4R5R6.png",width=800, height=600)
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
dev.off()

grid.newpage()
png("diagramaVennR2R4R6R7R8.png",width=800, height=600)
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
dev.off()
