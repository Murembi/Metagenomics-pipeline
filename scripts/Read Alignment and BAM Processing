# Read Alignment and BAM Processing
This PBS script aligns quality-controlled paired-end reads to assembled contigs using BWA, then processes the alignments with SAMtools for multiple samples (JW0*).

Steps for Each Sample:
Align reads to contigs using bwa mem

Convert SAM to BAM with samtools view

Sort the BAM file with samtools sort

Index the sorted BAM file with samtools index

Uses 24 threads per step. Output includes sorted and indexed BAM files for each sample.
#

#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=900:00:00 
#PBS -q long
#PBS -o stdout  
#PBS -e stderr
#PBS -k oe  
#PBS -m abe  
#PBS -M u25698372@tuks.co.za
cd $PBS_O_WORKDIR  
    module load bwa-0.7.17
    module load samtools-1.7

for x in JW0*
do
    contigs="$x/final.contigs.fa"
    r1="$x/${x}_1_qc.fastq.gz"
    r2="$x/${x}_2_qc.fastq.gz"
    sam_out="$x/${x}.sam"
    bam_out="$x/${x}.bam"
    sorted_bam="$x/${x}_sorted.bam"

    bwa mem -t 24 "$contigs" "$r1" "$r2" > "$sam_out"  ## Align reads to contigs

        samtools view -bS -@ 24 "$sam_out" > "$bam_out" #Convert SAM to BAM

            samtools sort -@ 24 "$bam_out" -o "$sorted_bam" #Sort BAM file

                samtools index "$sorted_bam" #Index sorted BAM

done
