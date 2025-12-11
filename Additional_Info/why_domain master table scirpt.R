library(dplyr)
library(tidyr)
setwd ("C:/Users/murem")
why_hits <- read.delim("why_hits_filtered.tsv", header = FALSE)
head(why_hits)
colnames(why_hits)[1:2] <- c("MAG", "GeneID")

why_hits$GeneID <- sub("^tr\\|","", why_hits$GeneID)
why_hits$GeneID <- sub("\\|.*","", why_hits$GeneID)

jw_hits <- why_hits %>%
  filter(grepl("^JW0*.maxbin.**", MAG)) %>%                # keep only JW0 MAGs
  mutate(MAG = sub("\\..*|_.*", "", MAG))
head(jw_hits)

why_master_table <- jw_hits %>%
  mutate(presence = 1) %>%
  pivot_wider(names_from = GeneID,
              values_from = presence,
              values_fill = 0
              )

