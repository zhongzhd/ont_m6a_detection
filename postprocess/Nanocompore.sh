#!/bin/bash

nanocompore=path_to_Nanocompore_results
epinano_delta=path_to_Epinano_delta_results

cd $nanocompore/nanocompore
awk 'BEGIN{OFS="\t"}{print $4,$1+3,toupper($6),$7}' outnanocompore_results.tsv > 1.tsv
grep "[GA][GA]AC[ACT]" 1.tsv > com_rrach.tsv
awk 'BEGIN{OFS=""}''{print $1,"|",$2,"\t",$4}' com_rrach.tsv > id.txt
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$1]=$2;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na",$4,$5,$6}}' id.txt $epinano_delta/com_rrach_all.bed > all.bed
