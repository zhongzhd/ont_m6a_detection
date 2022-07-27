#!/bin/bash

nanom6a=path_to_Nanom6A_results
bed=path_to_id_trans_bed

#bed format
#chr|pos|gene_symbol chr|pos|strand
#chr1|3073253|RP23-271O17.1	chr1|3073253|+

cd $nanom6a/results_final/wt
awk '{print NF}' ratio.0.5.tsv | sort -nr | head -n 1 > NF
for i in {2..NF};do awk '{print $1,$'"$i"'}' ratio.0.5.tsv > $i.txt;done
cat *.txt > 1.tsv
awk '{if(NF==2){print $0}}' 1.tsv > ratio.0.5_12.tsv
awk -F '[|\t]' 'BEGIN{OFS=""}''{print $2,"|",$3,"|",$1,"\t",$6,"\t",$5}' ratio.0.5_12.tsv > id_.txt
awk 'NR==FNR{a[$1]=$2"\t"$3;next}{if($1 in a){print $2,a[$1]}}' id_.txt $bed > id.txt
uniq id.txt > id1.txt
awk -F '[| \t]' 'BEGIN{OFS=""}{print $1,"\t",$2-1,"\t",$2,"\t",$4,"\t",$5,"\t",$3,"\t",$1,"|",$2-1,"|",$3}' id1.txt > wt_chr0.bed

#apply the same operation in ko
