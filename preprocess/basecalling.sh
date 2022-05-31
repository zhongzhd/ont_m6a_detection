#!/bin/bash

guppy=path_to_gupppy
wt_fast5=path_to_input_fast5_files
wt_fastq=path_to_save_fastq_files
ko_fast5=path_to_input_fast5_files
ko_fastq=path_to_save_fastq_files

#basecalling:
${guppy}/bin/guppy_basecaller -i ${wt} -s ${save_wt} -c ${guppy}/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16
${guppy}/bin/guppy_basecaller -i ${ko} -s ${save_ko} -c ${guppy}/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 16
