


conda activate
conda activate anvio-dev

cd /home/elena/evol5/groups/spartina/metagenomes_analysis/sulfur.40.ENTROPY_anvio/

## first.
can I get gene specific variability? yes.
# MASP16
cd Rowley.Spatens.bin.16
## get genesID from ANVIO

anvi-migrate RowleySpatensbin16.db  RowleySpatensbin16/PROFILE.db --migrate-dbs-safely

anvi-interactive -c RowleySpatensbin16.db -p RowleySpatensbin16/PROFILE.db

#these are the sulfur gene ID (kegg and cog function)
K00380,K00390,K00392,K00394,K00395,K00955,K00958,K01011,K08352,K11180,K11181,K13811,K17223,K17224,K17226,K17227,K17993,K17994,K17995,K21307,K21308,K21309,PF00034.22,PF09839.10

#these are the housekeeping plus sulfur (new)
COG1098,COG0081,COG0244,COG0080,COG2264,COG2058,COG0102,COG4352,COG0093,COG2163,COG0200,COG1632,COG2850,COG0197,COG0203,COG0256,COG1727,COG0335,COG2147,COG0090,COG0292,COG2157,COG0261,COG2139,COG0091,COG0089,COG0198,COG2075,COG1825,COG0211,COG0227,COG0255,COG0087,COG1841,COG1911,COG0254,COG2097,COG0333,COG1717,COG0267,COG0230,COG2174,COG0291,COG2451,COG0257,COG1997,COG2126,COG2167,COG0088,COG1552,COG1631,COG0094,COG0097,COG0222,COG1358,COG0359,COG5459,COG0539,COG0051,COG0100,COG0048,COG1944,COG0099,COG0199,COG0184,COG0228,COG0186,COG1383,COG0238,COG0456,COG0185,COG2238,COG0052,COG0268,COG0828,COG2004,COG4901,COG4830,COG1998,COG2051,COG2053,COG0092,COG4919,COG1890,COG0522,COG1471,COG0098,COG0360,COG2125,COG0049,COG0096,COG2007,COG0103,COG0202,COG0085,COG0086,COG0568,COG1595,COG3343,COG5503,COG1460,COG1508,COG1758,COG1191,COG2012,COG1095,COG1594,COG1761,COG1996,COG0023,COG0050,COG0193,COG0216,COG0231,COG0264,COG0290,COG0361,COG0480,COG0532,COG1093,COG1184,COG1186,COG1503,COG1601,COG1976,COG2092,COG3276,COG4108,COG5256,COG5257,COG0372,COG1048,COG1049,COG0538,COG2838,COG0473,COG0567,COG0074,COG0045,COG1053,COG0479,COG1951,COG1838,COG0114,COG0039,COG2055,K00134,K00873,K03737,K00163,K00172,K00925,K00016,K00001,K00929,K00261,K00259,K00133,K00003,K01647,K00031,K01907,K00368,COG1251,K02118,K13811,K00955,K00390,K00380,K00392,K00958,K00394,K00395,K11180,K11181,K21307,K21308,K21309,K01011,K08352,K17995,K00437,K17993,K17994



#variability--general ## already done.

##remember to get Bin_1 and default collection

anvi-gen-variability-profile -p RowleySpatensbin16/PROFILE.db -c RowleySpatensbin16.db  -C default -b  Bin_1 --compute-gene-coverage-stats --engine NT --quince-mode --output-file MASP16.variability.NT.txt

anvi-gen-variability-profile -p RowleySpatensbin16/PROFILE.db -c RowleySpatensbin16.db  -C default -b  Bin_1 --compute-gene-coverage-stats --engine AA --o MASP16.variability.AA.txt

anvi-gen-variability-profile -p RowleySpatensbin16/PROFILE.db -c RowleySpatensbin16.db  -C default -b  Bin_1 --compute-gene-coverage-stats --engine CDN --o MASP16.variability.CDN.txt --kiefl-mode

#remove the -C Bin_1  -b default
https://merenlab.org/2015/07/20/analyzing-variability/
#CDN

anvi-gen-variability-profile -p RowleySpatensbin16/PROFILE.db -c RowleySpatensbin16.db  --compute-gene-coverage-stats -x 1 --min-coverage-in-each-sample 0 --engine CDN -o ROSP16.HouseKeeping_variability.CDN.txt   --gene-caller-ids 816,1253,2141,2150,2138,2156,2147,1319,2134,209,3114,2136,2133,2142,1392,3115,726,2139,2131,2149,2935,1717,1766,208,2473,2132,2143,2146,1666,2535,2130,2154,2153,2144,272,1323,2140,1668,172,383,409,555,706,1555,1788,1943,2330,2852,2907,2135,959,1008,2453,665,2137,848,2148,1669,2145,1252,2155,734,1967,2019,206,430,2079,334,2129,3061,1391,693,2445,958,201,1133,267,579,2128,674,945,1343,2030,856,138,3146,3148,3149,760,1311,1310,298,792,3150,2957,2318,2470,473,2033,3004,2331,2856,142,1258,1515,820,1161,1233,1990,1552,1723,757,761,768,767,766,2851,1221,1222 --include-site-pnps  --include-additional-data --include-split-names --include-contig-names --kiefl-mode

#no need to remove the outliers.
"non_outlier_gene_coverage is a measure of gene coverage that excludes nucleotide positions outlier coverage values. The criterion is that the average coverage is computed over nucleotides that are within plus or minus 1.5 times the MAD (median absolute deviation) of the median coverage value. We took this idea from this paper and we like it very much because it does a good job at excluding sequence motifs that are conserved between species/populations and therefore recruit unrealistically high coverage values. -1 if position is not in a called gene."
outliers seem to be excluded already.


#NT

anvi-gen-variability-profile -p RowleySpatensbin16/PROFILE.db -c RowleySpatensbin16.db   --compute-gene-coverage-stats -x 1 --min-coverage-in-each-sample 0 --engine NT -o ROSP16.HouseKeeping_variability.NT.txt   --gene-caller-ids 816,1253,2141,2150,2138,2156,2147,1319,2134,209,3114,2136,2133,2142,1392,3115,726,2139,2131,2149,2935,1717,1766,208,2473,2132,2143,2146,1666,2535,2130,2154,2153,2144,272,1323,2140,1668,172,383,409,555,706,1555,1788,1943,2330,2852,2907,2135,959,1008,2453,665,2137,848,2148,1669,2145,1252,2155,734,1967,2019,206,430,2079,334,2129,3061,1391,693,2445,958,201,1133,267,579,2128,674,945,1343,2030,856,138,3146,3148,3149,760,1311,1310,298,792,3150,2957,2318,2470,473,2033,3004,2331,2856,142,1258,1515,820,1161,1233,1990,1552,1723,757,761,768,767,766,2851,1221,1222  --include-site-pnps  --include-split-names --include-contig-names --quince-mode



# rename and prepare files.

grep -RiIl 'search' | xargs sed -i 's/SRR11061153/ALJR_SRR11061153/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11061154/ALJR_SRR11061154/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11567260/ALJR_SRR11567260/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11567261/ALJR_SRR11567261/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045291/ALJR_SRR9045291/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045294/ALJR_SRR9045294/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045295/ALJR_SRR9045295/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045297/ALJR_SRR9045297/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR10854653/ALSA_SRR10854653/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11567157/ALSA_SRR11567157/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045292/ALSA_SRR9045292/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045293/ALSA_SRR9045293/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045296/ALSA_SRR9045296/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR9045298/ALSA_SRR9045298/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11828800/MASA_SRR11828800/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11828899/MASA_SRR11828899/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11829000/MASA_SRR11829000/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11829104/MASA_SRR11829104/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11829269/MASA_SRR11829269/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11828593/MASP_SRR11828593/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11828889/MASP_SRR11828889/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11829102/MASP_SRR11829102/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR11829268/MASP_SRR11829268/g' *.txt
grep -RiIl 'search' | xargs sed -i 's/SRR12659820/MASP_SRR12659820/g' *.txt
