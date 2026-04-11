#!/bin/bash
# =====================================================================
# PBS Job Script for Running DRAM Genome Annotation
# Author: Murembiwa Mutswaletswale
# Project: Metagenome-Assembled Genome (MAG) Functional Annotation
# Tool: DRAM (Distilled and Refined Annotation of Metabolism)
# =====================================================================

# -------------------------------
# PBS Job Scheduler Directives
# -------------------------------

#PBS -l nodes=1:ppn=24           # Request 1 node with 24 processors
#PBS -l walltime=900:00:00       # Maximum runtime (900 hours here)
#PBS -q long                     # Use the 'long' job queue
#PBS -o stdout.DRAM.log          # Standard output log file
#PBS -e stderr.DRAM.log          # Standard error log file
#PBS -k oe                       # Keep stdout and stderr after job completion
#PBS -m abe                      # Send email on job (a)bort, (b)egin, and (e)nd
#PBS -M u25698372@tuks.co.za     # Email address for job notifications

# -------------------------------
# Environment Setup
# -------------------------------

# Load DRAM module (must be available on HPC)
module load DRAM

# Activate DRAM conda environment
source /apps/anaconda3-2020.02/etc/profile.d/conda.sh
conda activate DRAM

# -------------------------------
# DRAM Annotation Command
# -------------------------------

# DRAM.py annotate options:
#   -i        : input MAG files (FASTA format, can use wildcard *.fa)
#   -o        : output directory for DRAM annotation results
#   -e        : unique identifier for the annotation run (helps manage outputs)
#   --threads : number of CPU threads to use
DRAM.py annotate \
  -i '/nlustre/users/muremb/project/AfsmHighMedMags/*.fa' \
  -o /nlustre/users/muremb/project/annotate1.1 \
  -e 1.1 \
  --threads 12

# -------------------------------
# End of Script
# -------------------------------
