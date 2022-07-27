#!/bin/bash

xpore=path_to_Xpore_results
epinano_delta=path_to_Epinano_delta_results

cd $xpore/diffmod
grep "[GA][GA]AC[ACT]" diffmod.table > diffmod_rrach.table
sed  's/^M//g'  diffmod_rrach.table > test.table
awk 'BEGIN{FS=",";OFS=""}{if($4>=0){print $1,"\t",$2+1,"\t","Na_antimr1","\t","c","\t",$1,"|",$2+1,"\t",$3}else if(($3=="AAACA" || $3=="AAACC" || $3=="AAACT" || $3=="AGACA" || $3=="AGACC" || $3=="AGACT" || $3=="GGACA" || $3=="GGACC" || $3=="GGACT") && $4<0 && $17=="lower"){print $1,"\t",$2+1,"\t",$6,"\t","c","\t",$1,"|",$2+1,"\t",$3}else if(($3=="GAACA" || $3=="GAACC" || $3=="GAACT") && $4<0 && $17=="higher"){print $1,"\t",$2+1,"\t",$6,"\t","c","\t",$1,"|",$2+1,"\t",$3}else{print $1,"\t",$2+1,"\t","Na_antimu2","\t","c","\t",$1,"|",$2+1,"\t",$3}}' test.table | sort -k1,1 -k2,2n > diffmod_rrach.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$5]=$3;next}{if($5 in a){print $1,$2,a[$5],$4,$5,$6}else{print $1,$2,"Na_overlap0",$4,$5,$6}}' diffmod_rrach.bed $epinano_delta/com_rrach_all.bed > diffmod_rrach_all.bed
