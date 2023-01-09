#!/bin/bash

#dependencies：
#python 3.8.0

ref=path_to_reference_transcriptome
wt_fastq=path_to_fastq_file
ko_fastq=path_to_fastq_file
wt_bam=path_to_bam_file
ko_bam=path_to_bam_file

#eventalign
nanopolish eventalign --reads $wt.fastq \
--bam $wt.bam \
--genome $ref \
--scale-events \
--summary wt_summary.txt \
--signal-index \
--threads 16 > wt_eventalign.txt

#dataprep
m6anet-dataprep --eventalign wt_eventalign.txt \
--out_dir dataprep/wt \
--n_processes 16 \
--readcount_max 2000000

#detect m6A
m6anet-run_inference --input_dir dataprep/wt \
--out_dir run/wt \
--n_processes 16

#apply the same analysis in ko
