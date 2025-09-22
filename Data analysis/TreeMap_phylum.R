library(treemapify)
library(ggplot2)
library(dplyr)

soft_palettes <- c(
  "#08306b", "#2171b5", "#6baed6", "#c6dbef",
  "#edf8fb", "#f7fcb9", "#fdae6b", "#e6550d",
  "#ff7f00", "#ffb347", "#ffcc99", "#ffe5cc"
)
phylum_summary <- Taxonomy_table2 %>%
  group_by(phylum) %>%
  summarise(count = n()) %>%
  mutate(percentage = round((count / sum(count)) * 100, 1))
png("treemap_phylum.png",
    width = 3000, height = 2000,  
    res = 300)                    
ggplot(phylum_summary, aes(
  area = count,
  fill = phylum,
  label = phylum
)) +
  geom_treemap(color = "white", size = 0.5) +
  geom_treemap_text(
    grow = FALSE,
    reflow = TRUE,
    size = 12 
  ) +
  scale_fill_manual(
    values = soft_palettes,
    labels = paste0(phylum_summary$phylum, " (", phylum_summary$percentage, "%)")
  ) +
  theme(
    legend.position = "right",
    legend.title = element_blank(),
    legend.text = element_text(size = 14)
  )
dev.off()
