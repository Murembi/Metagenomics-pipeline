# MAG_coverage_plot.R
library(tidyverse)
library(ggplot2)

# Prepare coverm output
head(coverm_output)
colnames(coverm_output) <- coverm_output[1, ]
coverm_output <- coverm_output[-1, ]
colnames(coverm_output)[1] <- "Genome"
colnames(coverm_output)[-1] <- gsub("_1_qc.fastq.gz Relative Abundance \\(%\\)", "", colnames(coverm_output)[-1])
coverm_output[,-1] <- lapply(coverm_output[,-1], as.numeric)

coverage_long <- coverm_output %>%
  pivot_longer(-Genome, names_to = "Sample", values_to = "Abundance")

# Prepare metadata
colnames(AfSM_metadata_v3.xlsx...Sheet1) <- AfSM_metadata_v3.xlsx...Sheet1[1, ]
MetaData <- AfSM_metadata_v3.xlsx...Sheet1[-1, ]

coverage_meta <- coverage_long %>%
  left_join(MetaData, by = c("Sample" = "metagenome-id"))

coverage_plot_data <- coverage_meta %>%
  filter(Genome != "unmapped") %>%
  filter(!is.na(Aridity_class_2000))

# Define color palettes
soft_palettes <- c(
  "#08306b", "#2171b5", "#6baed6", "#c6dbef",
  "#edf8fb", "#f7fcb9", "#fdae6b", "#e6550d",
  "#ff7f00", "#ffb347", "#ffcc99", "#ffe5cc"
)

# Plot 100% relative abundance
ggplot(coverage_plot_data, aes(x = Aridity_class_2000, y = Abundance, fill = Genome)) +
  geom_bar(stat = "identity", position = "fill") +
  labs(x = "Aridity Class", y = "Relative Abundance (proportion)", fill = "MAG") +
  scale_fill_manual(values = soft_palettes) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
        axis.text.y = element_text(size = 11),
        axis.title = element_text(size = 11),
        legend.text = element_text(size = 11),
        legend.title = element_text(size = 11))

# Plot real abundance
ggplot(coverage_plot_data, aes(x = Aridity_class_2000, y = Abundance, fill = Genome)) +
  geom_bar(stat = "identity") +
  labs(x = "Aridity Class", y = "Relative Abundance (%)", fill = "MAG") +
  scale_fill_manual(values = soft_palettes) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 11),
        axis.text.y = element_text(size = 11),
        axis.title = element_text(size = 11),
        legend.text = element_text(size = 11),
        legend.title = element_text(size = 11))
