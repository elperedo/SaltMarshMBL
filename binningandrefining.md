## Binning & refinement using MetaWRAP
MetaWRAP offers a hybrid approach for extracting draft metagenomes (bins, MAGs) by using metaBAT2, CONCOCT, and MaxBin2
https://github.com/bxlab/metaWRAP/blob/master/Usage_tutorial.md#step-4-bin-the-co-assembly-with-three-different-algorithms-with-the-binning-module
```
metawrap binning -o /groups/spart2020/metagenomics/Rowley_JGI/INITIAL_BINNING -t 16 -m 10 -a /groups/spart2020/metagenomics/Rowley_JGI/Rowley_final.contig_3000bp.fa --metabat2 --maxbin2 --concoct /groups/spart2020/rawData/metagenome/Rowley_Finished_Reads/*.fastq --run-checkm
```


## Refine those bins
MetaWRAP consolidates all 3 bin sets by picking the best of each bin version based on completion and redundancy (contamination) thresholds
https://github.com/bxlab/metaWRAP/blob/master/Usage_tutorial.md#step-5-consolidate-bin-sets-with-the-bin_refinement-module


```
clusterize -n 12 -log refinement.log -m mail@mail.com metawrap bin_refinement -o ~/BIN_REFINEMENT/ -t 12 -A ~/metabat2_bins/  -B /groups/spart2020/metagenomics/Rowley_JGI/INITIAL_BINNING_MH_Rowley/maxbin2_bins/ -c 50 -x 10
```
In the output directory, you will see the three original bin folders we fed in, as well as `metaWRAP` directory, which contains the final, consolidated bins.

**You will also see .stats files for each one of the bin directories.**

**how many "meah bins"** (based on out >50% comp., <10% cont. metric)
```
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/concoct_bins.stats | awk '$2>50 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/maxbin2_bins.stats | awk '$2>50 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metabat2_bins.stats | awk '$2>50 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_50_10_bins.stats | awk '$2>50 && $3<10' | wc -l
```
**how many "good bins"** (based on out >70% comp., <10% cont. metric) metaWRAP produced, we can run
(use which ever of these you need)
```
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/concoct_bins.stats | awk '$2>70 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/maxbin2_bins.stats | awk '$2>70 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metabat2_bins.stats | awk '$2>70 && $3<10' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_50_10_bins.stats | awk '$2>70 && $3<10' | wc -l
```

**how many "high quality bins"** (based on out >90% comp., <5% cont. metric) metaWRAP produced, we can run
(use which ever of these you need)
```
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/concoct_bins.stats | awk '$2>90 && $3<5' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/maxbin2_bins.stats | awk '$2>90 && $3<5' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metabat2_bins.stats | awk '$2>90 && $3<5' | wc -l
cat ~/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_50_10_bins.stats | awk '$2>90 && $3<5' | wc -l
```
