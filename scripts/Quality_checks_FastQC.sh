#This PBS script runs FastQC to perform quality control on all FASTQ files in the xaa/ directory. It:

#Loads the FastQC module

#Processes all .fastq.gz files in xaa/

#Generates quality reports for each file

#Designed for HPC use with 24 CPU cores.
#
#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=30:00:00
#PBS -q normal
#PBS -o stdout.fastqc
#PBS -e stderr.fastqc
#PBS -k oe
#PBS -m abe
#PBS -M u25698372@tuks.co.za

cd $PBS_O_WORKDIR

module load fastqc-0.11.7

fastqc xaa/*.fastq.gz
