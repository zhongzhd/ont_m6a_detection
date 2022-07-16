#!/bin/bash

wt_fast5=path_to_input_fast5_files
wt_fastq=path_to_save_fastq_files
ko_fast5=path_to_input_fast5_files
ko_fastq=path_to_save_fastq_files

#basecalling:
guppy_basecaller -i ${wt_fast5} -s ${wt_fastq} -c ${guppy}/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16
guppy_basecaller -i ${ko_fast5} -s ${ko_fastq} -c ${guppy}/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16

#merge single fastq files
cat ${wt_fastq}/* > wt.fastq
cat ${ko_fastq}/* > ko.fastq

#aligment:
minimap2 -ax map-ont --MD reference_transcriptome wt.fastq > wt.sam

