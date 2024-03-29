#!/bin/bash

#dependencies
#bedtools	v2.29.2
#samtools	1.3.1
#minimap2	2.17-r941
#python	3.7.3
#h5py	2.9.0
#statsmodels	0.10.0
#joblib	0.16.0
#xgboost	0.80
#pysam	0.16.0.1
#tqdm	4.39.0
#pycairo	1.19.1
#scikit-learn	0.22

Nanom6A=path_to_Nanom6A_software
wt_fast5=path_to_basecalled_fast5_files
ko_fast5=path_to_basecalled_fast5_files
genome=path_to_reference_genome
bed=path_to_reference_genome_gene_bed

#bed format
#chr pos0 pos1 gene_symbol base strand
#chr1 3073252	3073253	RP23-271O17.1	A	+

#list all Tombo-resquiggled fast5 files
find $wt_fast5/workspace -name "*.fast5" > wt_fast5.txt

#extract features
mkdir results
python $Nanom6A/extract_raw_and_feature_fast.py -o results/wt \
--basecall_group=RawGenomeCorrected_000 \
--cpu=16 \
--clip=0 \
--fl=wt_fast5.txt

#predict m6A
mkdir results_final
python $Nanom6A/predict_sites.py -i results/wt \
-o results_final/wt \
-g $genome \
-r $bed \
--cpu 16 \
--support 5 \
--model $Nanom6A/bin/model

#apply the same analysis in ko
