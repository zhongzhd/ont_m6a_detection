#!/bin/bash

epinano_delta=path_to_Epinano_delta_results
epinano=path_to_Epinano_results

cd $epinano_delta
grep "[GA][GA]AC[ACT]" com.DeltaMis3.DeltaDel3.DeltaQ3.MODEL.rrach.deltaQ3.deltaMis3.deltaDel3.linear.dump.csv > com_rrach.csv
awk 'BEGIN{FS=",";OFS="\t"}{print $1,$2}' com_rrach.csv > com_5mer_pos5.txt
awk -F '[\t-]' 'BEGIN{OFS="\t"}{print $1,$2+2}' com_5mer_pos5.txt > com_5mer_pos.txt
awk 'BEGIN{FS=",";OFS="\t"}{print $3,$27}' com_rrach.csv > com_id_cov5_mod.txt
paste com_id_cov5_mod.txt com_5mer_pos.txt > com_rrach.tsv
awk 'BEGIN{OFS=""}{print $1,"|",$4,"\t",$2}' com_rrach.tsv > com_rrach.bed
sort -k1,1 -k2,2n com_rrach.bed > com_rrach_sorted.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$1]=$2;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na",$4,$5,$6}}' com_rrach_sorted.bed $epinano/wt_c5_rrach_sorted.bed > com_rrach_wt.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$5]=$0;next}{if($5 in a){print a[$5],$4}}' com_rrach_wt.bed $epinano/ko_c5_rrach_sorted.bed > com_rrach_wtko.bed
awk 'BEGIN{OFS=""}{print $1,"\t",$2,"\t",$3,"\t",$4,"|",$7,"\t",$5,"\t",$6}' com_rrach_wtko.bed > com_rrach_all.bed
