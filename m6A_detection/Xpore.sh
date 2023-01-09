#!/bin/bash

#dependencies：
#python 3.8.0

m6anet=path_to_m6Anet_results

#data preparation
xpore dataprep --eventalign $m6anet/wt_eventalign.txt \
--out_dir wt \
--n_processes 16 \
--readcount_max 2000000

xpore dataprep --eventalign $m6anet/ko_eventalign.txt \
--out_dir ko \
--n_processes 16 \
--readcount_max 2000000

#detect differential RNA modification
xpore diffmod --config 1.yml \
--n_processes 16

#1.yml
#notes: Pairwise comparison without replicates with default parameter setting.
#data:
#    ko:
#        rep1: ko
#    wt:
#        rep1: wt
#out: diffmod
#criteria:
#    readcount_min: 5
#    readcount_max: 2000000
