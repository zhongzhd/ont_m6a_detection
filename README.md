# ONT m6a detection
## dependence
![](https://img.shields.io/badge/software%2Fpackage-version-blue)  
![](https://img.shields.io/badge/Guppy-v5.0.7-green)
![](https://img.shields.io/badge/Minimap2-v2.17-green)
![](https://img.shields.io/badge/samtools-v1.6-green)  
![](https://img.shields.io/badge/Tombo-v1.5.1-orange)
![](https://img.shields.io/badge/MINES-v0.0-orange)
![](https://img.shields.io/badge/Nanom6A-v2.0-orange)
![](https://img.shields.io/badge/m6Anet-v1.0-orange)
![](https://img.shields.io/badge/Nanocompore-v1.0.0-orange)
![](https://img.shields.io/badge/Xpore-v2.0-orange)  
![](https://img.shields.io/badge/DiffErr-v0.2-green)
![](https://img.shields.io/badge/DRUMMER-v0.0-green)
![](https://img.shields.io/badge/ELIGOS-v2.0.1-green)
![](https://img.shields.io/badge/Epinano-v1.2.0-green)  

## 1 preprocess:
basecalling and alignment

## 2 m6A detection:
These ONT tools were executed with appropriate parameters to output results of all sites in RRACH motifs (coverage >= 5).

## 3 postprocess:
The results of each tool were organized into a standard format:  
transcript pos score coverage id motif  
ENSMUST00000000001.4	63	0.478300	27	ENSMUST00000000001.4|63	AGACC

## 4 coordinate_transformation：
The transcriptome coordinates were converted to the genomic coordinates. Sites derived from multiple transcriptomic coordinates but aligned to the same genomic coordinate were merged as following: for Tombo/Tombo_com, MINES, Nanom6A, m6Anet and Epinano/Epinano_delta, the scores (fraction-modified/probability-modified) were weighted averaging according coverage; for Nanocompore, Xpore, DiffErr, DRUMMER and ELIGOS, the best scores (p-value/z score) were selected as representative.

## 5 continuous_evaluation_metrics:
plot ROC and PR curves

## 6 optimal_cut-off_selection:
The optimal cut-off of each tool for m6A detection was determined by varing cut-offs and calculated F1 scores.
