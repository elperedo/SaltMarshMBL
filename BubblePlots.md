#set your working directory by either setwd() 
#or manually in R studio--> Session --> Set Working Directory --> Choose Directory
#upload your data to R - exchange "Your_csv_file.csv" with the name of your csv file

library(ggplot2)
library(reshape2)

#convert data frame from a "wide" format to a "long" format
pc = read.table("bubbleplot_CPM.txt", header = TRUE)
pcm = melt(pc, id = c("MAG"))

colours = c(rep("#95A16E",8),rep("#555C41",6),rep("#B16645",5),rep("#D1A460",5))

pcm$MAG <- factor(pcm$MAG,levels=unique(pcm$MAG))

xx = ggplot(pcm, aes(x = MAG, y = variable)) + 
  geom_point(aes(size = value, fill = variable), alpha = 0.75, shape = 21) + 
  scale_size_continuous(limits = c(2, 300), range = c(1,10), breaks = c(2,10,50,75,275)) + 
  labs( x= "", y = "", size = "Relative Abundance (%)", fill = "")  + 
  theme(legend.key=element_blank(), 
  axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
  axis.text.y = element_text(colour = "black", face = "bold", size = 11), 
  legend.text = element_text(size = 10, face ="bold", colour ="black"), 
  legend.title = element_text(size = 12, face = "bold"), 
  panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
  legend.position = "right") +  
  scale_fill_manual(values = colours, guide = FALSE) + 
  scale_y_discrete(limits = rev(levels(pcm$variable))) 

xx

ggsave(file="bubble_CPM.pdf", device = "pdf")


### with groups

pc = read.table("bubbleplot_CPM.txt", header = TRUE)
pcm = melt(pc, id = c("MAG", "Assembly"))

pcm$MAG <- factor(pcm$MAG,levels=unique(pcm$MAG))
xx = ggplot(pcm, aes(x = MAG, y = variable)) + 
      geom_point(aes(size = value, fill = Assembly), alpha = 0.75, shape = 21) + 
       scale_size_continuous(limits = c(2,300), range = c(1,10), breaks = c(2,25,50,100)) + 
       labs( x= "", y = "", size = "CPM", fill = "Assembly")  + 
       theme(legend.key=element_blank(), 
       axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
       axis.text.y = element_text(colour = "black", face = "bold", size = 9), 
       legend.text = element_text(size = 10, face ="bold", colour ="black"), 
       legend.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), 
       panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
       legend.position = "right", panel.grid.major.y = element_line(colour = "grey95")) +  
       scale_fill_manual(values = c("#95A16E", "#555C41", "#B16645","#D1A460"), guide = guide_legend(override.aes = list(size=5))) + 
       scale_y_discrete(limits = rev(levels(pcm$variable))) 
xx

ggsave(file="bubble_CPM.pdf", device = "pdf")


pc = read.table("bubbleplot_100.txt", header = TRUE)
pcm = melt(pc, id = c("MAG", "Assembly"))

pcm$MAG <- factor(pcm$MAG,levels=unique(pcm$MAG))
xx = ggplot(pcm, aes(x = MAG, y = variable)) + 
      geom_point(aes(size = value, fill = Assembly), alpha = 0.75, shape = 21) + 
       scale_size_continuous(limits = c(2,100), range = c(1,10), breaks = c(2,25,50,100)) + 
       labs( x= "", y = "", size = "CPM", fill = "Assembly")  + 
       theme(legend.key=element_blank(), 
       axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
       axis.text.y = element_text(colour = "black", face = "bold", size = 9), 
       legend.text = element_text(size = 10, face ="bold", colour ="black"), 
       legend.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), 
       panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
       legend.position = "right", panel.grid.major.y = element_line(colour = "grey95")) +  
       scale_fill_manual(values = c("#95A16E", "#555C41", "#B16645","#D1A460"), guide = guide_legend(override.aes = list(size=5))) + 
       scale_y_discrete(limits = rev(levels(pcm$variable))) 
xx

ggsave(file="bubble_CPM100.pdf", device = "pdf")


pc = read.table("bubbleplot_perc.txt", header = TRUE)
pcm = melt(pc, id = c("MAG", "Assembly"))

pcm$MAG <- factor(pcm$MAG,levels=unique(pcm$MAG))
xx = ggplot(pcm, aes(x = MAG, y = variable)) + 
      geom_point(aes(size = value, fill = Assembly), alpha = 0.75, shape = 21) + 
       scale_size_continuous(limits = c(0.002,0.7), range = c(1,10), breaks = c(0.01,0.1,0.3,0.7)) + 
       labs( x= "", y = "", size = "CPM", fill = "Assembly")  + 
       theme(legend.key=element_blank(), 
       axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
       axis.text.y = element_text(colour = "black", face = "bold", size = 9), 
       legend.text = element_text(size = 10, face ="bold", colour ="black"), 
       legend.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), 
       panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
       legend.position = "right", panel.grid.major.y = element_line(colour = "grey95")) +  
       scale_fill_manual(values = c("#95A16E", "#555C41", "#B16645","#D1A460"), guide = guide_legend(override.aes = list(size=5))) + 
       scale_y_discrete(limits = rev(levels(pcm$variable))) 
xx

ggsave(file="bubble_perc.pdf", device = "pdf")




pc = read.table("bubbleplot_comple.txt", header = TRUE)
pcm = melt(pc, id = c("MAG", "Assembly"))

pcm$MAG <- factor(pcm$MAG,levels=unique(pcm$MAG))
xx = ggplot(pcm, aes(x = MAG, y = variable)) + 
      geom_point(aes(size = value, fill = Assembly), alpha = 0.75, shape = 21) + 
       scale_size_continuous(limits = c(20,100), range = c(1,10), breaks = c(20,50,70,100)) + 
       labs( x= "", y = "", size = "CPM", fill = "Assembly")  + 
       theme(legend.key=element_blank(), 
       axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
       axis.text.y = element_text(colour = "black", face = "bold", size = 9), 
       legend.text = element_text(size = 10, face ="bold", colour ="black"), 
       legend.title = element_text(size = 11, face = "bold"), panel.background = element_blank(), 
       panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
       legend.position = "right", panel.grid.major.y = element_line(colour = "grey95")) +  
       scale_fill_manual(values = c("#95A16E", "#555C41", "#B16645","#D1A460"), guide = guide_legend(override.aes = list(size=5))) + 
       scale_y_discrete(limits = rev(levels(pcm$variable))) 
xx


ggsave(file="bubble_comple.pdf", device = "pdf")






