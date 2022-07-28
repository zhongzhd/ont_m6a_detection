#!/bin/bash

validated_set_bed=path_to_validated_set

cp coordinate_transformation/compare_tools/*chr1.bed .

#intersect sites
cat *chr1.bed | awk '{print $7}' | sort | uniq -c | awk '{if($1==7){print $2}}' > intersect.txt
for file in *chr1.bed;do awk 'NR==FNR{a[$1]=$1;next}{if($7 in a){print $0}}' intersect.txt $file > ${file%%1.bed}.bed;done

#apply the same coverage
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$10;next}{print $1,$2,$3,$4,$5,$6,$7,$8,$9,a[$7]}' Epinano_chr.bed Tombo_com_chr.bed > tmp
mv tmp Tombo_com_chr.bed

#apply the same motif
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,$5,$6,$7,$8,a[$7],a10}' Epinano_chr.bed Tombo_com_chr.bed > tmp
mv tmp Tombo_com_chr.bed

#plot ROC and PR curves
for file in *chr.bed;do awk '$5>=20' $file > ${file%%.bed}_cov20.bed;
bedtools intersect -a Tombo_com_chr_cov20.bed -b $validated_set_bed -wa -s -u > ont_m6a.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$7;next}{if($7 in a){print $7,1}else{print $7,0}}' ont_m6a.bed Tombo_com_chr_cov20.bed > id_label.txt
for file in *cov20.bed
do
cut -f 4 $file > ${file%%chr_cov20.bed}pred.txt
done
paste id_label.txt Tombo_com_pred.txt Nanocompore_pred.txt Xpore_pred.txt DiffErr_pred.txt DRUMMER_pred.txt ELIGOS_diff_pred.txt Epinano_delta_pred.txt > id_label_pred.txt
python ROC_PR.py
