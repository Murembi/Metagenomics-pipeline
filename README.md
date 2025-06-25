# Metagenomics_pipeline_bioinformatics
This repository contains PBS job scripts developed for my honours research project focused on metagenomic data analysis. The scripts automate essential steps in processing shotgun sequencing data, including:
Quality control of raw sequencing reads using fastp and FastQC
Organizing sequencing data and assembly results for streamlined analysis
Aligning reads to assembled contigs with BWA and managing alignments with SAMtools
Metagenomic binning of genomes using MetaBAT2
Assessing assembly quality with QUAST
Summarizing multiple quality control reports via MultiQC
All scripts are designed to run efficiently on an HPC cluster with PBS job scheduling, enabling reproducible and scalable data processing. This pipeline supports the project’s goal to characterize microbial communities through metagenomics.
