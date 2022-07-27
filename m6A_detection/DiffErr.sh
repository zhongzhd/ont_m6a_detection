#!/bin/bash

ref=path_to_reference_transcriptome
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

differr -a $ko_bam \
-b $wt_bam \
-r $ref \https://github.com/zhongzhd/ont_m6a_detection
-o differr.bed \
-f 2 \
--median-expr-threshold 0 \
--min-expr-threshold 0 \
-p 16
