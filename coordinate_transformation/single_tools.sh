#!/bin/bash

tombo=path_to_Tombo_results
mines=path_to_MINES_results
nanom6a=path_to_Nanom6A_results
m6anet=path_to_m6Anet_results
eligos=path_to_ELIGOS_results
epinano=path_to_Epinano_results
bed=path_to_genome_transcriptome_coordinate

#bed format
#chr|pos|strand transcript|pos
#chr1|3073252|+ ENSMUST00000193812.1|1

cp $tombo/wt_c5rrach_idkmer.bed Tombo.bed
cp $mines/wt_C5_RRACH.sorted.bed MINES.bed
cp $nanom6a/wt_chr0.bed Nanom6A_chr0.bed0
cp $m6anet/wt_c20rrach_idkmer.bed m6Anet.bed
cp $eligos/wt_rrach_c5.bed ELIGOS.bed
cp $epinano/wt_c5_rrach_sorted.bed Epinano.bed

#transform transcriptomic coordinates to genomic coordinates
for file in *bed
do 
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$5]=$0;next}{if($2 in a){print $1,a[$2]}}' $file $bed | awk -F '[|\t]' 'BEGIN{OFS=""}''{print $1,"\t",$2,"\t",$2+1,"\t",$6,"\t",$7,"\t",$3,"\t",$1,"|",$2,"|",$3,"\t",$4,"|",$5,"\t",$10}' > ${file%%.bed}_chr0.bed
done

#merge sites derived from multiple transcriptomic coordinates but aligned to the same genomic coordinate
python 1.py Tombo_chr0.bed Tombo_chr1.bed
sed -i '1d' Tombo_chr1.bed

python 1.py MINES_chr0.bed MINES_chr1.bed
sed -i '1d' MINES_chr1.bed

python 1.py m6Anet_chr0.bed m6Anet_chr1.bed
sed -i '1d' m6Anet_chr1.bed

python 2.py ELIGOS_chr0.bed ELIGOS_chr1.bed
sed -i '1d' ELIGOS_chr1.bed

python 1.py Epinano_chr0.bed Epinano_chr1.bed
sed -i '1d' Epinano_chr1.bed
