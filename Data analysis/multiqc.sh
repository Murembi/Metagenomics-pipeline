#This PBS script runs MultiQC to generate a consolidated quality control report. It:
#Loads the MultiQC module
#Scans the /nlustre/users/muremb/project/xaa directory for QC output files
#Produces a single HTML report summarizing all results
#Optimized for HPC environments using 24 threads.

#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00
#PBS -q normal
#PBS -o stdout.multiqc
#PBS -e stderr.multiqc
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd $PBS_O_WORKDIR

module load multiqc

multiqc /nlustre/users/muremb/project/xaa
