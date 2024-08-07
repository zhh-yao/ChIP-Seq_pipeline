

# Donut charts (Before this step, peakAnnoList_Wt_NO and peakAnnoList_unt_PDS should be prepared)


## import required packages
install.packages("ggplot2")
library(ggplot2)
library(dplyr)


## draw and export donut charts
projectDir <- "/path/to/R-loop/project"
setwd(projectDir)
subDir <- "visualize/annotationDonut" # donut charts will be saved here
if (!file.exists(subDir)){
  dir.create(subDir)
}
setwd(file.path(projectDir, subDir))

### Wt and NO in Experiment A
subDir <- "ExpA_Wt_NO"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### donut chart of Wt unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$A_Wt_unique_peaks@annoStat)
annoStat$`Wt unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt unique` = factor(x = `Wt unique`, levels = `Wt unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$A_NO_unique_peaks@annoStat)
annoStat$`NO unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO unique` = factor(x = `NO unique`, levels = `NO unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt-PDS unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$`A_Wt-PDS_unique_peaks`@annoStat)
annoStat$`Wt-PDS unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt-PDS unique` = factor(x = `Wt-PDS unique`, levels = `Wt-PDS unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt-PDS unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt-PDS_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt-PDS_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO-PDS unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$`A_NO-PDS_unique_peaks`@annoStat)
annoStat$`NO-PDS unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO-PDS unique` = factor(x = `NO-PDS unique`, levels = `NO-PDS unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO-PDS unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO-PDS_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO-PDS_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt and NO shared peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$A_Wt_NO_shared_peaks@annoStat)
annoStat$`Wt & NO share` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt & NO share` = factor(x = `Wt & NO share`, levels = `Wt & NO share`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt & NO share`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_NO_shared_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_NO_shared_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt-PDS and NO-PDS shared peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_Wt_NO$`A_Wt-PDS_NO-PDS_shared_peaks`@annoStat)
annoStat$`Wt-PDS & NO-PDS share` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt-PDS & NO-PDS share` = factor(x = `Wt-PDS & NO-PDS share`, levels = `Wt-PDS & NO-PDS share`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt-PDS & NO-PDS share`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt-PDS_NO-PDS_shared_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt-PDS_NO-PDS_shared_annot.jpg"), width=5, height=3, dpi=300)

### Wt and NO in Experiment B
subDir <- "ExpB_Wt_NO"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### donut chart of Wt unique peaks in Experiment B
annoStat <- as.data.frame(peakAnnoList_Wt_NO$B_Wt_unique_peaks@annoStat)
annoStat$`Wt unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt unique` = factor(x = `Wt unique`, levels = `Wt unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d(option = "rocket") +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO unique peaks in Experiment B
annoStat <- as.data.frame(peakAnnoList_Wt_NO$B_NO_unique_peaks@annoStat)
annoStat$`NO unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO unique` = factor(x = `NO unique`, levels = `NO unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d(option = "rocket") +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt and NO shared peaks in Experiment B
annoStat <- as.data.frame(peakAnnoList_Wt_NO$`B_Wt_NO_shared_peaks`@annoStat)
annoStat$`Wt & NO share` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt & NO share` = factor(x = `Wt & NO share`, levels = `Wt & NO share`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt & NO share`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d(option = "rocket") +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_NO_shared_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_NO_shared_annot.jpg"), width=5, height=3, dpi=300)

### untreated and PDS-treated in Experiment A
subDir <- "ExpA_unt_PDS"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### donut chart of Wt unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$A_Wt_unique_peaks@annoStat)
annoStat$`Wt unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt unique` = factor(x = `Wt unique`, levels = `Wt unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt-PDS unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$`A_Wt-PDS_unique_peaks`@annoStat)
annoStat$`Wt-PDS unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt-PDS unique` = factor(x = `Wt-PDS unique`, levels = `Wt-PDS unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt-PDS unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt-PDS_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt-PDS_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of Wt and Wt-PDS shared peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$`A_Wt_Wt-PDS_shared_peaks`@annoStat)
annoStat$`Wt & Wt-PDS share` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `Wt & Wt-PDS share` = factor(x = `Wt & Wt-PDS share`, levels = `Wt & Wt-PDS share`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`Wt & Wt-PDS share`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "Wt_Wt-PDS_shared_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "Wt_Wt-PDS_shared_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$A_NO_unique_peaks@annoStat)
annoStat$`NO unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO unique` = factor(x = `NO unique`, levels = `NO unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO-PDS unique peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$`A_NO-PDS_unique_peaks`@annoStat)
annoStat$`NO-PDS unique` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO-PDS unique` = factor(x = `NO-PDS unique`, levels = `NO-PDS unique`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO-PDS unique`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO-PDS_unique_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO-PDS_unique_annot.jpg"), width=5, height=3, dpi=300)
#### donut chart of NO and NO-PDS shared peaks in Experiment A
annoStat <- as.data.frame(peakAnnoList_unt_PDS$`A_NO_NO-PDS_shared_peaks`@annoStat)
annoStat$`NO & NO-PDS share` <- paste0(annoStat$Feature, " (", round(annoStat$Frequency, digits=2), "%)")
annoStat %>%
  mutate(Feature = factor(x = Feature, levels = Feature),
         `NO & NO-PDS share` = factor(x = `NO & NO-PDS share`, levels = `NO & NO-PDS share`)) %>%
  ggplot(mapping = aes(x=2, y=Frequency, fill=`NO & NO-PDS share`))+
  geom_col(width=1) +
  xlim(0.5, 2.5) +
  scale_fill_viridis_d() +
  coord_polar("y") +
  theme_void() +
  theme(plot.margin = margin(-1, 0.5, -1, 0, "cm")) # margin(t, r, b, l)
ggsave(file.path(subDir, "NO_NO-PDS_shared_annot.pdf"), width=5, height=3)
ggsave(file.path(subDir, "NO_NO-PDS_shared_annot.jpg"), width=5, height=3, dpi=300)





