#!/bin/bash

#dependencies:
#h5py < 3
#numpy < 1.20
#scipy
#cython
#setuptools >= 18.0
#mappy >= 2.10
#future
#tqdm

ref=path_to_reference_transcriptome
wt_fast5=path_to_basecalled_fast5_files
ko_fast5=path_to_basecalled_fast5_files

#resquiggled wt and ko fast5 files in tombo.sh

#detect modifications
tombo detect_modifications model_sample_compare --fast5-basedirs $wt_fast5/workspace \
--control-fast5-basedirs $ko_fast5/workspace \
--statistics-file-basename com \
--corrected-group RawGenomeCorrected_000 \
--processes 16

#output statistical results
tombo text_output browser_files --fast5-basedirs $ko_fast5/workspace \
--control-fast5-basedirs $ko_fast5/workspace \
--statistics-filename com.tombo.stats \
--browser-file-basename com \
--genome-fasta ${fasta} \
--motif-descriptions RRACH:3:m6A \
--file-types coverage dampened_fraction fraction \
--corrected-group RawGenomeCorrected_000
