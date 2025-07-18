#This PBS batch script runs QUAST to evaluate the quality of metagenomic assemblies produced by MEGAHIT. For each sample directory in megahit_results_*, it:

#Extracts the sample name

#Locates the final.contigs.fa file

#Runs quast.py if the contigs file exists

#Saves the output in a quast_<sample_name> folder

#Designed for HPC environments using 24 threads.

#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00
#PBS -q normal
#PBS -o stdout.quast.py
#PBS -e stderr.quast.py
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd $PBS_O_WORKDIR
module load quast-5.0.2

for x in /nlustre/users/muremb/project/megahit/megahit_results_*/
do
sample_name=$(basename "$x")
x1="$x/final.contigs.fa"
x2="quast_${sample_name}"
if [ -f "$x1" ]
then
quast.py "$x1" -o "$x2"
fi
done
