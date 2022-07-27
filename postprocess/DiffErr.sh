#!/bin/bash

differr=path_to_DiffErr_results
epinano_delta=path_to_Epinano_delta_results
ref=path_to_reference_transcriptome

cd $differr
sort -k1,1 -k2,2n differr.bed > differr_sorted.bed
awk 'BEGIN{OFS="\t"}{print $1,$2-2,$3+2}' differr_sorted.bed > differr_sorted_5.bed
bedtools getfasta -fi $ref -bed differr_sorted_5.bed | awk '{if(NR%2==0){print toupper($0)}}' > 5mer.txt
paste differr_sorted.bed 5mer.txt > differr_sorted_5mer.bed
grep "[GA][GA]AC[ACT]" differr_sorted_5mer.bed > differr_rrach.bed
awk 'BEGIN{OFS=""}{if($7>0){print $1,"|",$3,"\t",$7,"|",$9}else{print $1,"|",$3,"\t",$7,"|",0}}' differr_rrach.bed > differr_rrach_id.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$1]=$2;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na",$4,$5,$6}}' differr_rrach_id.bed $epinano_delta/com_rrach_all.bed > differr_rrach_all.bed
