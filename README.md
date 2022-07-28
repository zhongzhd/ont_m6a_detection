# ont_m6a_detection
## dependence
/appveyor/build/:user/:repo
|software/package|version|
|------|------|
|Guppy|5.0.7|
|Minimap2|2.17|
|samtools|1.6|
|Tombo|1.5.1|
|MINES|-|
|Nanom6A|2.0|
|m6Anet|1.0|
|Nanomcompore|1.0.0|
|Xpore|2.0|
|DiffErr|0.2|
|DRUMMER|-|
|ELIGOS|2.0.1|
|Epinano|1.2.0|

## 1 preprocess:
basecalling and alignment

## 2 m6A detection:
These ONT tools were executed with appropriate parameters to output results of all sites in RRACH motifs (coverage >= 5).

## 3 postprocess:
The results of each tool were organized into a standard format.

transcript pos score coverage id motif

ENSMUST00000000001.4	63	0.478300	27	ENSMUST00000000001.4|63	AGACC

## 4 coordinate_transformation：
The transcriptome coordinates were converted to the genomic coordinates. Sites derived from multiple transcriptomic coordinates but aligned to the same genomic coordinate were merged as following: for Tombo/Tombo_com, MINES, Nanom6A, m6Anet and Epinano/Epinano_delta, the scores (fraction-modified/probability-modified) were weighted averaging according coverage; for Nanocompore, Xpore, DiffErr, DRUMMER and ELIGOS, the best scores (p-value/z score) were selected as representative.

## 5
