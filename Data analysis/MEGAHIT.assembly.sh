#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=900:00:00
#PBS -q long
#PBS -o stdout.megahit
#PBS -e stderr.megahit
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd $PBS_O_WORKDIR

module load megahit

for x1 in ./*_1_qc.fastq.gz
do
echo "$x1"
x2="${x1/_1/_2}"

sample="${x1##*/}"
sample="${sample%_1_qc.fastq.gz}"

megahit -1 "$x1" -2 "$x2" -o "megahit_results_${sample}"
done
