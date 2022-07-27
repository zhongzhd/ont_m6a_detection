#!/bin/bash

mines=path_to_MINES_results

cd $mines
awk 'BEGIN{OFS="\t"}{if($9==""){print $1,$2,$3,$4,$5,$6,$7,$8,0}else{print $0}}' wt.bed > wt_1.bed
awk 'BEGIN{OFS=""}{print $1,"\t",$2,"\t",$9,"\t",$8,"\t",$1,"|",$2,"\t",$4}' wt_1.bed > wt_C5_RRACH.bed
sort -k1,1 -k2,2n wt_C5_RRACH.bed > wt_C5_RRACH.sorted.bed

#apply the same operation in ko
