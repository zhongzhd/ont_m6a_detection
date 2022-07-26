#!/bin/bash

DRUMMER=path_to_DRUMMER_software
ref=path_to_reference_transcriptome
txt=path_to_transcript_list
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

#txt format
#transcript (coverage>0)
#ENSMUST00000000001.4

python DRUMMER.py -r $ref \
-l $txt \
-t $ko_bam \
-c $wt_bam \
-o com \
-m True \
-a isoform
