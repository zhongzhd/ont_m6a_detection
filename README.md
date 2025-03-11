## Note: We have developed an extremely accurate method capable of detecting m6A at the single-molecule level. For details, see https://www.biorxiv.org/content/10.1101/2023.11.16.567334v1. (https://github.com/xieyy46/SingleMod-v1)
# ONT m6a detection
## dependence
![](https://img.shields.io/badge/software-version-blue)  
[![](https://img.shields.io/badge/Guppy-v5.0.7-green)](https://community.nanoporetech.com/downloads)
[![](https://img.shields.io/badge/Minimap2-v2.17-green)](https://github.com/lh3/minimap2)
[![](https://img.shields.io/badge/samtools-v1.6-green)](https://github.com/samtools/samtools)  
[![](https://img.shields.io/badge/Tombo-v1.5.1-orange)](https://github.com/nanoporetech/tombo)
[![](https://img.shields.io/badge/MINES-v0.0-orange)](https://github.com/YeoLab/MINES.git)
[![](https://img.shields.io/badge/Nanom6A-v2.0-orange)](https://github.com/gaoyubang/nanom6A)
[![](https://img.shields.io/badge/m6Anet-v1.0-orange)](https://github.com/GoekeLab/m6anet)
[![](https://img.shields.io/badge/Nanocompore-v1.0.0-orange)](https://github.com/tleonardi/nanocompore_paper_analyses)
[![](https://img.shields.io/badge/xPore-v2.0-orange)](https://github.com/GoekeLab/xpore)  
[![](https://img.shields.io/badge/DiffErr-v0.2-blue)](https://github.com/bartongroup/differr_nanopore_DRS)
[![](https://img.shields.io/badge/DRUMMER-v0.0-blue)](https://github.com/DepledgeLab/DRUMMER/)
[![](https://img.shields.io/badge/ELIGOS-v2.0.1-blue)](https://gitlab.com/piroonj/eligos2)
[![](https://img.shields.io/badge/Epinano-v1.2.0-blue)](https://github.com/novoalab/EpiNano)

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
