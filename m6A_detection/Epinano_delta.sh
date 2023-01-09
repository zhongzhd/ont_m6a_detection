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
epinano=path_to_Epinano_results

#make delta features
python $Epinano/misc/Epinano_make_delta.py $epinano/wt.plus_strand.per.site.5mer.csv \
$epinano/ko.plus_strand.per.site.5mer.csv \
5 5 > wt_ko_delta.5mer.csv

#predict modifications
python $Epinano/Epinano_Predict.py \
--model $Epinano/models/rrach.deltaQ3.deltaMis3.deltaDel3.linear.dump \
--predict wt_ko_delta.5mer.csv \
--columns 7,12,22 \
--out_prefix com
