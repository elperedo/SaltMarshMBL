
# yellow guy.Assembly

download sequences
```curl https://sequencing.mbl.edu/ZC_EP_20230821.tar.gz -o ZC_EP_20230821.tar.gz```

copy to /users/eperedo/methanogens/illumina

unzip

``` tar -zxvf  ZC_EP_20230821.tar.gz ```

quality

```
module load java
module load fastqc
fastqc *
```

```
module purge
module load bioware

module load fastqc
module load trimmomatic

trimmomatic  PE -phred33 -threads 18  Bacterial_S21_R1_001.fastq Bacterial_S21_R2_001.fastq Yellow_paired_R1.fastq Yellow_unpaired_R1.fastq Yellow_paired_R2.fastq Yellow_unpaired_R2.fastq ILLUMINACLIP:/groups/spart2020/adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```
```
megahit -1 /users/eperedo/YellowGuy/reads/Yellow_paired_R1.fastq -2 /users/eperedo/YellowGuy/reads/Yellow_paired_R2.fastq -o MEGAHIT_Assembly -t 20 --min-contig-len 1000
```
```
module load metaquast
metaquast.py *fa -o metaQUAST --max-ref-number 0
```
```
module purge
module load jbpc
module load metawrap/1.3

metawrap binning -o INITIAL_BINNING -t 16 -m 10 -a /users/eperedo/YellowGuy/MEGAHIT_Assembly/final.contigs.fa --metabat2 --maxbin2 --concoct /users/eperedo/YellowGuy/reads/Yellow_paired_1.fastq /users/eperedo/YellowGuy/reads/Yellow_paired_2.fastq --run-checkm

metawrap bin_refinement -o /users/eperedo/YellowGuy/reads/BIN_REFINEMENT/ -t 20 -A /users/eperedo/YellowGuy/reads/INITIAL_BINNING/metabat2_bins/  -B /users/eperedo/YellowGuy/reads/INITIAL_BINNING/maxbin2_bins/ /users/eperedo/YellowGuy/reads/INITIAL_BINNING/concoct_bins -c 50 -x 10

```

```
metawrap reassemble_bins -o /users/eperedo/YellowGuy/BIN_REASSEMBLY2 -1 /users/eperedo/YellowGuy/reads/Yellow_paired_1.fastq -2 /users/eperedo/YellowGuy/reads/Yellow_paired_2.fastq -t 16 -m 800 -c 50 -x 10 -b /users/eperedo/YellowGuy/BIN_REFINEMENT/metawrap_50_10_bins
```

```
module load dram/20200625-conda
conda init bash
. ~/.bashrc
conda activate /bioware/dram-20200625-conda
DRAM.py annotate -i '*.fa' -o ./DRAM_annotation  --threads 25  --verbose

DRAM.py distill -i ./DRAM_annotation/annotations.tsv -o ./DRAM_distill --trna_path  ./DRAM_annotation/trnas.tsv --rrna_path ./DRAM_annotation/rrnas.tsv

```

```
module load gtdbtk
gtdbtk classify_wf --genome_dir /bin1/  --out_dir /classify_wf --cpus 16 -x fa --mash_db MASH_DB
```

