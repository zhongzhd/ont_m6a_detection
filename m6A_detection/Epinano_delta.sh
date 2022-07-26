#!/bin/bash

Epinano=path_to_Epinano_software
epinano=path_to_Epinano_results

#make delta features
python $Epinano/misc/Epinano_make_delta.py $epinano/wt.plus_strand.per.site.5mer.csv \
$epinano/ko.plus_strand.per.site.5mer.csv \
5 5 > wt_ko_delta.5mer.csv

#predict modifications
python $Epinano/Epinano_Predict.py \
--model $Epinano/models/rrach.deltaQ3.deltaMis3.deltaDel3.linear.dump \
--predict wt_ko_delta.5mer.csv \
--columns 7,12,22 \
--out_prefix com
