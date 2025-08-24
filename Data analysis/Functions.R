####creating a functiona annotation table with all of the genes
# Create a simple table
FunctionAnnotation <- data.frame(
  genes = c(
    "TPS", 
    "TPP", 
    "TreS", 
    "HSP70", "HSP60", "ClpB", "HSP23", "GroES",
    "ectoine synthase",
    "proA", "proB", "proC",
    "recA", "uvrA", "uvrB", "uvrC",
    "MtlD",
    "WHy domain",
    "katE", "katG", "SOD1", "ahpC",
    "LEA"
  ),
  cycle = c(
    "trehalose synthesis", "trehalose synthesis", "trehalose synthesis",
    "Heat shock response", "Heat shock response", "Heat shock response", "Heat shock response", "Heat shock response",
    "ectoine biosynthesis",
    "Proline biosynthesis", "Proline biosynthesis", "Proline biosynthesis",
    "DNA repair", "Nucleotide excision repair", "Nucleotide excision repair", "Nucleotide excision repair",
    "Mannitol biosynthesis",
    "stress tolerance",
    "Catalase (breaks down H₂O₂)", "Catalase–peroxidase (breaks down H₂O₂ and peroxides)", "Cu–Zn superoxide dismutase (handles superoxide radicals)", "Peroxiredoxin (reduces peroxides; antioxidant role)",
    "stabilizing proteins and membranes"
  )
)
write.csv(FunctionAnnotation, 
          "C:/Users/murem/Desktop/HonoursProject/FunctionAnnotation.csv", 
          row.names = FALSE)
# View the table
print(FunctionAnnotation)

####################fucntion table #############################################
FunctionAnnotation <- data.frame(
  genes = c(
    "TPS", "TPP", "TreS", 
    "HSP70", "HSP60", "ClpB", "HSP23", "GroES",
    "ectoine synthase",
    "proA", "proB", "proC",
    "recA", "uvrA", "uvrB", "uvrC",
    "MtlD",
    "WHy domain",
    "katE", "katG", "SOD1", "ahpC",
    "LEA"
  ),
  functions = c(
    "Synthesizes trehalose-6-phosphate",
    "Converts trehalose-6-phosphate to trehalose",
    "Converts maltose to trehalose",
    "Chaperone that helps proteins fold correctly under heat or stress",
    "Assists folding of stress-denatured proteins",
    "Disaggregates misfolded proteins and helps refolding",
    "stabilizes proteins and membranes under stress",
    "Co-chaperonin that assists GroEL in protein folding",
    "Catalyzes ectoine biosynthesis",
    "Catalyzes step in proline biosynthesis",
    "Catalyzes step in proline biosynthesis",
    "Final step in proline biosynthesis",
    "Central protein in homologous recombination and DNA repair",
    "Recognizes DNA damage in nucleotide excision repair",
    "excision of damaged DNA in nucleotide excision repair",
    "removes damaged DNA during nucleotide excision repair",
    "Mannitol biosynthesis, acting as an osmoprotectant",
    "stabilizes proteins and membranes",
    "Breaks down hydrogen peroxide, reducing oxidative stress",
    "Detoxifies hydrogen peroxide",
    "Converts superoxide radicals into less harmful molecules",
    "Reduces peroxides and protects against oxidative stress",
    "stabilizes proteins and membranes under desiccation and stress"
  )
)

write.csv(FunctionAnnotation, 
          "C:/Users/murem/Desktop/HonoursProject/FunctionAnnotation.csv")
