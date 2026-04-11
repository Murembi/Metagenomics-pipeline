#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=900:00:00
#PBS -q long
#PBS -o stdout.DRAM.py
#PBS -e stderr.DRAM.py
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

module load DRAM
source /apps/anaconda3-2020.02/etc/profile.d/conda.sh
conda activate DRAM


DRAM.py annotate -i '/nlustre/users/muremb/project/AfsmHighMedMags/*.fa' -o /nlustre/users/muremb/project/annotate1.1 --threads 12  
