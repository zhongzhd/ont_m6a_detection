#!/bin/bash

m6anet=path_to_m6Anet_results
ref=path_to_reference_transcriptome

cd $m6anet/run/wt
awk 'BEGIN{FS=",";OFS=""}{if(NR>1){print $1,"\t",$2+1,"\t",$4,"\t",$3,"\t",$1,"|",$2+1}}' wt.csv | sort -k1,1 -k2,2n -T . > wt_1.txt
awk 'BEGIN{OFS="\t"}{print $1,$2-3,$2+2}' wt_1.txt > wt_1.bed
bedtools getfasta -fi $ref -bed wt_1.bed | awk '{if(NR%2==0){print toupper($0)}}' > wt_1.kmer
paste wt_1.txt wt_1.kmer | grep "[GA][GA]AC[ACT]" > wt_c20rrach_idkmer.bed

#apply the same operation in ko
