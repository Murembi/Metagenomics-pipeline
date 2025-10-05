library(tidyverse)
head(CoverM_ouptut)
colnames(CoverM_ouptut) <- CoverM_ouptut[1, ]

coverm <- coverm[-1, ] 
coverm <- coverm[, -1] 
colnames(coverm_output)[-1] <- gsub("_1_qc.fastq.gz Relative Abundance \\(%\\)", "", colnames(coverm_output)[-1])

coverm_long <- coverm%>%
  pivot_longer(
    cols = -Genome,     
    names_to = "Sample",  
    values_to = "Count" )
coverm_long$Count <- as.numeric(coverm_long$Count)
library(tidyverse)
colnames(AfSM_metadata_v3.xlsx...Sheet1) <- AfSM_metadata_v3.xlsx...Sheet1[1, ]
MetaData<- AfSM_metadata_v3.xlsx...Sheet1[-1, ]
library(tidyverse)
coverage_meta <- coverm_long%>%
  left_join(MetaData, by = c("Sample" = "metagenome-id"))
coverage_plot_data <- coverage_meta %>%
  filter(Genome != "unmapped") %>%
  filter(!is.na(Aridity_class_2000))
soft_palettes <- c(
  "#08306b", "#2171b5", "#6baed6", "#c6dbef", 
  "#edf8fb", "#f7fcb9", "#fdae6b", "#e6550d",  
  "#ff7f00", "#ffb347", "#ffcc99", "#ffe5cc"
)
abundance_per_aridity <- coverage_plot_data %>%
  filter(!is.na(Aridity_class_2000)) %>%
  group_by(Aridity_class_2000, Genome, Phylum) %>%
  summarise(Total_Abundance = sum(Abundance, na.rm = TRUE)) %>%
  ungroup()
abundance_per_aridity <- abundance_per_aridity %>%
  mutate(MAG_Phylum = paste(Genome, "(", Phylum, ")", sep = ""))
library(ggplot2)

ggplot(abundance_per_aridity, aes(x = factor(Aridity_class_2000,
                                             levels = c("Hyper_arid", "Arid", "Semi_arid", "Dry_sub_humid", "Humid")),
                                  y = Total_Abundance,
                                  fill = MAG_Phylum)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = soft_palettes) +
  theme_minimal() +
  labs(x = "Aridity Class", y = "Total Abundance (counts)",
       title = "MAG Abundance and phylum per Aridity Class") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
