#This PBS batch script runs MetaBAT2 for metagenomic binning on multiple samples (JW0*). For each sample, it:

Loads contigs and BAM files

Calculates contig depth

Runs MetaBAT2 to generate genome bins

Outputs are saved in a <sample>_metabat_bins directory. Uses 24 threads on the HPC cluster
#
#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=900:00:00 
#PBS -q long
#PBS -o stdout.metabat
#PBS -e stderr.metabat
#PBS -k oe  
#PBS -m abe  
#PBS -M u25698372@tuks.co.za
cd $PBS_O_WORKDIR  
module load metabat
for x in JW0*
do
contigs="$x/final.contigs.fa"
sorted_bam="$x/${x}_sorted.bam"
depth_file="$x/${x}_depth.txt"
output_dir="$x/${x}_metabat_bins"

mkdir -p "$output_dir"

jgi_summarize_bam_contig_depths --outputDepth "$depth_file" "$sorted_bam"

metabat2 -i "$contigs" -a "$depth_file" -o "$output_dir/bin" -t 24

done
