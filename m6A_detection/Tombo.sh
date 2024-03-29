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

#resquiggling
tombo resquiggle $wt_fast5/workspace $ref \
--rna \
--corrected-group RawGenomeCorrected_000 \
--basecall-group Basecall_1D_000 \
--overwrite \
--processes 16 \
--fit-global-scale \
--include-event-stdev

#detect modifications
tombo detect_modifications de_novo --fast5-basedirs $wt_fast5/workspace \
--statistics-file-basename wt \
--corrected-group RawGenomeCorrected_000 \
--processes 16

#output statistical results
tombo text_output browser_files --fast5-basedirs $wt_fast5/workspace \
--statistics-filename wt.tombo.stats \
--browser-file-basename wt_rrach \
--genome-fasta $ref \
--motif-descriptions RRACH:3:m6A \
--file-types coverage dampened_fraction fraction \
--corrected-group RawGenomeCorrected_000

#apply the same analysis in ko
