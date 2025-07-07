#A script used to bin the contigs into Metagenome assesmbled genomes using module module load das_tool-1.1
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
module load diamond-2.0.7
module load das_tool-1.1

BASE_DIR=/nlustre/users/muremb/project/mapping_results

for sample_dir in "$BASE_DIR"/*; do
  sample=$(basename "$sample_dir")
  
  maxbin_tsv="$sample_dir/${sample}_maxbins_output/maxbin.scaffolds2bin.tsv"
  metabat_tsv="$sample_dir/${sample}_metabat_bins/metabat.scaffolds2bin.tsv"
  contigs="$sample_dir/final.contigs.fa"
  outdir="$sample_dir/dastool_output"
  
  mkdir -p "$outdir"
  
  if [[ -f "$maxbin_tsv" && -f "$metabat_tsv" && -f "$contigs" ]]; then
    DAS_Tool \
      -i "$maxbin_tsv","$metabat_tsv" \
      -l maxbin,metabat \
      -c "$contigs" \
      -o "$outdir" \
      --search_engine diamond \
      --threads 24 \
      --write_bins 1
  fi
done

