library(dplyr)
library(readr)
setwd("C:/Users/murem/Desktop/Project")
####read all the different master tables
trehalose_master <- read_csv("trehalose_master_table.csv")
hsp_master <- read_csv('hsp_master_table.csv')
proline_master <- read_csv("proline_master_table.csv")
glutamate_master <- read_csv("glutamate_master_table.csv")
GlycineBetaine_master <- read_csv("glycinebetaine_master_table.csv")
DNARepair_master <- read_csv("DnaRepair_master_table.csv")
Ectoine_K06720_with_taxonomy <- read_csv("Ectoine_K06720_with_taxonomy.csv")
sucrose_master <- read_csv("sucrose_master_table.csv")
mannitol_master <- read_csv("Mannitol_K00009_with_taxonomy.csv")

#merge all tables by fasta


# Merge all master tables by "fasta"
big_master <- trehalose_master %>%
  full_join(hsp_master, by = "fasta") %>%
  full_join(proline_master, by = "fasta") %>%
  full_join(glutamate_master, by = "fasta") %>%
  full_join(GlycineBetaine_master, by = "fasta") %>%
  full_join(DNARepair_master, by = "fasta") %>%
  full_join(Ectoine_K06720_with_taxonomy, by = "fasta") %>%
  full_join(sucrose_master, by = "fasta") %>%
  full_join(mannitol_master, by = "fasta")

big_master_distinct <- big_master %>%
  distinct(fasta, .keep_all = TRUE)
big_master_filtered <- big_master_filtered %>%
  mutate(across(starts_with("kegg_hit"), ~ ifelse(is.na(.), 0, 1)))

####download the big mastered table with just the genes etc
write.csv(big_master_filtered, 
          "C:/Users/murem/Desktop/Project/bigmaster_table.csv",  # full path where you want to save
          row.names = TRUE)
####create a heat map table 
####convert the content to binary
big_master_binary <- big_master_filtered %>%
  mutate(across(c(HeatShockProtein, Trehalose, proline, DNARepair, Glutamate, GlycineBetaine, sucrose, mannitol, Ectoine),
                ~ ifelse(is.na(.) | . == 0, 0, 1)))
###download the binary table
write.csv(big_master_binary, 
          "C:/Users/murem/Desktop/Project/bigmasterBinary.csv",  # full path where you want to save
          row.names = TRUE)



library(dplyr)
big_master_filtered <- big_master %>%
  select(fasta, starts_with("kegg_hit"))
big_master_filtered <- big_master_filtered%>%
  distinct(fasta, .keep_all = TRUE)

### renaming the columns
big_master_filtered <- big_master_filtered %>% rename(
  Trehalose = kegg_hit.x,
  HeatShockProtein = kegg_hit.y,
  proline = kegg_hit.x.x,
  Glutamate = kegg_hit.y.y,
  GlycineBetaine = kegg_hit.x.x.x,
  DNARepair = kegg_hit.y.y.y,
  Ectoine = kegg_hit.x.x.x.x,
  sucrose = kegg_hit.y.y.y.y,
  mannitol = kegg_hit
)

WhyDomain <- read.csv("")
"kegg_hit" %in% colnames(big_master)
which(colnames(big_master) == "kegg_hit.")
# Save merged table
write_csv(big_master, "big_master_table.csv")

library(dplyr)

gene_presence <- big_master %>%
  select(fasta, kegg_hit.x)

# View the first few rows
head(gene_presence)

###merge the why_domain master table with the table with all other genes big_master_binary
big_master_binary$why_domain <- ifelse(big_master_binary$fasta %in% why_domain$MAG, 1, 0)
###check the output file big_master_binary it has everything you need.

###creating a table for the lea genes
# Create LEA hits table
LEA <- data.frame(
  MAG = c(
    "JW138.metabat.7",
    "JW130.metabat.3"
  ),
  LEA_hit = 1,
  stringsAsFactors = FALSE
)

# View the table
print(LEA)
######################
library(dplyr)

# Assuming your dataframe is df with columns fasta and kegg_id

antioxidantMasters <- antioxidantMasters  %>%
  select(fasta, kegg_id) %>%
  filter(!is.na(kegg_id)) %>%  # remove missing KEGG IDs
  distinct() %>%                # remove duplicates
  mutate(presence = 1) %>%     # convert to 1
  select(fasta, presence)       # keep only fasta and presence column

# View result
head(antioxidantMasterBinary)



library(dplyr)

# Assume:
# master_table = your big master table with a "fasta" column
# new_hits = your table with columns "fasta" and "presence"

# Merge new_hits into master_table by fasta
bigMasterBinary <- big_master_binary %>%
  left_join(antioxidantMasters, by = "fasta") %>%
  mutate(antioxidant = ifelse(is.na(presence), 0, presence))
library(dplyr)
bigMasterBinary <- bigMasterBinary %>% select(-presence)
# View result
head(bigMasterBinary)
####update the fucntions table
Functions <- Functions %>% 
  select(genes, functions)

###### generate a heat map
install.packages("pheatmap")
install.packages("RColorBrewer")
#load the necessary packages
library(pheatmap)
library(RColorBrewer)
library(RColorBrewer)
