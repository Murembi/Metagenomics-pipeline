import pandas as pd
from sklearn.preprocessing import LabelEncoder

metadata = pd.read_excel("Data/AfSM_metadata_v3.xlsx")
print(metadata.head())
# selecting the necessary data
metadata=metadata[["metagenome-id","Aridity_class_2000"]]

geneData = pd.read_csv("Data/combined.csv")
print(geneData.head())

# removal of the unnamed column
del geneData["Unnamed: 0"]
print(geneData.head())

# extracting metagemone-id from the fasta (sample ID)
geneData["metagenome-id"] = geneData["fasta"].str.split(".").str[0]

# double check the outcome
print(geneData[["metagenome-id", "fasta"]])

#merge the gene data and metadata using metagenome as id
data = pd.merge(geneData, metadata, on = "metagenome-id")

# Encode the ardity class column

le = LabelEncoder()
data["label"] = le.fit_transform(data["Aridity_class_2000"])

print(data.head())

## data preparation
x = data.drop(columns=["fasta", "metagenome-id", "Aridity_class_2000", "label"])
print(x.head())

y = data["label"]
print(y.head())

