## Create graphs documenting the number of contigs generated from each sample after assembly.
## N50, L50, and contig values generated from metaQUAST program
library(dplyr)
library(ggplot2)
library(ggpubr)
library(wesanderson)
library(readr)

#Import metadata
metadata <- read_csv("/local/workdir/myb7/data/MuskegonLake/metadata.csv")


#Create data frame containing N50, L50, and contig placeholder values
Sample <- as.factor(c(91614:91629))
N50_score <- rep(NA, 16)
L50_score <- rep(NA, 16)
Fraction <- metadata$fraction
Lakesite <- metadata$lakesite
Month <- as.factor(metadata$month)
Year <- as.factor(metadata$year)
Date <- as.factor(metadata$date)
Contigs <- rep(NA, 16)

#Extract N50, L50, and Contig values from file "report.tsv" in folder "combined_reference
#in metaQUAST output directory for each sample. Add values to dataframe.
N50_L50_df <- data.frame(Sample, N50_score, L50_score, Fraction, Lakesite, Month, Year, Date)
for(i in 91614:91629){
  setwd(paste("/local/workdir/myb7/data/MuskegonLake/quast_results/s",i,"/combined_reference",sep=""))
  df_assembly <- read_tsv("report.tsv", col_names = TRUE)
  N50_L50_df$N50_score[[i-91613]] <- df_assembly$final.contigs[17]
  N50_L50_df$L50_score[[i-91613]] <- df_assembly$final.contigs[20]
  N50_L50_df$Contigs[[i-91613]] <- df_assembly$final.contigs[2]
  
}

#Convert extracted values to numbers
N50_L50_df$N50_score <- as.numeric(N50_L50_df$N50_score)
N50_L50_df$L50_score <- as.numeric(N50_L50_df$L50_score)
N50_L50_df$Contigs <- as.numeric(N50_L50_df$Contigs)


# Box plots of N50 (n), L50 (l), and contig (c) values separated by type. 
# Includes Wilcoxon paired-end test
n <- ggplot(data = N50_L50_df, mapping = aes(x = Fraction, y = N50_score)) + 
  geom_boxplot(aes(fill = Fraction), show.legend = FALSE) + geom_point(size = 3) + 
  xlab("Fraction") + ylab("N50 Score") + 
  stat_compare_means(method = "wilcox.test", paired = TRUE, label.x = 1, label.y = 6000) + 
  stat_summary(shape = 8, fun = "mean", color = "red") + theme_gray(base_size = 22) + 
  scale_fill_manual(values = wes_palette(name = "GrandBudapest2"))

l <- ggplot(data = N50_L50_df, mapping = aes(x = Fraction, y = L50_score)) + 
  geom_boxplot(aes(fill = Fraction), show.legend = FALSE) + geom_point(size = 3) + 
  xlab("Fraction") + ylab("L50 Score") + 
  stat_compare_means(method = "wilcox.test", paired = TRUE, label.x = 1, label.y = 25000) + 
  stat_summary(shape = 8, fun = "mean", color = "red") + theme_gray(base_size = 22) + 
  scale_fill_manual(values = wes_palette(name = "GrandBudapest2"))

c <- ggplot(data = N50_L50_df, mapping = aes(x = Fraction, y = Contigs)) + 
  geom_boxplot(aes(fill = Fraction), show.legend = FALSE) + geom_point(size = 3) + 
  xlab("Fraction") + ylab("Total Number of Contigs") + 
  stat_compare_means(method = "wilcox.test", paired = TRUE, label.x = 1, label.y = 100000) + 
  stat_summary(shape = 8, fun = "mean", color = "red") + theme_gray(base_size = 15) + 
  scale_fill_manual(values = wes_palette(name = "GrandBudapest2"))

c <- ggplot(data = N50_L50_df, mapping = aes(x = Sample, y = Contigs, fill = Fraction)) +
  geom_bar(stat = "identity") +
  labs(
    x = "Sample",
    y = "Total Number of Contigs"
  ) + theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = wes_palette(name = "GrandBudapest2"))

n
l
c

#Save plots as PNG files
ggsave(filename = "/workdir/myb7/figures/N50.png", plot = n, width = 12, height = 10, dpi = 300, units = "cm")
ggsave(filename = "/workdir/myb7/figures/L50.png", plot = l, width = 12, height = 10, dpi = 300, units = "cm")
ggsave(filename = "/workdir/myb7/figures/contigs.png", plot = c, width = 12, height = 10, dpi = 300, units = "cm")

