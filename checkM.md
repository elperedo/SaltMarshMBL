## CheckM

 [https://github.com/Ecogenomics/CheckM/wiki/Genome-Quality-Commands](https://github.com/Ecogenomics/CheckM/wiki/Genome-Quality-Commands)

### Step 1: Place bins in the reference genome
```
checkm tree /users/eperedo/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_70_sulfur /users/eperedo/Alabama_Spartina_Megahit/BIN_REFINEMENT/metawrap_70_sulfur/checkM/bins_70_sulfur_tree_folder -x fa -t 10
```
### Step 2: Assess phylogenetic markers found in each bin
```
checkm tree_qa /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/binsAB_tree_folder -o 2 -f /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.Taxonomy.output --tab_table
```
### Step 3: Infer lineage-specific marker sets for each bin
```
checkm lineage_set /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/binsAB_tree_folder /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.MarkerFile.output
```
### Step 4: List available taxonomic-specific marker sets
```
checkm taxon_list > /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/checkM/checkM.taxon_list.output
```
### Step 5: Generate taxonomic-specific marker set
```
checkm taxon_set domain Bacteria /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.taxon_set.output
```
### Step 6: Identify marker genes bins
```
checkm analyze /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.MarkerFile.output /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/work_files/binsAB /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/analyze -t 10 -x fa
```
### Step 7: Assess bins for contamination and completeness
```
checkm qa /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.MarkerFile.output /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/analyze  -o 2 -f /users/eperedo/Rowley_metagenomes_subset/INITIAL_BINNING_MH_Rowley/BIN_REFINEMENT/checkM/checkM.Contamination.Completeness.output --tab_table
```
