install.packages('tidyverse') #install the package tidyverse
library(tidyverse)
install.package(readr)
library(readr)
#load the dataset from the PC
dram <- read_tsv("C:/Users/murem/annotations.tsv")
View(dram) #view the whole table
taxonomy <- read_tsv("C:/Users/murem/gtdbtk.bac120.summary.tsv") #install
View(taxonomy) #view the whole table
trehalose_kos <- c('K00697', 'K01087','K13057', 'K16055', 'K01236' )
heat_shock_proteins <- c('K04043', 'K04077', 'K03695', 'K04078' )
proline_synthesis <- c('K00147', 'K00931','K00286' )
ectione_kos <- c('K06720')
library(dplyr)
fileT <- read_csv("C:/Users/murem/Desktop/Project/trehalose_K00697_with_taxonomy.csv")

###############################################################################
                            example_for_otsA
###############################################################################
dram_trehalose <- dram %>%
  filter(kegg_id %in% trehalose_kos) ##creates a table with all the genes associated with trehalose synthesis
View(dram_trehalose)
trehalose_otsA <- dram %>% ## creates a table called trehalose_otsA which will filter all the sample
  # with a kegg is of K0067
  filter(kegg_id == "K00697")
trehalose_otsA_with_taxonomy <- otsA %>%
  left_join(taxonomy, by = c("fasta" = "user_genome"))
trehalose_otsA_Tax <- trehalose_otsA_with_taxonomy %>% select(-peptidase_hit, -peptidase_id, -peptidase_family,
                                                              -peptidase_RBH,
                                                              -peptidase_identity,
                                                              -peptidase_eVal,
                                                              -vogdb_description,
                                                              -vogdb_categories,
                                                              -heme_regulatory_motif_count,
                                                              -fastani_reference,
                                                              -fastani_reference_radius,
                                                              -fastani_taxonomy,
                                                              -fastani_ani,
                                                              -fastani_af)
###########################  trehalose genes ###########################################
# for loop for trehalose genes
for (x in trehalose_kos) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the columns, can later refine it after confirming  
      -...1,
      -scaffold,
      -strandedness,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af )
    
  filename <- paste0("trehalose_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
getwd()
######################## CREATING A MASTER TABLE ################################
library(dplyr)
library(readr)

setwd("C:/Users/murem/Desktop/project")

# List all trehalose CSV files
trehalose_files <- list.files(
  path = getwd(), 
  pattern = "trehalose_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(trehalose_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

trehalose_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(trehalose_master, "trehalose_master_table.csv", row.names = FALSE)

################################# HEAT SHOCK PROTEINS  ######################################
for (x in heat_shock_proteins) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -scaffold,
      -strandedness,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af )
  
  filename <- paste0("HSP_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
######################## CREATING A MASTER TABLE (HSP) ################################
library(dplyr)
library(readr)

setwd("C:/Users/murem/Desktop/project")

# List all trehalose CSV files
hsp_files <- list.files(
  path = getwd(), 
  pattern = "HSP_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(hsp_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

hsp_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(hsp_master, "hsp_master_table.csv", row.names = FALSE)

############################# solute proline synthase ##########################
for (x in proline_synthesis) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -peptidase_hit, 
      -peptidase_id,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af )
  
  filename <- paste0("proline_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
#master table

setwd("C:/Users/murem/Desktop/project")

# List all proline CSV files
proline_files <- list.files(
  path = getwd(), 
  pattern = "proline_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(hsp_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

proline_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(proline_master, "proline_master_table.csv", row.names = FALSE)

################################ ectione biosynthesis ################################################
# Define ectoine KEGG IDs
ectione_kos <- c("K06720")  # Add more IDs if needed

# Filter for ectoine biosynthesis genes
ectioneBiosynthesis <- dram %>%
  filter(kegg_id %in% ectione_kos)

# Join with taxonomy
Ectoine_K06720_with_taxonomy <- ectioneBiosynthesis %>%
  left_join(taxonomy, by = c("fasta" = "user_genome"))

# Remove unnecessary columns
Ectoine_K06720_with_taxonomy <- Ectoine_K06720_with_taxonomy %>%
  select(-scaffold,
         -strandedness,
         -peptidase_family,
         -peptidase_RBH,
         -peptidase_identity,
         -peptidase_eVal,
         -vogdb_description,
         -vogdb_categories,
         -heme_regulatory_motif_count,
         -fastani_reference,
         -fastani_reference_radius,
         -fastani_taxonomy,
         -fastani_ani,
         -fastani_af )

# Save result to CSV
write.csv(Ectoine_K06720_with_taxonomy,
          file = "Ectoine_K06720_with_taxonomy.csv",
          row.names = FALSE)
################################################################################
################## mannitol biosynthesis########################################
mannitol <- c("K00009" )
for (x in mannitol ) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -scaffold,
      -strandedness,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af)
  
  filename <- paste0("Mannitol_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
################################################################################
############################## glycine betaine##################################
glycine_betaine <- c("K00130", "K00108" )
for (x in glycine_betaine) 
  {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -scaffold,
      -strandedness,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af  )
  
  filename <- paste0("GlycineBetaine_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}

################3 GlycineBetaine Master table ##################################

setwd("C:/Users/murem/Desktop/project")

# List all proline CSV files
GlycineBetaine_files <- list.files(
  path = getwd(), 
  pattern = "GlycineBetaine_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(GlycineBetaine_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

GlycineBetaine_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(GlycineBetaine_master, "glycinebetaine_master_table.csv", row.names = FALSE)
################################################################################
###############################DNA repair genes#################################
dna_repair <- c("K03701", "K03702","K03553" )
for (x in dna_repair) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -scaffold,
      -strandedness,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af)
  
  filename <- paste0("DnaRepair_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
######################## DNA repair master table ##############################

# List all dna repair CSV files
DNARepair_files <- list.files(
  path = getwd(), 
  pattern = "DnaRepair_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(DNARepair_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

DNARepair_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(DNARepair_master, "DnaRepair_master_table.csv", row.names = FALSE)
########################### sucrose metabolism #################################
sucrose_kos <- c("K00696", "K00695")
for (x in sucrose_kos) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -peptidase_hit, 
      -peptidase_id,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af )
  filename <- paste0("sucrose_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
##################### sucrose master table ####################################
sucrose_files <- list.files(
  path = getwd(), 
  pattern = "Sucrose_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(sucrose_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

sucrose_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(sucrose_master, "sucrose_master_table.csv", row.names = FALSE)   #!!!!!!!!!!!!! get back
######################### Glutamate synthase ###############################################################
glutamate_kos <- c("K00265", "K00266", "K00262", "K00261" )
for (x in glutamate_kos) {
  
  ko_table <- dram %>%
    filter(kegg_id == x) %>%
    left_join(taxonomy, by = c("fasta" = "user_genome")) %>%
    select( #this removes all of the 
      -...1,
      -peptidase_hit, 
      -peptidase_id,
      -peptidase_family,
      -peptidase_RBH,
      -peptidase_identity,
      -peptidase_eVal,
      -vogdb_description,
      -vogdb_categories,
      -heme_regulatory_motif_count,
      -fastani_reference,
      -fastani_reference_radius,
      -fastani_taxonomy,
      -fastani_ani,
      -fastani_af,
      -scaffold)
  
  filename <- paste0("glutamate_", x, "_with_taxonomy.csv")
  write.csv(ko_table, filename, row.names = FALSE)
}
######################## Glutamate master table ################################
glutamate_files <- list.files(
  path = getwd(), 
  pattern = "glutamate_.*_with_taxonomy.csv", 
  full.names = TRUE
)
gene_tables <- lapply(glutamate_files, function(f) {
  df <- read.csv(f)
  df$fasta <- as.character(df$fasta)
  df$rank <- as.character(df$rank)
  df$kegg_id <- as.character(df$kegg_id)
  return(df)
})

glutamate_master <- bind_rows(gene_tables, .id = "gene_file")

#write.csv(dataframe, remname the dataframe, row.names=False)
write.csv(glutamate_master, "glutamate_master_table.csv", row.names = FALSE)
######################### LEA ###################################################
#################################################################################






