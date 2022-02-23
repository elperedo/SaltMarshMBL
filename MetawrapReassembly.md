### Reconstruction of reference-guided, sample specific, assembled MAGs
**Re-assemble the consolidated bin set with the Reassemble_bins module**


for file in `cat /groups/spartina/metagenomes_analysis/anvio.40bins/srr.files.txt`; do  metawrap reassemble_bins -o /groups/spartina/metagenomes_analysis/Reassembled_bins/Al_JR15/${file}.BIN_REASSEMBLY -1 /groups/spart2020/paper_metagenomics_reads/${file}_good_1.fastq -2 /groups/spart2020/paper_metagenomics_reads/${file}_good_2.fastq -t 16 -m 800 -c 70 -x 10 -b /groups/spartina/metagenomes_analysis/Reassembled_bins/Al_JR15 --parallel; done
