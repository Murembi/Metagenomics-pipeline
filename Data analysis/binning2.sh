#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00
#PBS -q normal
#PBS -o stdout.maxbin
#PBS -e stderr.maxbin
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd /nlustre/users/muremb/project/mapping_results/
module load maxbin-2.2.6

for sample_dir in JW*/
do
  sample=${sample_dir%/}

  cd "$sample"

  mkdir -p ${sample}_maxbins_output

  run_MaxBin.pl \
    -contig final.contigs.fa \
    -abund ${sample}_depth.txt \
    -out ${sample}_maxbins_output/${sample}
    -thread 24

  cd ..
done
