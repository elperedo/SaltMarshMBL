## run DRAM for identification of sulfur-related taxa

```
module load dram/20200625-conda
conda init bash
. ~/.bashrc
conda activate /bioware/dram-20200625-conda
```

now, use DRAM to annotate the bins of interest.

*needs the ``
```
DRAM.py annotate -i '*.fa' -o ./DRAM_annotation  --threads 25  --verbose
```

```
DRAM.py distill -i ./DRAM_annotation/annotations.tsv -o ./DRAM_distill --trna_path  ./DRAM_annotation/trnas.tsv --rrna_path ./DRAM_annotation/rrnas.tsv
```
