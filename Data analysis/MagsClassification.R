####Generating mags and phylum for bacteria
library(tidyverse)
gtdb_taxonomy <- gtdbtk.bac120.summary %>%
  separate(classification,
           into = c('Domain', 'phylum', 'class', 'order', 'family', 'genus', 'species'),
           sep = ";", fill = 'right') %>%
  mutate(across(everything(), ~str_replace(., "__", "")))
###create, filter these tables
##
taxonomy_table <- gtdb_taxonomy %>% 
  select(user_genome, Domain, phylum, class, order, family, genus, species)

## create and filter another table
mags_phylum_tax <- gtdb_taxonomy %>% 
  select(user_genome, phylum)
BacteriaMagsPhylumsorted <- mags_phylum_tax[order(mags_phylum_tax$phylum), ]

write.csv(BacteriaMagsPhylumsorted, "C:/Users/murem/Desktop/HonoursProject/BacteriaMagsPhylumsorted.csv")
write.csv(gtdbtk.bac120.summary, "C:/Users/murem/Desktop/HonoursProject/gtdbtk.bac120.summary.csv")
