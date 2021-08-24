## taxonomy using kraken

https://github.com/bxlab/metaWRAP/blob/master/Usage_tutorial.md#step-3-run-kraken-module-on-both-reads-and-the-assembly

module load metawrap
mkdir binning
metawrap kraken -t 10 -s 10000000 -o /groups/spart2020/metagenomics/Alabama_denovo_Assembly/bining/KRAKEN  /automounts/workspace/workspace/Eli/AlabamaMarshes/concatenated_*.fastq /groups/spart2020/metagenomics/Alabama_denovo_Assembly/final.contig.fa 

### extract data of interest!
#optional. extract lines of interest (containg Deltaproteobacteria for example but can be any taxonomical rank)

grep -E Deltaproteobacteria filename.kraken > Deltaproteobacteria.txt

this file can be used for Venn diagrams 
copy all the info in the file into a excel file, and select the column of interest. If you do this with the three sets of samples, you can search for common taxa using venny. https://bioinfogp.cnb.csic.es/tools/venny/ 
just use the taxon names to fill the white boxes and check how many are the same!


# if you want to get the number and length of the contigs
#print the conting ID into a new file

awk '{print $1}' Deltaproteobacteria.txt > contig_Deltaproteobacteria.txt

#extract fasta sequences from the assembly matching conting ID (therefore deltaproteobacteria) using seqtk.
module load seqtk

seqtk subseq assemblyfilename.fa contig_Deltaproteobacteria.txt > contig_Deltaproteobacteria.fa

Now you can compare lenght, GC, etc. using metaquast (e.g. original assembly versus subsample containing deltaproteobacteria)

metaquast.py *.fa -o metaQUAST --max-ref-number 0

# Kraken2
mkdir ~/kraken2/
cd ~/kraken2/
 
module load kraken2

kraken2 --threads 10 ~/Assembly/final.contigs.fa > ~/kraken2/Alabama_Spartina.assembly.kraken


for file in `cat samples.txt`; do kraken2 --paired --threads 10  ~/reads/${file}_good_1.fastq ~/reads/${file}_good_2.fastq> ~/kraken2/Alabama.${file}.kraken; done

for file in `cat samples.txt`; do cat ~/kraken2/Alabama.${file}.kraken | cut -f 2,3 > ~/kraken2/Alabama.${file}.kraken.krona; done

for file in `cat samples.txt`; do ktImportTaxonomy ~/kraken2/Alabama.${file}.kraken.krona -o ~/kraken/Alabama.${file}.kraken.krona.html; done


firefox taxonomy.krona.html


**extract taxa of interest from assembly using Kraken2 taxonomy**


mkdir ~/kraken2/SOB_sensuLato/
cd ~/kraken2/SOB_sensuLato/

kraken2 --use-names --threads 10 ~/Assembly/spartina.final.contigs.fa > ~/kraken2/SOB_sensuLato/Alabama.spartina.assembly.kraken

kraken2 --use-names --threads 10 /groups/spartina/metagenomes_analysis/Alabama_JGI/raw_reads_Juncus/paired/good/MEGAHIT_79_141/final.contig.fa > ~/Alabama_Spartina_Megahit/kraken2/SOB_sensuLato/Alabama.juncus.assembly.kraken

for file in `cat ~/kraken2/SOB_sensuLato/SOB_sensulato.txt`; do grep -E ${file} ~/kraken2/SOB_sensuLato/Alabama.spartina.assembly.kraken  > ~/kraken2/SOB_sensuLato/Alabama.spartina.${file}.txt; done

cat ~/kraken2/SOB_sensuLato/Alabama.spartina.*.txt >~/kraken2/SOB_sensuLato/Alabama.spartina.SOB.txt

for file in `cat ~/kraken2/SOB_sensuLato/SOB_sensulato.txt`; do grep -E ${file} ~/kraken2/SOB_sensuLato/Alabama.juncus.assembly.kraken  > ~/kraken2/SOB_sensuLato/Alabama.juncus.${file}.txt; done

cat ~/kraken2/SOB_sensuLato/Alabama.juncus.*.txt >~/kraken2/SOB_sensuLato/Alabama.juncus.SOB.txt



