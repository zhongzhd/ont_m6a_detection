#!/bin/bash

tombo=path_to_Tombo_results
mines=path_to_MINES_results
ref=path_to_reference_transcriptome
wt_fast5=path_to_basecalled_fast5_files
ko_fast5=path_to_basecalled_fast5_files
MINES=path_to_MINES_software

#obtain input statistical files from Tombo
cd tombo
tombo text_output browser_files --fast5-basedirs $wt_fast5/workspace \
--statistics-filename wt.tombo.stats \
--browser-file-basename wt \
--file-types coverage dampened_fraction fraction \
--corrected-group RawGenomeCorrected_000

awk '{if($0!=null){print $0}}' wt.fraction_modified_reads.plus.wig > wt.wig
wig2bed < wt.wig > wt.fraction_modified_reads.plus.wig.bed --multisplit=mines

#detect m6A
cd mines
python $MINES/cDNA_MINES2.py --fraction_modified $tombo/wt.fraction_modified_reads.plus.wig.bed \
--coverage $tombo/wt.coverage.plus.bedgraph \
--output wt.bed \
--ref $ref \
--kmer_models $MINES/Final_Models/names.txt

#apply the same analysis in ko
