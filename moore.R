library(readxl)
require(reshape2)
require(ggplot2)
library(nlme)
library(car)
library(rcompanion)
library(multcomp)
library(sciplot)
library(vegan)
library(RVAideMemoire)
library(devtools)
library(pairwiseAdonis)

#Fig.4a
MG_Genus_top20=as.matrix(read.table("bubble_moore4.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it
TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:24)
M.col=c(rep("#95A16E",8),rep("#555C41",6),rep("#B16645",5),rep("#D1A460",5))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) + #uses the same colors for projects throughout workflow
  labs(x="Culture Conditions", y="", col="",size="") + #axis labels
  theme_bw() + #table aesthetics 
  theme(axis.text.x = element_text(face="plain", color="Black", size=10, angle=90), #tickmark aesthetics 
        axis.text.y = element_text(face="plain", color="Black", size=10, angle=0))


#Fig.4b
moore_nmds4 <- read_excel("moore_nmds3.xlsx")
phyla.mds <- metaMDS(moore_nmds4[,1:38], distance = "bray",trace = FALSE,trymax=100)
phyla.mds
plot(phyla.mds, type = "n", display = "sites")
abline(v=0,lty=2)
abline(h=0,lty=2)
points(phyla.mds,display="sites",pch=c(rep(16,24)),col=c(rep("#95A16E",8),rep("#555C41",6),rep("#B16645",5),rep("#D1A460",5)))


#Fig.4c
moore_nmds4 <- read_excel("moore_nmds4.xlsx")
phyla.mds <- metaMDS(moore_nmds4[,1:38], distance = "bray",trace = FALSE,trymax=100)
phyla.mds
plot(phyla.mds, type = "n", display = "sites")
abline(v=0,lty=2)
abline(h=0,lty=2)
points(phyla.mds,display="sites",pch=c(rep(16,4),rep(17,3),rep(15,3)),col=c(rep("#B16645",2),rep("#D1A460",2),rep("#B16645",2),rep("#D1A460",1),rep("#B16645",1),rep("#D1A460",2)))


#Fig.4d
moore_nmds4 <- read_excel("moore_nmds6.xlsx")
phyla.mds <- metaMDS(moore_nmds4[,1:38], distance = "bray",trace = FALSE,trymax=100)
phyla.mds
plot(phyla.mds, type = "n", display = "sites")
abline(v=0,lty=2)
abline(h=0,lty=2)
points(phyla.mds,display="sites",pch=c(rep(16,3),rep(17,2),rep(15,3),rep(16,2),rep(17,2),rep(15,2)),col=c(rep("#95A16E",8),rep("#555C41",6)))


#adonis
str(moore_nmds4)
moore_nmds4$host<-as.factor(moore_nmds4$host)
moore_nmds4$depth<-as.factor(moore_nmds4$depth)
adonis2(moore_nmds4[,1:38] ~ host*depth, data=moore_nmds4, permutations=999,method="bray")
pairwise.adonis(moore_nmds4[,1:38],moore_nmds4$host)
pairwise.adonis(moore_nmds4[,1:38],moore_nmds4$depth)


moore_nmds4$month<-as.factor(moore_nmds4$month)
moore_nmds4$year<-as.factor(moore_nmds4$year)

adonis2(moore_nmds4[,1:38] ~ month, data=moore_nmds4, permutations=999,method="bray")
pairwise.adonis(moore_nmds4[,1:38],moore_nmds4$month)


MG_Genus_top20=as.matrix(read.table("IGERT_bubble8.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it
TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:40)
M.col=c(rep("yellow",17),rep("grey",15),rep("darkgreen",2),rep("brown",4),rep("pink",2))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) +
  theme_bw()  



MG_Genus_top20=as.matrix(read.table("IGERT_bubble7.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it
TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:44)
M.col=c(rep("yellow",17),rep("grey",15),rep("darkgreen",2),rep("lightgreen",2),rep("brown",4),rep("red",2),rep("pink",2))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) + #uses the same colors for projects throughout workflow
  labs(x="", y="", col="",size="") + #axis labels
  theme_bw() + #table aesthetics 
  theme(axis.text.x = element_text(face="plain", color="Black", size=10, angle=90), #tickmark aesthetics 
        axis.text.y = element_text(face="plain", color="Black", size=10, angle=0))

MG_Genus_top20=as.matrix(read.table("IGERT_bubble7.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it
TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:44)
M.col=c(rep("yellow",17),rep("grey",15),rep("darkgreen",2),rep("lightgreen",2),rep("brown",4),rep("red",2),rep("pink",2))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) +
theme_bw()  



phyla.mds <- metaMDS(SRBs_nmds[,1:17], distance = "bray",trace = FALSE,trymax=100)
phyla.mds
plot(phyla.mds, type = "t", display = "sites")
plot(phyla.mds, type = "n", display = "sites")
plot(phyla.mds, type = "p", display = "sites")
with(SRBs_nmds,ordiellipse(phyla.mds,studyhost,kind="se",conf=0.95,label=TRUE,col=c(rep("#95A16E"),rep("#555C41"),rep("#B16645"),rep("#D1A460"))))
abline(v=0,lty=2)
abline(h=0,lty=2)
points(phyla.mds,display="sites",pch=c(rep(16,24)),col=c(rep("#95A16E",8),rep("#555C41",6),rep("#B16645",5),rep("#D1A460",5)))



MG_Genus_top20=as.matrix(read.table("moore_bubble3.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it
TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:24)
M.col=c(rep("#95A16E",8),rep("#555C41",6),rep("#B16645",5),rep("#D1A460",5))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) + #uses the same colors for projects throughout workflow
  labs(x="Culture Conditions", y="", col="",size="") + #axis labels
  theme_bw() + #table aesthetics 
  theme(axis.text.x = element_text(face="plain", color="Black", size=10, angle=90), #tickmark aesthetics 
        axis.text.y = element_text(face="plain", color="Black", size=10, angle=0))




adonis2(moore_nmds3[,1:21] ~ studyhost*study, data=moore_nmds3, permutations=999,method="bray")
pairwise.perm.manova(dist(moore_nmds3[,1:38],"euclidian"),moore_nmds3$studyhost,nperm=999)


MG_Genus_top20=as.matrix(read.table("test5.txt")) #turning it into a matrix is crucial here, otherwise melt() does not recognize it

TV=MG_Genus_top20 #assing TV from your above defined table
NR=nrow(TV) #number of rows in table 
M.projects=c(1:33)
M.col=c(rep("yellow",16),rep("grey",4),rep("red",4),rep("gold",6),rep("brown",3))
TV.group=c(rep(M.projects,NR)) #group file fits to concatenated sample column, if the order of Groups (colnames) is multiplied by NR
TV.group=sort(TV.group, decreasing=F) #sorts new group file!!!!
TV[TV==0] <- NA #turns zeros into NAs
TV.levels=rownames(TV) #Level IDs used later
TVX <- melt(TV, id.vars = "X", variable.name="Sample", value.name = "Size") #turns multiple "Sample" columns into one concatenated "Sample" column
colnames(TVX)=c("Clade","Sample","Size")
ggplot(TVX, aes(x = Sample, y = factor(TVX$Clade, levels=rev(TV.levels)), col=factor(TV.group))) + #plots samples vs Clades using colors according to group file
  geom_point(aes(size = Size)) + #adjust size of circles ad lib, for visibility reasons
  scale_colour_manual(values=M.col) + #uses the same colors for projects throughout workflow
  labs(x="", y="", col="",size="Abundance") + #axis labels
  theme_bw() + #table aesthetics 
  theme(axis.text.x = element_text(face="plain", color="Black", size=10, angle=90), #tickmark aesthetics 
        axis.text.y = element_text(face="plain", color="Black", size=10, angle=0))


