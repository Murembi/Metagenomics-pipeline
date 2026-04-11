library(ggplot2)
library(vegan)
library(phyloseq)


setwd('C:/Users/murem/Desktop/HonoursProject')
getwd()
taxa <- read.csv("C:/Users/murem/Desktop/HonoursProject/Taxonomy_table2.csv")
metadata <- read.csv("C:/Users/murem/Downloads/AfSM_metadata_v3.xlsx - Sheet1.csv")
otu_table <- read.delim("C:/Users/murem/coverm_output.tsv", header = TRUE)
#row the unmaped row
otu_table <- otu_table[-1, ]
taxa <- taxa[,-1]
###merge the  reads
colnames(otu_table)[-1] <- gsub("_R[12]_.*|_1_qc\\.fastq\\.gz.*", "", colnames(otu_table)[-1])

###set the genomes into rows
# Set MAGs as rownames
rownames(otu_table) <- otu_table$Genome
otu_table$Genome <- NULL

rownames(taxa) <- taxa$fasta
taxa$fasta <- NULL

physeq_OTU = otu_table((otu_table), taxa_are_rows = T)
physeq_Tax = tax_table(as.matrix(taxa))
physeq_metadata = sample_data(metadata)
rownames(physeq_metadata) <- physeq_metadata$metagenome.id
physeq= phyloseq(physeq_OTU,  physeq_Tax, physeq_metadata)

soft_palettes <- c(
  "#fce883",
  "#08306b",
  "#2171b5", 
  "#6baed6", 
  "#ff7f00"   
)
erie_PCoA_ordination <- ordinate(physeq = physeq_RA, 
                                 method = "PCoA", 
                                 distance = erie_PCoA_bact)
percent_var <- round(erie_PCoA_ordination$values$Relative_eig * 100, 1)
xlab <- paste0("PCoA1 (", percent_var[1], "%)")
ylab <- paste0("PCoA2 (", percent_var[2], "%)")

PcoA2 <- plot_ordination(physeq = physeq_RA, 
                         ordination = erie_PCoA_ordination, 
                         color = "Aridity_class_2000", 
                         axes = 1:2) +
  geom_point(size = 3) +
  stat_ellipse(geom = "polygon", 
               aes(fill = Aridity_class_2000), 
               alpha = 0.25) +
  scale_color_manual(values = soft_palettes) +
  scale_fill_manual(values = soft_palettes) +
  xlab(xlab) +
  ylab(ylab) +
  theme_bw() +
  theme(text = element_text(size = 20))
PcoA2

###############################################################################
library(ggplot2)
library(phyloseq)

ordination_scores <- as.data.frame(erie_PCoA_ordination$vectors[,1:2])
ordination_scores$SampleID <- rownames(ordination_scores)

ordination_scores$Aridity <- sampledf_bact$Aridity_class_2000

######################Boxplot################################################
ggplot(ordination_scores, aes(x = Aridity, y = Axis.1, fill = Aridity)) +
  geom_boxplot(outlier.shape = 21, colour = "black") +
  scale_fill_manual(values = soft_palettes) + 
  theme_bw() +
  labs(
    x = "Aridity Class",
    y = "PCoA1 (Beta Diversity)",
    title = "Beta Diversity across Aridity Classes"
  ) +
  theme(
    text = element_text(size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )



physeq= phyloseq(physeq_OTU,  physeq_Tax, physeq_metadata)
