####creating a functiona annotation table with all of the genes
# Create a simple table
FunctionAnnotation <- data.frame(
  genes = c(
    "Trehalose 6-phosphate synthase (TPS)", 
    "Trehalose 6-phosphate phosphatase (TPP)", 
    "Trehalose synthase (TreS)", 
    "HSP70", "HSP60", "ClpB", "HSP23", "GroES",
    "ectoine synthase",
    "proA", "proB", "proC",
    "recA", "uvrA", "uvrB", "uvrC",
    "mannitol-1-phosphate 5-dehydrogenase"
  ),
  cycle = c(
    "trehalose synthesis", "trehalose synthesis", "trehalose synthesis",
    "Heat shock response", "Heat shock response", "Heat shock response", "Heat shock response", "Heat shock response",
    "ectoine biosynthesis",
    "Proline biosynthesis", "Proline biosynthesis", "Proline biosynthesis",
    "DNA repair", "Nucleotide excision repair", "Nucleotide excision repair", "Nucleotide excision repair",
    "Mannitol biosynthesis"
  )
)

# View the table
print(FunctionAnnotation)
