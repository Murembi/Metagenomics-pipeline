#The script runs QUAST on all bin files for each sample and saves the output inside a quast_results folder within each bin directory.

#Usage
#Make sure you have QUAST installed and accessible (quast.py command).

#Place the script in the parent directory containing the sample folders (mapping_results/). #

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
for x in JW0*
 do
    mkdir -p "$x/${x}_metabat_bins/quast_results"
    quast.py -o "$x/${x}_metabat_bins/quast_results" $x/${x}_metabat_bins/bin.*.fa -t 24
done
