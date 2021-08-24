# Read Quality Control
# These files are HUGE, check space before running and remove unnecesary files once one step has been finished**
# Load modules
 
module purge
module load bioware
module load fastqc
module load trimmomatic
module load prinseq-lite/0.20.4

# preQC stats
# Use fastqc and print seq to generate preliminary quality control data

fastqc *pass*.fastq

# trimmomatic

# QC and remove adapters

#***needs the adapter.fa file*** double check the initial fastqc reports, and update the adapter file if sequences not listed in the file are found in the overrepresented in the samples.

for file in `cat samples.txt`; do trimmomatic  PE -phred33 -threads 12  ${file}_pass_1.fastq ${file}_pass_2.fastq ${file}_paired_R1.fastq ${file}_unpaired_R1.fastq ${file}_paired_R2.fastq ${file}_unpaired_R2.fastq ILLUMINACLIP:/groups/spart2020/adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36; done

#remove unpaired reads 

rm *unpaired*

# post trimmomatic stats
#Use fastqc and print seq to generate preliminary quality control data

fastqc *paired*.fastq

# printseq-lite

# run in cluster setting 
#length and deduplication!!


module load prinseq-lite/0.20.4

for file in `cat samples.txt`; do clusterize -n 10 -m elperedo@mbl.edu  -log ${file}_printseq.log prinseq-lite.pl -fastq ${file}_paired_R1.fastq -fastq2 ${file}_paired_R2.fastq -min_len 60 -min_qual_mean 20 -ns_max_n 0 -derep 12345 -trim_qual_left 20 -trim_qual_right 20 -trim_qual_type min -trim_qual_rule lt -out_format 3 -out_good ${file}_good -out_bad null -verbose; done

# use the log file to complete the QC quality survey.
