## Create graph documenting the number of significant homologous sequences in each sample against T4SS profile-HMM
## Profile was created from seed alignment of PFam family T4SS-DNA_transf (PF02534)

library(ggplot2)
library(ggpubr)
library(wesanderson)
library(readr)

# Create HMMER dataframe
metadata <- read_csv("/local/workdir/myb7/data/MuskegonLake/metadata.csv")
Fraction <- metadata$fraction
Sample <- as.factor(c(91614:91629))
Name <- metadata$names_nofracrep
TraC_Sequence_Hits <- c(4, 0, 2, 1, 1, 3, 1, 0, 0, 0, 0, 0, 0, 3, 1, 1) 
TrbI_Sequence_Hits <- c(1,0,1,0,1,0,1,0,1,0,0,1,1,2,1,1)
T4SS_Sequence_Hits <- c(15,5,8,1,9,2,8,1,4,2,4,4,3,16,3,9)
hmmer_df <- data.frame(Sample,Fraction, T4SS_Sequence_Hits, Name)

# Plot boxplot based on profile
T4SS <- ggplot(data = hmmer_df, mapping = aes(x = Fraction, y = T4SS_Sequence_Hits)) + 
  geom_boxplot(aes(fill = Fraction), show.legend = FALSE) + 
  geom_point(aes(group=Name), size = 3, position = position_dodge(0.2)) +
  geom_line(aes(group=Name), color = "darkslategray", alpha = 0.5, position = position_dodge(0.2)) + 
  xlab("Fraction") + ylab("Number of Hits on\nType 4 Secretion System Proteins") +
  stat_compare_means(method = "wilcox.test", paired = TRUE, label.x = 1, label.y = 16) +
  stat_summary(shape = 8, fun = "mean", color = "red") + theme_gray(base_size = 12) +
  scale_fill_manual(values = wes_palette(name = "GrandBudapest2")) + 
  theme(legend.position = "none")

T4SS

# Save figure
ggsave(filename = "/workdir/myb7/figures/T4SS.png", plot = T4SS, width = 12, height = 10, dpi = 300, units = "cm")
