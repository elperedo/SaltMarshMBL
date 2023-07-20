

 
### dsrA

grep -e K11180 genes.gff >K11180.txt

## in excel extract the gene names. 

grep -A 1 -wFf gene_names_k11180.txt genes.fna >k11180_NT.fasta

grep  -A 1 -wFf gene_names_k11180.txt genes.faa > k11180_AA.fasta

### dsrB

grep -e K11181 genes.gff >K11181.txt

## in excel extract the gene names. 

grep -A 1 -wFf gene_names_K11181.txt genes.fna >K11181_NT.fasta

grep  -A 1 -wFf  gene_names_K11181.txt genes.faa > K11181_AA.fasta


### Align
clustalo-1.2.3-Ubuntu-x86_64 -i input.fasta -o clustal.aln -v --outfmt=clustal --output-order=tree-order --iter=0 --cluster-size=100 -t DNA


### Run ML tree
raxmlHPC-SSE3-64 -s input.phy -n output -m GTRGAMMA -f a -x 1 -N 1000 -p 1
