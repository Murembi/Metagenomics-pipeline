=====================================================================================================================================
# CheckM2 Batch Quality Assessment PBS Job Script

This Bash script automates running **CheckM2** on multiple metagenome-assembled genome (MAG) bins stored in separate sample directories. 
It is designed to be submitted as a PBS job on an HPC cluster.

## Features

- Iterates through sample folders named with pattern `JW*` (e.g., JW001, JW002, ..., JW062).
- For each sample, runs CheckM2’s quality prediction on bins stored in the `${sample}/${sample}_metabat_bins` directory.
- Outputs CheckM2 results in `${sample}/checkm2_results`.
- Skips samples where the bins directory does not exist.
- Loads necessary modules and activates the conda environment `checkm2`.
- Includes PBS directives to request resources: 1 node, 24 processors per node, 30 hours walltime.
- Saves standard output and error logs to files.

## Usage

- Place this script in your working directory.
- Modify PBS directives as needed for your cluster environment.
- Submit with:
===============================================================================================================================================



#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00
#PBS -q normal
#PBS -o stdout.checkm2
#PBS -e stderr.checkm2
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd /nlustre/users/muremb/project/mapping_results/
module load checkm2
source /apps/anaconda3-2023.03/etc/profile.d/conda.sh
conda activate checkm2
for x in JW*
do
bin_folder="${x}/${x}_metabat_bins"
output_folder="${x}/checkm2_results"

if [ -d "$bin_folder" ]
then
checkm2 predict \
            --input "$bin_folder" \
            --output-directory "$output_folder" \
            -x fa
fi
done
