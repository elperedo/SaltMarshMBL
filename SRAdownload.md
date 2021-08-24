# SRA download
---
# The data fileq are over 50Gb. 
# Fastq-dump or fasterq-dump do not really work for files this size. 
# Use prefetch instead, this downloads sra files which are ~5Gb (including F and R reads!)

# Prefetch
#> more : http://www.metagenomics.wiki/tools/short-read/ncbi-sra-file-format/prefetch 
#You can download the compressed files in .sra format using `prefetch`
#Files will go to a ncbi folder in your user. (unless you set another output folder) 
#Once files have downloaded, use `fastq-dump` to get .sra files in fastq format. 
#Sra format is highly compressed. do not gunzip.

  module load sratoolkit
  for line in `cat samples.txt`; do prefetch -f yes ${line}; done 
  for line in `cat samples.txt`; do vdb-validate ${line}; done

# Fastq-dump 
# Now transform sra files into fastq, using fastq-dump and the flags to remove low quality reads. 

  for line in `cat samples.txt`; do fastq-dump  -W --split-files --read-filter pass --skip-technical ${line}; done
