## run DRAM for identification of sulfur-related taxa


module load dram/20200625-conda
conda init bash
. ~/.bashrc
conda activate /bioware/dram-20200625-conda


now, use DRAM to annotate the bins of interest.

*needs the ``

DRAM.py annotate -i '/users/eperedo/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_50_10_bins/*.fa' -o /users/eperedo/Alabama_Spartina_Megahit/DRAM_annotation  --threads 12  --verbose



DRAM.py distill -i /users/eperedo/Alabama_Spartina_Megahit/DRAM_annotation/annotations.tsv -o /users/eperedo/Alabama_Spartina_Megahit/DRAM_distill --trna_path  /users/eperedo/Alabama_Spartina_Megahit/DRAM_annotation/trnas.tsv --rrna_path /users/eperedo/Alabama_Spartina_Megahit/DRAM_annotation/rrnas.tsv
