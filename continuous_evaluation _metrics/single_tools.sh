#!/bin/bash

validated_set_bed=path_to_validated_set

cp coordinate_transformation/single_tools/*chr1.bed .

#intersect sites
cat *chr1.bed | awk '{print $7}' | sort | uniq -c | awk '{if($1==6){print $2}}' > intersect.txt
for file in *chr1.bed;do awk 'NR==FNR{a[$1]=$1;next}{if($7 in a){print $0}}' intersect.txt $file > ${file%%1.bed}2.bed;done

#apply the same coverage
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$5;next}{print $1,$2,$3,$4,a[$7],$6,$7,$8,$9}' Epinano_chr2.bed Tombo_chr2.bed > Tombo_chr3.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$5;next}{print $1,$2,$3,$4,a[$7],$6,$7,$8,$9}' Epinano_chr2.bed MINES_chr2.bed > MINES_chr3.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$5;next}{print $1,$2,$3,$4,a[$7],$6,$7,$8,$9}' Epinano_chr2.bed m6Anet_chr2.bed > m6Anet_chr3.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$5;next}{print $1,$2,$3,$4,a[$7],$6,$7,$8,$9}' Epinano_chr2.bed Nanom6A_chr2.bed > Nanom6A_chr3.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$5;next}{print $1,$2,$3,$4,a[$7],$6,$7,$8,$9}' Epinano_chr2.bed ELIGOS_chr2.bed > ELIGOS_chr3.bed
cp Epinano_chr.bed Epinano_chr3.bed

#apply the same motif
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,a5,$6,$7,$8,a[$7]}' Epinano_chr3.bed Tombo_chr3.bed > Tombo_chr.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,a5,$6,$7,$8,a[$7]}' Epinano_chr3.bed MINES_chr3.bed > MINES_chr.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,a5,$6,$7,$8,a[$7]}' Epinano_chr3.bed m6Anet_chr3.bed > m6Anet_chr.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,a5,$6,$7,$8,a[$7]}' Epinano_chr3.bed Nanom6A_chr3.bed > Nanom6A_chr.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$9;next}{print $1,$2,$3,$4,a5,$6,$7,$8,a[$7]}' Epinano_chr3.bed ELIGOS_chr3.bed > ELIGOS_chr.bed
cp Epinano_chr3.bed Epinano_chr.bed

#plot ROC and PR curves
for file in *chr.bed;do awk '$5>=20' $file > ${file%%.bed}_cov20.bed;done
bedtools intersect -a Tombo_chr_cov20.bed -b $validated_set_bed -wa -s -u > ont_m6a.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$7;next}{if($7 in a){print $7,1}else{print $7,0}}' ont_m6a.bed Tombo_chr_cov20.bed > id_label.txt
for file in *cov20.bed
do
cut -f 4 $file > ${file%%chr_cov20.bed}pred.txt
done
paste id_label.txt Tombo_pred.txt MINES_pred.txt Nanom6A_pred.txt m6Anet_pred.txt ELIGOS_pred.txt Epinano_pred.txt > id_label_pred.txt
python python ROC_PR.py

