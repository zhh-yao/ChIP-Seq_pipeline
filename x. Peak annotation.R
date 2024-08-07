
# Annotation using ChIPseeker


## import required packages
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ChIPseeker")
library(ChIPseeker)
BiocManager::install("TxDb.Hsapiens.UCSC.hg38.knownGene")
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
install.packages("devtools")
devtools::install_github("stephenturner/annotables")
library(annotables)
library(dplyr)


## read peaks in bed format
projectDir <- "/path/to/R-loop/project"
subDir <- "peakCalling/peakInfo" # peak files should be deposited here
setwd(file.path(projectDir, subDir))
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene # GRCh38 reference

### peaks compared between Wt and NO
diffPeak_Wt_NO <- list.files("diffPeak_Wt_NO", pattern= ".narrowPeak", full.names=T)
diffPeak_Wt_NO <- as.list(diffPeak_Wt_NO)
names(diffPeak_Wt_NO) <- c("A_Wt_NO_shared_peaks", "A_Wt_unique_peaks", "B_NO_unique_peaks", "A_NO_unique_peaks", "A_Wt-PDS_NO-PDS_shared_peaks", 
                           "A_Wt-PDS_unique_peaks", "A_NO-PDS_unique_peaks", "B_Wt_NO_shared_peaks", "B_Wt_unique_peaks")
peakAnnoList_Wt_NO <- lapply(diffPeak_Wt_NO, annotatePeak, TxDb=txdb, tssRegion=c(-1000, 1000), verbose=FALSE)

### peaks compared between untreated and PDS
diffPeak_unt_PDS <- list.files("diffPeak_unt_PDS", pattern= ".narrowPeak", full.names=T)
diffPeak_unt_PDS <- as.list(diffPeak_unt_PDS)
names(diffPeak_unt_PDS) <- c("A_Wt_Wt-PDS_shared_peaks", "A_Wt_unique_peaks", "A_NO_NO-PDS_shared_peaks", 
                             "A_NO_unique_peaks", "A_Wt-PDS_unique_peaks", "A_NO-PDS_unique_peaks")
peakAnnoList_unt_PDS <- lapply(diffPeak_unt_PDS, annotatePeak, TxDb=txdb, tssRegion=c(-1000, 1000), verbose=FALSE)


## Writing annotations to txt file
setwd(projectDir)
subDir <- "peakCalling/annotation" # annotation files will be deposited here
if (file.exists(subDir)){
  setwd(file.path(projectDir, subDir))
} else {
  dir.create(file.path(projectDir, subDir))
  setwd(file.path(projectDir, subDir))
}

### Wt and NO in Experiment A
subDir <- "ExpA_Wt_NO"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### annotate unique peaks of Wt in Experiment A
A_Wt_unique_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$A_Wt_unique_peaks@anno)
entrezids <- unique(A_Wt_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(A_Wt_unique_peaks_annot$geneId, entrez2gene$entrez)
A_Wt_unique_peaks_annot <- cbind(A_Wt_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], A_Wt_unique_peaks_annot[,20:21])
write.table(A_Wt_unique_peaks_annot, file=file.path(subDir, 'Wt_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of NO in Experiment A
A_NO_unique_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$A_NO_unique_peaks@anno)
entrezids <- unique(A_NO_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(A_NO_unique_peaks_annot$geneId, entrez2gene$entrez)
A_NO_unique_peaks_annot <- cbind(A_NO_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], A_NO_unique_peaks_annot[,20:21])
write.table(A_NO_unique_peaks_annot, file=file.path(subDir, 'NO_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate shared peaks between Wt and NO in Experiment A
A_Wt_NO_shared_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$A_Wt_NO_shared_peaks@anno)
entrezids <- unique(A_Wt_NO_shared_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(A_Wt_NO_shared_peaks_annot$geneId, entrez2gene$entrez)
A_Wt_NO_shared_peaks_annot <- cbind(A_Wt_NO_shared_peaks_annot[,1:30], geneSymbol=entrez2gene$symbol[m], A_Wt_NO_shared_peaks_annot[,31:32])
write.table(A_Wt_NO_shared_peaks_annot, file=file.path(subDir, 'Wt_NO_shared_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of Wt-PDS in Experiment A
`A_Wt-PDS_unique_peaks_annot` <- as.data.frame(peakAnnoList_Wt_NO$`A_Wt-PDS_unique_peaks`@anno)
entrezids <- unique(`A_Wt-PDS_unique_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_Wt-PDS_unique_peaks_annot`$geneId, entrez2gene$entrez)
`A_Wt-PDS_unique_peaks_annot` <- cbind(`A_Wt-PDS_unique_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_Wt-PDS_unique_peaks_annot`[,20:21])
write.table(`A_Wt-PDS_unique_peaks_annot`, file=file.path(subDir, 'Wt-PDS_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of NO-PDS in Experiment A
`A_NO-PDS_unique_peaks_annot` <- as.data.frame(peakAnnoList_Wt_NO$`A_NO-PDS_unique_peaks`@anno)
entrezids <- unique(`A_NO-PDS_unique_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_NO-PDS_unique_peaks_annot`$geneId, entrez2gene$entrez)
`A_NO-PDS_unique_peaks_annot` <- cbind(`A_NO-PDS_unique_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_NO-PDS_unique_peaks_annot`[,20:21])
write.table(`A_NO-PDS_unique_peaks_annot`, file=file.path(subDir, 'NO-PDS_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate shared peaks between Wt-PDS and NO-PDS in Experiment A
`A_Wt-PDS_NO-PDS_shared_peaks_annot` <- as.data.frame(peakAnnoList_Wt_NO$`A_Wt-PDS_NO-PDS_shared_peaks`@anno)
entrezids <- unique(`A_Wt-PDS_NO-PDS_shared_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_Wt-PDS_NO-PDS_shared_peaks_annot`$geneId, entrez2gene$entrez)
`A_Wt-PDS_NO-PDS_shared_peaks_annot` <- cbind(`A_Wt-PDS_NO-PDS_shared_peaks_annot`[,1:30], geneSymbol=entrez2gene$symbol[m], `A_Wt-PDS_NO-PDS_shared_peaks_annot`[,31:32])
write.table(`A_Wt-PDS_NO-PDS_shared_peaks_annot`, file=file.path(subDir, 'Wt-PDS_NO-PDS_shared_peaks_annot.txt'), sep="\t", quote=F, row.names=F)

### Wt and NO in Experiment B
subDir <- "ExpB_Wt_NO"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### annotate unique peaks of Wt in Experiment B
B_Wt_unique_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$B_Wt_unique_peaks@anno)
entrezids <- unique(B_Wt_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(B_Wt_unique_peaks_annot$geneId, entrez2gene$entrez)
B_Wt_unique_peaks_annot <- cbind(B_Wt_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], B_Wt_unique_peaks_annot[,20:21])
write.table(B_Wt_unique_peaks_annot, file=file.path(subDir, 'Wt_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of NO in Experiment B
B_NO_unique_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$B_NO_unique_peaks@anno)
entrezids <- unique(B_NO_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(B_NO_unique_peaks_annot$geneId, entrez2gene$entrez)
B_NO_unique_peaks_annot <- cbind(B_NO_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], B_NO_unique_peaks_annot[,20:21])
write.table(B_NO_unique_peaks_annot, file=file.path(subDir, 'NO_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate shared peaks between Wt and NO in Experiment B
B_Wt_NO_shared_peaks_annot <- as.data.frame(peakAnnoList_Wt_NO$B_Wt_NO_shared_peaks@anno)
entrezids <- unique(B_Wt_NO_shared_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(B_Wt_NO_shared_peaks_annot$geneId, entrez2gene$entrez)
B_Wt_NO_shared_peaks_annot <- cbind(B_Wt_NO_shared_peaks_annot[,1:30], geneSymbol=entrez2gene$symbol[m], B_Wt_NO_shared_peaks_annot[,31:32])
write.table(B_Wt_NO_shared_peaks_annot, file=file.path(subDir, 'Wt_NO_shared_peaks_annot.txt'), sep="\t", quote=F, row.names=F)

### untreated and PDS-treated in Experiment A
subDir <- "ExpA_unt_PDS"
if (!file.exists(subDir)){
  dir.create(subDir)
}
#### annotate unique peaks of Wt in Experiment A
A_Wt_unique_peaks_annot <- as.data.frame(peakAnnoList_unt_PDS$A_Wt_unique_peaks@anno)
entrezids <- unique(A_Wt_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(A_Wt_unique_peaks_annot$geneId, entrez2gene$entrez)
A_Wt_unique_peaks_annot <- cbind(A_Wt_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], A_Wt_unique_peaks_annot[,20:21])
write.table(A_Wt_unique_peaks_annot, file=file.path(subDir, 'Wt_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of Wt-PDS in Experiment A
`A_Wt-PDS_unique_peaks_annot` <- as.data.frame(peakAnnoList_unt_PDS$`A_Wt-PDS_unique_peaks`@anno)
entrezids <- unique(`A_Wt-PDS_unique_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_Wt-PDS_unique_peaks_annot`$geneId, entrez2gene$entrez)
`A_Wt-PDS_unique_peaks_annot` <- cbind(`A_Wt-PDS_unique_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_Wt-PDS_unique_peaks_annot`[,20:21])
write.table(`A_Wt-PDS_unique_peaks_annot`, file=file.path(subDir, 'Wt-PDS_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate shared peaks between Wt and Wt-PDS in Experiment A
`A_Wt_Wt-PDS_shared_peaks_annot` <- as.data.frame(peakAnnoList_unt_PDS$`A_Wt_Wt-PDS_shared_peaks`@anno)
entrezids <- unique(`A_Wt_Wt-PDS_shared_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_Wt_Wt-PDS_shared_peaks_annot`$geneId, entrez2gene$entrez)
`A_Wt_Wt-PDS_shared_peaks_annot` <- cbind(`A_Wt_Wt-PDS_shared_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_Wt_Wt-PDS_shared_peaks_annot`[,20:21])
write.table(`A_Wt_Wt-PDS_shared_peaks_annot`, file=file.path(subDir, 'Wt_Wt-PDS_shared_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of NO in Experiment A
A_NO_unique_peaks_annot <- as.data.frame(peakAnnoList_unt_PDS$A_NO_unique_peaks@anno)
entrezids <- unique(A_NO_unique_peaks_annot$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(A_NO_unique_peaks_annot$geneId, entrez2gene$entrez)
A_NO_unique_peaks_annot <- cbind(A_NO_unique_peaks_annot[,1:19], geneSymbol=entrez2gene$symbol[m], A_NO_unique_peaks_annot[,20:21])
write.table(A_NO_unique_peaks_annot, file=file.path(subDir, 'NO_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate unique peaks of NO-PDS in Experiment A
`A_NO-PDS_unique_peaks_annot` <- as.data.frame(peakAnnoList_unt_PDS$`A_NO-PDS_unique_peaks`@anno)
entrezids <- unique(`A_NO-PDS_unique_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_NO-PDS_unique_peaks_annot`$geneId, entrez2gene$entrez)
`A_NO-PDS_unique_peaks_annot` <- cbind(`A_NO-PDS_unique_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_NO-PDS_unique_peaks_annot`[,20:21])
write.table(`A_NO-PDS_unique_peaks_annot`, file=file.path(subDir, 'NO-PDS_unique_peaks_annot.txt'), sep="\t", quote=F, row.names=F)
#### annotate shared peaks between NO and NO-PDS in Experiment A
`A_NO_NO-PDS_shared_peaks_annot` <- as.data.frame(peakAnnoList_unt_PDS$`A_NO_NO-PDS_shared_peaks`@anno)
entrezids <- unique(`A_NO_NO-PDS_shared_peaks_annot`$geneId)
entrez2gene <- grch38 %>% 
  filter(entrez %in% entrezids) %>% 
  dplyr::select(entrez, symbol)
m <- match(`A_NO_NO-PDS_shared_peaks_annot`$geneId, entrez2gene$entrez)
`A_NO_NO-PDS_shared_peaks_annot` <- cbind(`A_NO_NO-PDS_shared_peaks_annot`[,1:19], geneSymbol=entrez2gene$symbol[m], `A_NO_NO-PDS_shared_peaks_annot`[,20:21])
write.table(`A_NO_NO-PDS_shared_peaks_annot`, file=file.path(subDir, 'NO_NO-PDS_shared_peaks_annot.txt'), sep="\t", quote=F, row.names=F)



