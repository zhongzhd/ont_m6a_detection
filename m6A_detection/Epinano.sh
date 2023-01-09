#!/bin/bash

#dependencies：
#java openjdk	1.8.0
#minimap2	2.14-r886
#samtools	0.1.19
#sam2tsv	a779a30d6af485d9cd669aa3752465132cf21eec
#python	3.6.7
#h5py	2.8.0
#numpy	1.15.4
#pandas	0.23.4
#scikit-learn	0.20.2
#nanopolish	0.12.4
#dask	2.5.2
#biopython	1.76
#pysam	0.15.3+
#R	3.6.0 (2019-04-26)
#R packages:	
#forcats	0.4.0
#optparse	1.6.6
#stringr	1.4.0
#dplyr	1.0.1
#purrr	0.3.2
#readr	1.3.1
#tidyr	0.8.3
#tibble	3.0.3
#tidyverse	1.2.1
#ggrepel	0.8.1
#car	3.0-3
#ggplot2	3.1.1
#reshape2	1.4.3
#outliers	0.14

Epinano=path_to_Epinano_software
ref=path_to_reference_transcriptome
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

#extract features
python $Epinano/Epinano_Variants.py -R $ref \
-b $wt_bam \
-s $Epinano/misc/sam2tsv.jar \
-n 16 \
-T t

#slide features
python $Epinano/misc/Slide_Variants.py wt.plus_strand.per.site.csv 5

#predict modifications
python $Epinano/Epinano_Predict.py \
--model $Epinano/models/rrach.q3.mis3.del3.linear.dump \
--predict wt.plus_strand.per.site.5mer.csv \
--columns 8,13,23 \
--out_prefix wt

#apply the same analysis in ko
