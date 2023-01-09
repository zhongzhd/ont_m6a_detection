#!/bin/bash

#dependencies:
#python 3.7.3
#joblib 0.13.2
#numpy 1.17.2
#pandas 0.24.2
#pyfaidx 0.5.5.2
#pyparsing 2.4.2
#python-dateutil 2.8.0
#pytz 2019.2
#pyyaml 5.1.2
#scikit-learn 0.21.3
#scipy 1.2.2
#seaborn 0.9.0
#tqdm 4.36.1

ref=path_to_reference_transcriptome
bed12=path_to_transcriptome_annotation
wt_fastq=path_to_fastq_file
ko_fastq=path_to_fastq_file
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

#bed12 format
#chr start end transcript * strand thickstart thickend * * blocksizes blockstarts
#chr1	3073252	3074322	ENSMUST00000193812.1	0	+	3074322	3074322	0	1	1070,	0,

#eventalign with samples
nanopolish eventalign --reads $wt_fastq \
--bam $wt_bam \
--genome $ref \
--samples \
--print-read-names \
--scale-events \
--threads 16 > wt_eventalign.txt

nanopolish eventalign --reads $ko_fastq \
--bam $ko_bam \
--genome $ref \
--samples \
--print-read-names \
--scale-events \
--threads 16 > ko_eventalign.txt

#eventalign_collapse
NanopolishComp Eventalign_collapse -i wt_eventalign.txt \
-o wt \
-t 16

NanopolishComp Eventalign_collapse -i ko_eventalign.txt \
-o ko \
-t 16

#samples comparison for detecting modifications
nanocompore sampcomp --file_list1 wt/out_eventalign_collapse.tsv \
--file_list2 ko/out_eventalign_collapse.tsv \
--label1 wt --label2 ko \
--fasta $ref \
--bed $bed12 \
--outpath nanocompore \
--min_coverage 5 \
--min_ref_length 10 \
--allow_warnings \
--nthreads 16
