#This script organizes paired-end quality-controlled FASTQ files and their corresponding MEGAHIT assembly outputs. For each sample (JW*_1_qc.fastq.gz), it:

Extracts the sample name

Creates a new directory named after the sample

Moves the R1 and R2 FASTQ files and the final.contigs.fa file from the MEGAHIT results into the sample folder
#
#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00  
#PBS -q normal 
#PBS -o stdout  
#PBS -e stderr
#PBS -k oe  
#PBS -m abe  
#PBS -M u25698372@tuks.co.za
cd $PBS_O_WORKDIR  
for x in JW*_1_qc.fastq.gz
do
name=${x%_1_qc.fastq.gz}
mkdir -p "$name"
mv "${name}_1_qc.fastq.gz" "${name}/"
mv "${name}_2_qc.fastq.gz" "${name}/"
mv "megahit_results_${name}/final.contigs.fa" "${name}/" 
done
