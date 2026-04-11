#!/bin/bash
# =====================================================================
# PBS Job Script for Running CoverM Genome Coverage Analysis
# Author: Murembiwa Mutswaletswale
# Project: Metagenomic Binning Coverage Analysis
# =====================================================================

# -------------------------------
# PBS Job Scheduler Directives
# -------------------------------

#PBS -l nodes=1:ppn=24          # Request 1 node with 24 processors
#PBS -l walltime=900:00:00      # Maximum walltime allowed (900 hours here)
#PBS -q long                    # Submit job to the 'long' queue
#PBS -o stdout.coverm.log       # Standard output file
#PBS -e stderr.coverm.log       # Standard error file
#PBS -k oe                      # Keep output and error files after job ends
#PBS -m abe                     # Send email on (a)bort, (b)egin, and (e)nd
#PBS -M u25698372@tuks.co.za    # Email address for job notifications

# -------------------------------
# Job Execution Section
# -------------------------------

# Change to the directory where the job was submitted from
cd $PBS_O_WORKDIR

# Load the CoverM module (must be available on the HPC system)
module load coverm

# Run CoverM genome coverage calculation
#   --genome-fasta-directory : directory containing all genome bins (FASTA files)
#   --read1 / --read2        : paired-end QC reads (fastq.gz) after quality control
#   --output-file            : path to the output file (coverage matrix)
#   --threads                : number of CPU threads to use (match ppn above)
coverm genome \
  --genome-fasta-directory /nlustre/users/muremb/project/all_bins/all_bins_flat2 \
  --read1 /nlustre/users/muremb/project/QCReads/*_1_qc.fastq.gz \
  --read2 /nlustre/users/muremb/project/QCReads/*_2_qc.fastq.gz \
  --output-file /nlustre/users/muremb/project/coverm_output.tsv \
  --threads 24

# -------------------------------
# End of Script
# -------------------------------
