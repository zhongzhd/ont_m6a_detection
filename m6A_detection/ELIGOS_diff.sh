#!/bin/bash

#dependencies：
#python 3.6
#pysam 0.13
#pandas 0.23.4
#pybedtools 0.8.0
#bedtools 2.25
#rpy2 2.8.5
#r-base 3.4.1
#tqdm 4.40.2
#numpy 1.11.3

ref=path_to_reference_transcriptome
bed=path_to_detection_region_bed
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

#bed format
#transcript 1 length * * *
#ENSMUST00000193812.1	1	1070	ENSMUST00000193812.1	0	+

eligos2 pair_diff_mod -tbam $wt_bam \
-cbam $ko_bam \
-reg $bed \
-ref $ref \
-p com \
-o com \
--sub_bam_dir com/tmp \
--max_depth 5000000 \
--min_depth 5 \
--esb 0 \
--oddR 1 \
--pval 1 \
-t 16
