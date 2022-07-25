#!/bin/bash

guppy=path_to_guppy_software
wt_fast5=path_to_input_fast5_files
wt_basecalled_fast5=path_to_save_basecalled_fast5_files
ko_fast5=path_to_input_fast5_files
ko_basecalled_fast5=path_to_save_basecalled_fast5_files

#basecalling:
$guppy/bin/guppy_basecaller -i $wt_fast5 -s $wt_basecalled_fast5 -c $guppy/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16
$guppy/bin/guppy_basecaller -i $ko_fast5 -s $ko_basecalled_fast5 -c $guppy/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16

#merge fastq files:
cat $wt_basecalled_fast5/pass/*fastq > wt.fastq
cat $ko_basecalled_fast5/pass/*fastq > ko.fastq

#filter basecalling failed reads:
cd $wt_basecalled_fast5
mkdir workspace_fail
awk '{if($10=="FALSE"){print $1}}' sequencing_summary.txt > fail_fast5.txt
cat fail_fast5.txt | while read id;do mv workspace/$id workspace_fail;done

cd $ko_basecalled_fast5
mkdir workspace_fail
awk '{if($10=="FALSE"){print $1}}' sequencing_summary.txt > fail_fast5.txt
cat fail_fast5.txt | while read id;do mv workspace/$id workspace_fail;done
