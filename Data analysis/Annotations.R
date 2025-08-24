############################## Archea #####################################################
setwd("C:/Users/murem/Desktop/HonoursProject")
getwd()
archea_summary <- read_tsv("C:/Users/murem/Desktop/HonoursProject/gtdbtk.ar53.summary.tsv")
###########Divide the classifications
library(tidyverse)
###### only display the taxonomy of the species
ArcheaTaxClassification <- archea_summary %>%
  separate(classification,
           into = c('Domain', 'phylum', 'class', 'order', 'family', 'genus', 'species'),
           sep = ";", fill = 'right') %>%
  mutate(across(everything(), ~str_replace(., "__", "")))
ArcheaFullTax <- ArcheaTaxClassification %>% 
  select(user_genome, Domain, phylum, class, order, family, genus, species)

write.csv(ArcheaFullTax, "C:/Users/murem/Desktop/HonoursProject/ArcheaFullTax.csv")
####narrow the table to just showing the user_genome and phylum
ArcheaMagsPhylum <- ArcheaFullTax %>% 
  select(user_genome, phylum)

###sort the table using phylum
### final table you will intergrate with the bacteria results
ArcheaMagsPhylumsorted <- ArcheaMagsPhylum[order(ArcheaFullTax$phylum), ]
write.csv(ArcheaMagsPhylum, "C:/Users/murem/Desktop/HonoursProject/ArcheaMagsPhylum.csv")
#################################### Bacteria #############################################
####Generating mags and phylum for bacteria################################################
library(tidyverse)
gtdb_taxonomy <- write.csv("C:/Users/murem/Desktop/HonoursProject/gtdb_taxonomy.csv")
gtdbtk.bac120.summary <- write.csv("C:/Users/murem/Desktop/HonoursProject/gtdbtk.bac120.summary.csv")
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
BacteriaMagsPhylumsorted <- read.csv("C:/Users/murem/Desktop/HonoursProject/BacteriaMagsPhylumsorted.csv")
#######filter columns to only have usern genome and phylum
BacteriaMagsPhylumsorted <- BacteriaMagsPhylumsorted[, c("user_genome", "phylum")]

#merging the two tables together
ArcheaBacteriaMagsPhylum <- rbind(ArcheaMagsPhylum, BacteriaMagsPhylumsorted)
###### sort this table by phylum
ArcheaBacteriaMagsPhylum <- ArcheaBacteriaMagsPhylum %>%
  arrange(phylum)

write.csv(ArcheaBacteriaMagsPhylum, "C:/Users/murem/Desktop/HonoursProject/ArcheaBacteriaMagsPhylum.csv", row.names= FALSE)
#########


