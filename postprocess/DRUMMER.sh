#!/bin/bash

drummer=path_to_DRUMMER_results
epinano_delta=path_to_Epinano_delta_results

cd $drummer/com/w-k
cat complete_analysis/*complete.txt > alltrans.txt
awk 'BEGIN{OFS=""}{if($24>1){print $1,"\t",$2,"\t",$24,"|",$25,"\t","c","\t",$1,"|",$2}else{print $1,"\t",$2,"\t",$24,"|",1,"\t","c","\t",$1,"|",$2}}' alltrans.txt > alltrans_id.txt 
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$5]=$3;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na",$4,$5,$6}}' alltrans_id.txt $epinano_delta/com_rrach_all.bed > rrach_c5_all.bed
