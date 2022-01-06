### prepare assembly
##Copy file to folder, filter out contigs lengh <1000

anvi-script-reformat-fasta /groups/spartina/metagenomes_analysis/DGR.bin.ANVIO/DGR.Alabama.Jroemerianus.bin.15/Alabama.Jroemerianus.bin.15.fa -o AlabamaJroemerianusbin15-2.fa -l 1000 --simplify-names  –report-file

#### Generate database based in assembly

anvi-gen-contigs-database -f AlabamaJroemerianusbin15.fa -o AlabamaJroemerianusbin15.db -L 20000 --skip-mindful-splitting -n 'genome'

anvi-run-hmms -c AlabamaJroemerianusbin15.db


anvi-script-gen_stats_for_single_copy_genes.py AlabamaJroemerianusbin15.db

anvi-script-gen_stats_for_single_copy_genes.R AlabamaJroemerianusbin15.db.hits AlabamaJroemerianusbin15.db.genes

#### Annotate COGs

anvi-run-ncbi-cogs -c AlabamaJroemerianusbin15.db -T 16


#### add taxonomy

anvi-get-sequences-for-gene-calls -c AlabamaJroemerianusbin15.db -o gene_calls.fa



module purge
module load bioware
module load centrifuge
export PATH=/bioware/centrifuge-1.0.4-beta:$PATH
export CENTRIFUGE_BASE="/workspace/eperedo/anvio/p+h+v"

#### import taxonomy into anvio

centrifuge -f -x $CENTRIFUGE_BASE/p+h+v gene_calls.fa -S centrifuge_hits.tsv
module purge
module load bioware
anvi-import-taxonomy-for-genes -c AlabamaJroemerianusbin15.db -i centrifuge_report.tsv centrifuge_hits.tsv -p centrifuge



#### GhostKoala
#https://merenlab.org/2018/01/115/importing-ghostkoala-annotations/

#get protein

anvi-get-sequences-for-gene-calls -c AlabamaJroemerianusbin15.db --get-aa-sequences   -o protein-sequences.fa
sed -i 's/>/>genecall_/' protein-sequences.fa

#upload protein.fa to ghost koala

#https://www.kegg.jp/ghostkoala/

#results
#https://www.kegg.jp/kegg-bin/blastkoala_result?id=b81fe155831515fc00f4fecc5bb15ee32cbcc56f532b&passwd=niFOqX&type=ghostkoala

##### import annotations

python /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/GhostKoalaParser/KEGG-to-anvio --KeggDB /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/GhostKoalaParser/KO_Orthology_ko00001.txt -i user_ko.txt -o KeggAnnotations-AnviImportable.txt


anvi-import-functions -c AlabamaJroemerianusbin15.db -i KeggAnnotations-AnviImportable.txt


gzip -d user.out.top.gz


python /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/GhostKoalaParser/GhostKOALA-taxonomy-to-anvio user.out.top KeggTaxonomy.txt

anvi-import-taxonomy-for-genes -c AlabamaJroemerianusbin15.db    -i KeggTaxonomy.txt  -p default_matrix


### summary taxonomy

mkdir taxonomy
module load diamond
anvi-run-scg-taxonomy -c AlabamaJroemerianusbin15.db --scgs-taxonomy-data-dir ./taxonomy
 anvi-estimate-scg-taxonomy -c AlabamaJroemerianusbin15.db -m -o ./taxonomy/out.txt




#### Generate BAMs
generate index

bowtie2-build -f AlabamaJroemerianusbin15.fa /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/AlabamaJroemerianusbin15


for file in `cat /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/srr.files.txt`; do clusterize -n 40 -m elperedo@mbl.edu  -log ${file}_bowtie2.log bowtie2 -x /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/AlabamaJroemerianusbin15 -1 /groups/spart2020/paper_metagenomics_reads/${file}_good_1.fastq -2 /groups/spart2020/paper_metagenomics_reads/${file}_good_2.fastq -S /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/${file}_metagenome.sam; done

for file in `cat /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/srr.files.txt`; do samtools view -F 4 -bS /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/${file}_metagenome.sam > /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/${file}-raw.bam; done


#### formating bams

for file in `cat /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/srr.files.txt`; do anvi-init-bam /users/eperedo/mapping_blair/DGR.Alabama.Jroemerianus.bin.15/${file}-raw.bam -o /groups/spartina/metagenomes_analysis/DGR.bin.ANVIO/DGR.Alabama.Jroemerianus.bin.15/${file}.bam; done


### initialize mapping.
for file in `cat /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/srr.files.txt`; do anvi-profile -i /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/Alabama.Jroemerianus.bin.15/mapping/${file}.bam -c /groups/spartina/metagenomes_analysis/sulfur.40bin.ANVIO/Alabama.Jroemerianus.bin.15/AlabamaJroemerianusbin15.db --profile-SCVs; done

#### merge

anvi-merge ./*/PROFILE.db  -o AlabamaJroemerianusbin15_all -c AlabamaJroemerianusbin15.db

anvi-import-misc-data ./layers_additional_data.txt -p AlabamaJroemerianusbin15/PROFILE.db   --target-data-table layers

anvi-interactive -c AlabamaJroemerianusbin15.db -p AlabamaJroemerianusbin15/PROFILE.db --server-only -P 8008

##remember to get Bin_1 and default collection

#variability

anvi-gen-variability-profile -p AlabamaJroemerianusbin15/PROFILE.db -c AlabamaJroemerianusbin15.db  -C Bin_1  -b default --compute-gene-coverage-stats --engine NT --quince-mode --o AlabamaJroemerianusbin15.variability.NT.txt

anvi-gen-variability-profile -p AlabamaJroemerianusbin15/PROFILE.db -c AlabamaJroemerianusbin15.db  -C Bin_1  -b default --compute-gene-coverage-stats --engine AA --o AlabamaJroemerianusbin15.variability.AA.txt

anvi-gen-variability-profile -p AlabamaJroemerianusbin15/PROFILE.db -c AlabamaJroemerianusbin15.db  -C Bin_1  -b default --compute-gene-coverage-stats --engine CDN --o AlabamaJroemerianusbin15.variability.CDN.txt


anvi-interactive -c AlabamaJroemerianusbin15.db -p AlabamaJroemerianusbin15/PROFILE.db --server-only -P 8008
