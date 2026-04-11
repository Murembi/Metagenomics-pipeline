#!/bin/bash
#PBS -l nodes=1:ppn=18
#PBS -l walltime=900:00:00
#PBS -q long
#PBS -o stdout.gtdbtk
#PBS -e stderr.gtdbtk
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

module load gtdbtk-2.1.1
source /apps/anaconda3-2023.03/etc/profile.d/conda.sh
source activate gtdbtk-2.1.1

gtdbtk classify_wf \
 --genome_dir /nlustre/users/muremb/project/AfsmHighMedMags \
 --out_dir /nlustre/users/muremb/project/AnnotationOutPut2 \
 --extension fa \
 --cpus 4

