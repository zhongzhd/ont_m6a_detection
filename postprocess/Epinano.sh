#!/bin/bash

epinano=path_to_Epinano_results

cd $epinano

grep "[GA][GA]AC[ACT]" wt.q3.mis3.del3.MODEL.rrach.q3.mis3.del3.linear.dump.csv > wt_rrach.csv
awk 'BEGIN{FS=",";OFS="\t"}{print $1,$2}' wt_rrach.csv > wt_5mer_pos5.txt
awk -F '[\t-]' 'BEGIN{OFS="\t"}{print $1,$2+2}' wt_5mer_pos5.txt > wt_5mer_pos.txt
awk 'BEGIN{FS=",";OFS="\t"}{print $3,$5,$28}' wt_rrach.csv > wt_id_cov5_mod.txt
awk -F '[\t:]' 'BEGIN{OFS="\t"}{print $1,$4,$7}' wt_id_cov5_mod.txt > wt_id_cov_mod.txt
paste wt_id_cov_mod.txt wt_5mer_pos.txt > wt_rrach.tsv
awk 'BEGIN{OFS=""}{if($2>=5){print $1,"\t",$5,"\t",$3,"\t",$2,"\t",$1,"|",$5,"\t",$4}}' wt_rrach.tsv > wt_c5_rrach.bed
sort -k1,1 -k2,2n wt_c5_rrach.bed > wt_c5_rrach_sorted.bed

#apply the same operation in ko
