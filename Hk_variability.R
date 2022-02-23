#https://merenlab.org/2015/07/20/analyzing-variability/

setwd("~/evol5/groups/spartina/metagenomes_analysis/sulfur.40.ENTROPY_anvio/HK_genes_sulfur/ALJR36")
# Extract columns

if (!require("tidyverse")) {
  install.packages("tidyverse", dependencies = TRUE)
  library(tidyverse)
}

if (!require("data.table")) {
  install.packages("data.table", dependencies = TRUE)
  library(data.table)
}

cf<- read.delim("ALJR36.HouseKeeping_variability.NT.txt")
as.data.frame.matrix(cf)
str(cf)

#analysis coverage
cf1 <- aggregate(gene_coverage~corresponding_gene_call + sample_id + gene_length, data = cf, FUN = function(cf) c( n = length(cf), sum = sum(cf), mean = mean(cf), sd = sd (cf)))
write.table(cf1, file= "ALJR36.HouseKeeping_coverage_results_NT.txt", quote = F,sep = "\t", row.names= F)
cf2<- read.delim("ALJR36.HouseKeeping_coverage_results_NT.txt")


# Get stat #average gene coverage
as.data.frame.matrix(cf2)
str (cf2)
cf2$cov_stat <- with(cf2, (cf2$gene_coverage.sum/cf2$gene_coverage.n))
write.table(cf2, file= "ALJR36.HouseKeeping_coverage_results_NT_stat.txt", quote = F,sep = "\t", row.names= F)
setDT (cf2)
is.data.table(cf2)
cf3 <- subset(cf2, select= c (1,2,8))
cf4 <- cf3 %>%
  pivot_wider (names_from= sample_id, values_from =cov_stat)
write.table(cf4, file= "ALJR36.HouseKeeping_coverage_results_NT.txt", quote = F,sep = "\t", row.names= F)



#order genes so they match excel
row_orden <-c("1331","1330","1426","980","2141","2150","2138","2156","2147","1279","2134","2065","1117","2136","2142","566","1118","499","2139","2149","1225","2230","498","2066","2143","2146","1329","508","112","2153","1326","2152","2144","2181","1276","2140","506","1738","2099","2135","1546","1121","81","2137","2154","2148","505","1325","2145","979","2155","1328","1327","29","84","1031","704","805","1987","2126","2044","283","748","1105","1323","567","559","106","1665","1547","2067","1863","1324","2178","491","2098","985","1829","1824","1185","1760","800","1345","801","1869","24","22","1959","88","278","1186","1187","487","974","54","55","1352","2013","1415","1516","151","152","1656")
raw<- read.delim("ALJR36.HouseKeeping_coverage_results_NT.txt")
ordered<- raw %>%
  slice(match (row_orden, corresponding_gene_call))%>%
  relocate(any_of(c("corresponding_gene_call", "ALJR_SRR11061153", "ALJR_SRR11061154", "ALJR_SRR11567260", "ALJR_SRR11567261", "ALJR_SRR9045291", "ALJR_SRR9045294", "ALJR_SRR9045295", "ALJR_SRR9045297", "ALSA_SRR10854653", "ALSA_SRR11567157", "ALSA_SRR9045292", "ALSA_SRR9045293", "ALSA_SRR9045296", "ALSA_SRR9045298", "MASA_SRR11828800", "MASA_SRR11828899", "MASA_SRR11829000", "MASA_SRR11829104", "MASA_SRR11829269", "MASP_SRR11828593", "MASP_SRR11828889", "MASP_SRR11829102", "MASP_SRR11829268", "MASP_SRR12659820")))
write_tsv(ordered, "ALJR36.HouseKeeping_coverage_results_NT_ordered.txt")


# Heatmap
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}
if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

cf5<- read.delim("ALJR36.HouseKeeping_coverage_results_NT_ordered.txt", row.names= 1)
class(cf5)
pdf(file ="ALJR36.HouseKeeping_coverage_results_heatmap_dendrograme.pdf", width =11, height= 18)
heatmap.2(as.matrix(cf5), # data frame a matrix
          margins = c(10,6), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = TRUE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cf5), # Add vertical grid lines
          #rowsep=1:nrow(cf5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          col =colorRampPalette(c( "white", '#FCE1a4','#fabf7b','#f08f6e','#e05c5c','#dc3977','#d12959','#ab1866','#7c1d6f','#6e005f')),
          breaks=seq(2,20)) # Make colors viridis,
dev.off()

pdf(file ="ALJR36.HouseKeeping_coverage_results_heatmap.pdf", width =11, height= 18)
heatmap.2(as.matrix(cf5), # data frame a matrix
          margins = c(10,6), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = FALSE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cf5), # Add vertical grid lines
          #rowsep=1:nrow(cf5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          col =colorRampPalette(c( "white", '#FCE1a4','#fabf7b','#f08f6e','#e05c5c','#dc3977','#d12959','#ab1866','#7c1d6f','#6e005f')),
          breaks=seq(2,20)) # Make colors viridis,
dev.off()

# filter outliers 

cf<- read.delim("ALJR36.HouseKeeping_variability.NT.txt")
cff0 <-  filter(cf, cov_outlier_in_contig=='0')  

# filter coverage <5 ## i am fitlering based in coverage in this position but mapping gene coverage...
cff <-  filter(cff0, coverage>=5) 

#analysis coverage
cff1 <- aggregate(gene_coverage~corresponding_gene_call + sample_id + gene_length, data = cff, FUN = function(cff) c( n = length(cff), sum = sum(cff), mean = mean(cff), sd = sd (cff)))
write.table(cff1, file= "ALJR36.HouseKeeping_coverage_results_NT_filtered.txt", quote = F,sep = "\t", row.names= F)
cff2<- read.delim("ALJR36.HouseKeeping_coverage_results_NT_filtered.txt")


# Get stat #average gene coverage
as.data.frame.matrix(cff2)
str (cff2)
cff2$cov_stat <- with(cff2, (cff2$gene_coverage.sum/cff2$gene_coverage.n))
write.table(cff2, file= "ALJR36.HouseKeeping_coverage_results_NT_stat_filtered.txt", quote = F,sep = "\t", row.names= F)
setDT (cff2)
is.data.table(cff2)
cff3 <- subset(cff2, select= c (1,2,8))
cff4 <- cff3 %>%
  pivot_wider (names_from= sample_id, values_from =cov_stat)
write.table(cff4, file= "ALJR36.HouseKeeping_coverage_results_NT_filtered.txt", quote = F,sep = "\t", row.names= F)



#order genes so they match excel
row_orden <-c("1331","1330","1426","980","2141","2150","2138","2156","2147","1279","2134","2065","1117","2136","2142","566","1118","499","2139","2149","1225","2230","498","2066","2143","2146","1329","508","112","2153","1326","2152","2144","2181","1276","2140","506","1738","2099","2135","1546","1121","81","2137","2154","2148","505","1325","2145","979","2155","1328","1327","29","84","1031","704","805","1987","2126","2044","283","748","1105","1323","567","559","106","1665","1547","2067","1863","1324","2178","491","2098","985","1829","1824","1185","1760","800","1345","801","1869","24","22","1959","88","278","1186","1187","487","974","54","55","1352","2013","1415","1516","151","152","1656")
raw<- read.delim("ALJR36.HouseKeeping_coverage_results_NT_filtered.txt")
ordered<- raw %>%
  slice(match (row_orden, corresponding_gene_call))%>%
  relocate(any_of(c("corresponding_gene_call", "ALJR_SRR11061153", "ALJR_SRR11061154", "ALJR_SRR11567260", "ALJR_SRR11567261", "ALJR_SRR9045291", "ALJR_SRR9045294", "ALJR_SRR9045295", "ALJR_SRR9045297", "ALSA_SRR10854653", "ALSA_SRR11567157", "ALSA_SRR9045292", "ALSA_SRR9045293", "ALSA_SRR9045296", "ALSA_SRR9045298", "MASA_SRR11828800", "MASA_SRR11828899", "MASA_SRR11829000", "MASA_SRR11829104", "MASA_SRR11829269", "MASP_SRR11828593", "MASP_SRR11828889", "MASP_SRR11829102", "MASP_SRR11829268", "MASP_SRR12659820")))
write_tsv(ordered, "ALJR36.HouseKeeping_coverage_results_NT_ordered_filtered.txt")


# Heatmap
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}
if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

cff5<- read.delim("ALJR36.HouseKeeping_coverage_results_NT_ordered_filtered.txt", row.names= 1)
class(cff5)
pdf(file ="ALJR36.HouseKeeping_coverage_results_heatmap_dendrograme_filtered.pdf", width =11, height= 18)
heatmap.2(as.matrix(cff5), # data frame a matrix
          margins = c(10,6), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = TRUE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cff5), # Add vertical grid lines
          #rowsep=1:nrow(cff5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          col =colorRampPalette(c( "white", '#FCE1a4','#fabf7b','#f08f6e','#e05c5c','#dc3977','#d12959','#ab1866','#7c1d6f','#6e005f')),
          breaks=seq(2,20)) # Make colors viridis,
dev.off()

pdf(file ="ALJR36.HouseKeeping_coverage_results_heatmap_filtered.pdf", width =11, height= 18)
heatmap.2(as.matrix(cff5), # data frame a matrix
          margins = c(10,6), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = FALSE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cff5), # Add vertical grid lines
          #rowsep=1:nrow(cff5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          col =colorRampPalette(c( "white", '#FCE1a4','#fabf7b','#f08f6e','#e05c5c','#dc3977','#d12959','#ab1866','#7c1d6f','#6e005f')),
          breaks=seq(2,20)) # Make colors viridis,
dev.off()

# Entropy

# filter outliers 

cf<- read.delim("ALJR36.HouseKeeping_variability.NT.txt")
# filter coverage <5 ## i am fitlering based in coverage in this position but mapping gene coverage...
cffe <-  filter(cf, cov_outlier_in_contig=='0' & coverage>=5)  

as.data.frame.matrix(cffe)
str(cffe)

# Calculate average and summatory 
cffe2 <- aggregate(entropy~corresponding_gene_call + sample_id + gene_length, data = cffe, FUN = function(cffe) c( n = length(cffe), sum = sum(cffe), mean = mean(cffe), sd = sd (cffe)))
write.table(cffe2, file= "ALJR36_NT_Entropy.HouseKeeping_results.txt", quote = F,sep = "\t", row.names= F)
cffe2<- read.delim("ALJR36_NT_Entropy.HouseKeeping_results.txt")


# Get stat
as.data.frame.matrix(cffe2)
str (cffe2)
cffe2$stat <- with(cffe2, (cffe2$entropy.sum/cffe2$entropy.n)/cffe2$gene_length)
write.table(cffe2, file= "ALJR36_NT_Entropy.HouseKeeping_results.txt", quote = F,sep = "\t", row.names= F)
setDT (cffe2)
is.data.table(cffe2)
cffe3 <- subset(cffe2, select= c (1,2,8))
cffe4 <- cffe3 %>%
  pivot_wider (names_from= sample_id, values_from =stat)
write.table(cffe4, file= "ALJR36_NT_Entropy.HouseKeeping_forheatmap_raw.txt", quote = F,sep = "\t", row.names= F)

# Heatmap
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}
if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

#order genes so they match excel
row_orden <-c("1331","1330","1426","980","2141","2150","2138","2156","2147","1279","2134","2065","1117","2136","2142","566","1118","499","2139","2149","1225","2230","498","2066","2143","2146","1329","508","112","2153","1326","2152","2144","2181","1276","2140","506","1738","2099","2135","1546","1121","81","2137","2154","2148","505","1325","2145","979","2155","1328","1327","29","84","1031","704","805","1987","2126","2044","283","748","1105","1323","567","559","106","1665","1547","2067","1863","1324","2178","491","2098","985","1829","1824","1185","1760","800","1345","801","1869","24","22","1959","88","278","1186","1187","487","974","54","55","1352","2013","1415","1516","151","152","1656")
raw<- read.delim("ALJR36_NT_Entropy.HouseKeeping_forheatmap_raw.txt")
ordered<- raw %>%
  slice(match (row_orden, corresponding_gene_call))%>%
  relocate(any_of(c("corresponding_gene_call", "ALJR_SRR11061153", "ALJR_SRR11061154", "ALJR_SRR11567260", "ALJR_SRR11567261", "ALJR_SRR9045291", "ALJR_SRR9045294", "ALJR_SRR9045295", "ALJR_SRR9045297", "ALSA_SRR10854653", "ALSA_SRR11567157", "ALSA_SRR9045292", "ALSA_SRR9045293", "ALSA_SRR9045296", "ALSA_SRR9045298", "MASA_SRR11828800", "MASA_SRR11828899", "MASA_SRR11829000", "MASA_SRR11829104", "MASA_SRR11829269", "MASP_SRR11828593", "MASP_SRR11828889", "MASP_SRR11829102", "MASP_SRR11829268", "MASP_SRR12659820")))
write_tsv(ordered, "ALJR36_NT_Entropy.HouseKeeping_forheatmap_ordered.txt")


cffe5<- read.delim("ALJR36_NT_Entropy.HouseKeeping_forheatmap_ordered.txt", row.names= 1)
class(cffe5)
pdf(file ="ALJR36_NT_Entropy.HouseKeeping_heatmap_dendrogram.pdf", width =11, height= 18)
heatmap.2(as.matrix(cffe5), # data frame a matrix
          margins = c(12,8), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = TRUE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cffe5), # Add vertical grid lines
          #rowsep=1:nrow(cffe5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          breaks = seq(0, max(cffe5, na.rm = TRUE), length.out = 100),
          col =colorRampPalette(c( "white", "#440154FF", "#471164FF", "#481F70FF", "#472D7BFF", "#443A83FF", "#404688FF", "#3B528BFF", "#365D8DFF", "#31688EFF", "#2C728EFF", "#287C8EFF", "#24868EFF", "#21908CFF", "#1F9A8AFF", "#20A486FF", "#27AD81FF", "#35B779FF", "#47C16EFF", "#5DC863FF", "#75D054FF", "#8FD744FF", "#AADC32FF", "#C7E020FF", "#E3E418FF", "#FDE725FF"))) # Make colors viridis
dev.off()


pdf(file ="ALJR36_NT_Entropy.HouseKeeping_heatmap.pdf", width =11, height= 18)
heatmap.2(as.matrix(cffe5), # data frame a matrix
          margins = c(12,8), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = FALSE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(cffe5), # Add vertical grid lines
          #rowsep=1:nrow(cffe5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          breaks = seq(0, max(cffe5, na.rm = TRUE), length.out = 100),
          col =colorRampPalette(c( "white", "#440154FF", "#471164FF", "#481F70FF", "#472D7BFF", "#443A83FF", "#404688FF", "#3B528BFF", "#365D8DFF", "#31688EFF", "#2C728EFF", "#287C8EFF", "#24868EFF", "#21908CFF", "#1F9A8AFF", "#20A486FF", "#27AD81FF", "#35B779FF", "#47C16EFF", "#5DC863FF", "#75D054FF", "#8FD744FF", "#AADC32FF", "#C7E020FF", "#E3E418FF", "#FDE725FF"))) # Make colors viridis
dev.off()

rm(list = ls())


df0<- read.delim("ALJR36.HouseKeeping_variability.CDN.txt")
df <-  filter(df0, coverage>=5)  

as.data.frame.matrix(df)
str(df)

# Calculate average and summatory 
df2 <- aggregate(entropy~corresponding_gene_call + sample_id + gene_length, data = df, FUN = function(df) c( n = length(df), sum = sum(df), mean = mean(df), sd = sd (df)))
write.table(df2, file= "ALJR36_CDN.HouseKeeping.filtered_results.txt", quote = F,sep = "\t", row.names= F)
df2<- read.delim("ALJR36_CDN.HouseKeeping.filtered_results.txt")


# Get stat
as.data.frame.matrix(df2)
str (df2)
df2$stat <- with(df2, (df2$entropy.sum/df2$entropy.n)/df2$gene_length)
write.table(df2, file= "ALJR36_CDN.HouseKeeping.filtered_results.txt", quote = F,sep = "\t", row.names= F)
setDT (df2)
is.data.table(df2)
df3 <- subset(df2, select= c (1,2,8))
df4 <- df3 %>%
  pivot_wider (names_from= sample_id, values_from =stat)
write.table(df4, file= "ALJR36_CDN.HouseKeeping.filtered_forheatmap_raw.txt", quote = F,sep = "\t", row.names= F)

# Heatmap
if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
  library(gplots)
}
if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
  library(RColorBrewer)
}
if (!require("ggplot2")) {
  install.packages("ggplot2", dependencies = TRUE)
  library(ggplot2)
}

#order genes so they match excel
row_orden <-c("1331","1330","1426","980","2141","2150","2138","2156","2147","1279","2134","2065","1117","2136","2142","566","1118","499","2139","2149","1225","2230","498","2066","2143","2146","1329","508","112","2153","1326","2152","2144","2181","1276","2140","506","1738","2099","2135","1546","1121","81","2137","2154","2148","505","1325","2145","979","2155","1328","1327","29","84","1031","704","805","1987","2126","2044","283","748","1105","1323","567","559","106","1665","1547","2067","1863","1324","2178","491","2098","985","1829","1824","1185","1760","800","1345","801","1869","24","22","1959","88","278","1186","1187","487","974","54","55","1352","2013","1415","1516","151","152","1656")
raw<- read.delim("ALJR36_CDN.HouseKeeping.filtered_forheatmap_raw.txt")
ordered<- raw %>%
  slice(match (row_orden, corresponding_gene_call))%>%
  relocate(any_of(c("corresponding_gene_call", "ALJR_SRR11061153", "ALJR_SRR11061154", "ALJR_SRR11567260", "ALJR_SRR11567261", "ALJR_SRR9045291", "ALJR_SRR9045294", "ALJR_SRR9045295", "ALJR_SRR9045297", "ALSA_SRR10854653", "ALSA_SRR11567157", "ALSA_SRR9045292", "ALSA_SRR9045293", "ALSA_SRR9045296", "ALSA_SRR9045298", "MASA_SRR11828800", "MASA_SRR11828899", "MASA_SRR11829000", "MASA_SRR11829104", "MASA_SRR11829269", "MASP_SRR11828593", "MASP_SRR11828889", "MASP_SRR11829102", "MASP_SRR11829268", "MASP_SRR12659820")))
write_tsv(ordered, "ALJR36_CDN.HouseKeeping.filtered_forheatmap_ordered.txt")


df5<- read.delim("ALJR36_CDN.HouseKeeping.filtered_forheatmap_ordered.txt", row.names= 1)
class(df5)
pdf(file ="ALJR36_CDN_Entropy.HouseKeeping.filtered_heatmap_dendrogram.pdf", width =11, height= 18)
heatmap.2(as.matrix(df5), # data frame a matrix
          margins = c(12,8), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = TRUE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(df5), # Add vertical grid lines
          #rowsep=1:nrow(df5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          breaks = seq(0, max(df5, na.rm = TRUE), length.out = 100),
          col =colorRampPalette(c( "white", "#440154FF", "#471164FF", "#481F70FF", "#472D7BFF", "#443A83FF", "#404688FF", "#3B528BFF", "#365D8DFF", "#31688EFF", "#2C728EFF", "#287C8EFF", "#24868EFF", "#21908CFF", "#1F9A8AFF", "#20A486FF", "#27AD81FF", "#35B779FF", "#47C16EFF", "#5DC863FF", "#75D054FF", "#8FD744FF", "#AADC32FF", "#C7E020FF", "#E3E418FF", "#FDE725FF"))) # Make colors viridis
dev.off()

pdf(file ="ALJR36_CDN_Entropy.HouseKeeping.filtered_heatmap.pdf", width =11, height= 18)
heatmap.2(as.matrix(df5), # data frame a matrix
          margins = c(12,8), # Adds margins below and to the right
          density.info = "none", # Remove density legend lines
          trace = "none", # Remove the blue trace lines from heatmap
          Rowv = FALSE, # Do not reorder the rows
          Colv = FALSE, # Do not reorder the rows-- set to false for whole dataset. 
          dendrogram = "col", # Only plot column dendrogram
          #colsep=1:ncol(df5), # Add vertical grid lines
          #rowsep=1:nrow(df5), # Add horizontal grid lines
          #sepcolor = "black", # Color gridlines black
          na.color="gray",
          breaks = seq(0, max(df5, na.rm = TRUE), length.out = 100),
          col =colorRampPalette(c( "white", "#440154FF", "#471164FF", "#481F70FF", "#472D7BFF", "#443A83FF", "#404688FF", "#3B528BFF", "#365D8DFF", "#31688EFF", "#2C728EFF", "#287C8EFF", "#24868EFF", "#21908CFF", "#1F9A8AFF", "#20A486FF", "#27AD81FF", "#35B779FF", "#47C16EFF", "#5DC863FF", "#75D054FF", "#8FD744FF", "#AADC32FF", "#C7E020FF", "#E3E418FF", "#FDE725FF"))) # Make colors viridis
dev.off()
rm(list = ls())


