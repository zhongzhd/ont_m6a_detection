#!/bin/bash

ref=path_to_reference_transcriptome
bed=path_to_detection_region_bed
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file
model=path_to_eligos_model

#bed format
#transcript 1 length * * *
#ENSMUST00000193812.1	1	1070	ENSMUST00000193812.1	0	+

eligos2 rna_mod -i $wt_bam \
-reg $bed \
-ref $ref \
-m $model \
-p wt \
-o wt \
--sub_bam_dir wt/tmp \
--max_depth 2000000 \
--min_depth 5 \
--esb 0 \
--oddR 1 \
--pval 1 \
-t 16

#apply the same analysis in ko
