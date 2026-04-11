install.packages("pheatmap")
library(pheatmap)

library(pheatmap)
library(RColorBrewer)
FunctionAnnotation$X <- NULL
setwd("C:/Users/murem/Desktop/HonoursProject")
Taxonomy_table <- read.csv("C:/Users/murem/Desktop/HonoursProject/Taxonomy_table2.csv", header= TRUE, sep =",")
Taxonomy_table <- Taxonomy_table[, -1]
rownames(Taxonomy_table) <- Taxonomy_table$fasta
Taxonomy_table$fasta <- NULL
Heat_map <- read.csv("C:/Users/murem/Desktop/HonoursProject/combined.csv", header= TRUE, sep =",")
Heat_map <- Heat_map[, -1]
Heat_map$WHy_Domain <- ifelse(Heat_map$LEA2 == 1 | Heat_map$WHy_domain == 1, 1, 0)  
Heat_map <- Heat_map[, !(names(Heat_map) %in% c("LEA2", "WHy_domain"))] 
rownames(Heat_map) <- Heat_map$fasta
Heat_map<- Heat_map[, -c(1)]

Heat_map_matrix <- as.matrix(Heat_map) 
library(RColorBrewer)
my_colors <- colorRampPalette(brewer.pal(9, "Blues"))(100)
Heat_map_matrix_t <- t(Heat_map_matrix)
heatmap_colors <- colorRampPalette(c("#91cdf8", "#5292ef"))(100)

annotation_col <- Taxonomy_table
pheatmap(
  Heat_map_matrix_t,
  color = heatmap_colors,
  cluster_rows = FALSE,
  cluster_cols = FALSE,
  annotation_col = annotation_col,
  show_rownames = TRUE,
  show_colnames = FALSE,
  cellwidth = 4,  
  cellheight = 12,
  border_color = 'white'
)
