#!/bin/bash

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
