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

## R script for graphing
```
#import data



dt <- read.delim("/groups/spartina/metagenomes_analysis/sulfur.40bin.HEATMAPS/linear.graphs/grap_plot_ordered
/Rowley.Spatens.bin.16_final.counts_sortedrenamed")

library(ggplot2)
df <- data.frame(dt)
str(df)
library(tidyverse)

pdf("Rowley.Spatens.bin.16_final_line_rplot.pdf") 

df_long = df %>% 
  mutate(contig = 1:nrow(.)) %>% 
  gather(contig.vars, CPM, -contig) 

df_long %>% 
  ggplot(aes(y = CPM, x = contig, group = contig.vars, color =contig.vars)) + 
  geom_line(size = 1) +
  scale_linetype_manual(values=c("SRR10854653", "SRR11061153", "SRR11061154", "SRR11567157", "SRR11567260", "SRR11567261", "SRR11828593", "SRR11828800", "SRR11828889", "SRR11828899", "SRR11829000", "SRR11829102", "SRR11829104", "SRR11829268", "SRR11829269", "SRR12659820", "SRR9045291", "SRR9045292", "SRR9045293", "SRR9045294", "SRR9045295", "SRR9045296", "SRR9045297", "SRR9045298"))+
  scale_color_manual(values=c("darkgreen", "darkolivegreen3", "darkolivegreen3", "darkgreen", "darkolivegreen3", "darkolivegreen3", "darkgoldenrod2", "darkorange4", "darkgoldenrod2", "darkorange4", "darkorange4", "darkgoldenrod2", "darkorange4", "darkgoldenrod2", "darkorange4", "darkgoldenrod2", "darkolivegreen3", "darkgreen", "darkgreen", "darkolivegreen3", "darkolivegreen3", "darkgreen", "darkolivegreen3", "darkgreen"))+
  scale_size_manual(values=c(1, 1))+
  theme(legend.position="none")
dev.off() 

```
