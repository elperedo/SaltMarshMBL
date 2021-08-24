
# Assembly and assembly QC
---

Megahit is efficient enough to deal with this amount of reads

# megahit

1. megahit can run with series of files, not need for concatenated files (again, save space ~400Gb). list files separated by `,` and no spaces.
2. `--k-list 79,99,119,141` . with this flag we dont run small size kmers (should be faster)
3. `--min-contig-len 3000` only contigs over 3k.


module load megahit
megahit -1 ~/reads_spartina/SRR10854653_good_1.fastq,~/reads_spartina/SRR11567157_good_1.fastq,~/reads_spartina/SRR9045292_good_1.fastq,~/reads_spartina/SRR9045293_good_1.fastq,~/reads_spartina/SRR9045296_good_1.fastq,~/reads_spartina/SRR9045298_good_1.fastq  -2 ~/reads_spartina/SRR10854653_good_2.fastq,~/reads_spartina/SRR11567157_good_2.fastq,~/reads_spartina/SRR9045292_good_2.fastq,~/reads_spartina/SRR9045293_good_2.fastq,~/reads_spartina/SRR9045296_good_2.fastq,~/reads_spartina/SRR9045298_good_2.fastq --k-list 79,99,119,141 -o MEGAHIT_79_141 -t 14 --min-contig-len 3000



View the longest 3 contig information

grep ">" ASSEMBLY/final_assembly.fasta | head -n3


# MetaQUAST
http://quast.sourceforge.net/metaquast

https://github.com/bxlab/metaWRAP/blob/master/Usage_tutorial.md#step-2-assembling-the-metagenomes-with-the-metawrap-assembly-module

metaquast.py ~/Alabama_Spartina_Megahit/MEGAHIT_79_141/*.fa -o metaQUAST --max-ref-number 0
