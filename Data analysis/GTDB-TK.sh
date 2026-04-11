#!/bin/bash
# =====================================================================
# PBS Job Script for Running GTDB-Tk Classification Workflow
# Author: Murembiwa Mutswaletswale
# Project: MAG Taxonomic Classification (GTDB-Tk v2.1.1)
# =====================================================================

# -------------------------------
# PBS Job Scheduler Directives
# -------------------------------

#PBS -l nodes=1:ppn=18          # Request 1 node with 18 processors
#PBS -l walltime=900:00:00      # Maximum runtime (900 hours here)
#PBS -q long                    # Use the 'long' job queue
#PBS -o stdout.gtdbtk.log       # Standard output log file
#PBS -e stderr.gtdbtk.log       # Standard error log file
#PBS -k oe                      # Keep both stdout and stderr after job completion
#PBS -m abe                     # Send email on job (a)bort, (b)egin, and (e)nd
#PBS -M u25698372@tuks.co.za    # Email address for job notifications

# -------------------------------
# Environment Setup
# -------------------------------

# Load GTDB-Tk module (v2.1.1 should be installed on the cluster)
module load gtdbtk-2.1.1

# Activate GTDB-Tk conda environment
source /apps/anaconda3-2023.03/etc/profile.d/conda.sh
source activate gtdbtk-2.1.1

# -------------------------------
# GTDB-Tk Classification Workflow
# -------------------------------

# gtdbtk classify_wf options:
#   --genome_dir : directory containing MAGs in FASTA format
#   --out_dir    : directory where GTDB-Tk results will be saved
#   --extension  : extension of genome files (e.g., .fa, .fna)
#   --cpus       : number of CPU threads to use
gtdbtk classify_wf \
  --genome_dir /nlustre/users/muremb/project/AfsmHighMedMags \
  --out_dir /nlustre/users/muremb/project/AnnotationOutPut2 \
  --extension fa \
  --cpus 4

# -------------------------------
# End of Script
# -------------------------------
