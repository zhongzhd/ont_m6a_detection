#!/bin/bash

eligos_diff=path_to_ELIGOS_diff_results
epinano_delta=path_to_Epinano_delta_results

cd eligos_diff/com
awk 'BEGIN{OFS=""}{if($16>1){print $1,"|",$3,"\t",$16,"|",$17}else{print $1,"|",$3,"\t",$16,"|",1}}' wt_vs_ko_on_1_combine.txt > id.txt
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$1]=$2;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na",$4,$5,$6}}' id.txt $epinano_delta/com_rrach_all.bed > all_rrach_c5.bed
