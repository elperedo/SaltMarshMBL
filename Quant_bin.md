## Calculate the occurence of draft metagenomes genomes (bins) across the samples
```
metawrap quant_bins -b ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_70_sulfur  -o ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/QUANT_BINS_sulfur_70/ -t 12 -a ~/Alabama_Spartina_Megahit/MEGAHIT_79_141/Spartina.final.contigs.fa  ~/reads_spartina/*.fastq
```
## Extract the data of each contig of each bin for ploting.

files.
list of bins per assembly XX.bin.list.txt
list of samples. srr.files.txt

### 1. extract ID of each contig of each bin.
```
for sample in `cat ALJRbin.list.txt`; do grep '^>' /groups/spartina/metagenomes_analysis/sulfur.40bin.RENAMED_BINS/renamedbins/${sample}.fa >${sample}_ID.txt; done
```
### 2. prepareID file
```
for sample in `cat ALJRbin.list.txt`; do sed 's/>//' ${sample}_ID.txt > ${sample}_ID2.txt; done
for sample in `cat ALJRbin.list.txt`; do echo -e "ContigID" | cat - ${sample}_ID2.txt > 00${sample}_ID2.txt_renamed; done
```
### 3. loop to extract quantification data.
```
for sample in `cat ALJRbin.list.txt`; do for line in `cat srr.files.txt`; do grep -Fwf  ${sample}_ID2.txt /groups/spartina/metagenomes_analysis/sulfur.40bin.HEATMAPS/others/ALJr/quant_files/${line}.quant.counts > ${sample}.${line}.count; done ; done

for sample in `cat ALJRbin.list.txt`; do for line in `cat srr.files.txt`; do awk '{print $2}' ${sample}.${line}.count > ${sample}.${line}.count2; done; done

for sample in `cat ALJRbin.list.txt`; do mkdir graph_${sample}; done
```

### 4. rename for contig based graph
```
for sample in `cat ALJRbin.list.txt`; do for line in `cat srr.files.txt`; do echo -e "${line}" | cat - ${sample}.${line}.count2 > ${sample}.${line}.count2_renamed; done; done

for sample in `cat ALJRbin.list.txt`; do paste 00${sample}_ID2.txt_renamed ${sample}.*.count2_renamed | pr -t  >./graph_${sample}/${sample}_final.counts_renamed; done
```
### 5. sort for size based graph (low to high)
```
for sample in `cat ALJRbin.list.txt`; do for line in `cat srr.files.txt`; do echo -e "${line}" | sort -n ${sample}.${line}.count2 > ${sample}.${line}.count2_sorted; done; done

for sample in `cat ALJRbin.list.txt`; do for line in `cat srr.files.txt`; do echo -e "${line}" | cat - ${sample}.${line}.count2_sorted > ${sample}.${line}.count2_sortedrenamed; done; done

for sample in `cat ALJRbin.list.txt`; do paste ${sample}.*.count2_sortedrenamed | pr -t  >./graph_${sample}/${sample}_final.counts_sortedrenamed; done
#6. remove intermediate files
rm *count*

rm *ID*
```
