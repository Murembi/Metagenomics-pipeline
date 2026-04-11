library(dplyr)
library(tidyr)
library(tibble)

phylum_colors <- c(
  "#08306b",  
  "#2171b5", 
  "#6baed6", 
  "#c6dbef", 
  "#cab2d6", 
  "#fdae6b", 
  "#e6550d", 
  "#ff7f00",  
  "#ffb347",  
  "#f7fcb9", 
  "#a6cee3", 
  "#b2df8a"  
)

otu_long <- otu_table %>%
  as.data.frame() %>%
  rownames_to_column(var = "MAG") %>%
  pivot_longer(
    cols = -MAG,
    names_to = "metagenome.id",
    values_to = "abundance"
  )

otu_long$metagenome.id <- as.character(otu_long$metagenome.id)
metadata$metagenome.id <- as.character(metadata$metagenome.id)

otu_meta <- otu_long %>%
  left_join(metadata %>% select(metagenome.id, Aridity_class_2000), 
            by = "metagenome.id") %>%
  left_join(Taxonomy_table2 %>% select(fasta, phylum),
            by = c("MAG" = "fasta"))
phylum_aridity <- otu_meta %>%
  group_by(Aridity_class_2000, phylum) %>%
  summarise(total_abundance = sum(abundance, na.rm = TRUE)) %>%
  group_by(Aridity_class_2000) %>%
  mutate(relative_abundance = (total_abundance / sum(total_abundance)) * 100)
library(ggplot2)

ggplot(phylum_aridity, aes(x = Aridity_class_2000, y = relative_abundance, fill = phylum)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = phylum_colors) + 
  theme_minimal() +
  labs(
    title = "Relative Abundance of Phyla Across Aridity Classes",
    x = "Aridity Class",
    y = "Relative Abundance (%)",
    fill = "Phylum"
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(hjust = 0.5)
  )
