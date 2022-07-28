#!/bin/bash

validated_set_bed=path_to_validated_set

cp coordinate_transformation/compare_tools/*chr1.bed .

#choose sites
for file in *chr1.bed
do
awk '$5>=5' $file > ${file%%1.bed}2.bed
done

#calculate F1 socres
for file in *chr2.bed
do
bedtools intersect -a $file -b $validated_set_bed -wa -s -u > ${file%%chr2.bed}m6a.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$7;next}{if($7 in a){print $7,1}else{print $7,0}}' ${file%%chr2.bed}m6a.bed $file > ${file%%chr2.bed}id_label.txt
cut -f 4 $file > ${file%%chr2.bed}pred.txt
paste ${file%%chr2.bed}id_label.txt ${file%%chr2.bed}pred.txt > ${file%%chr2.bed}id_label_pred.txt
done
python F1_thr_tsv.py Tombo_com_id_label_pred.txt Tombo_com.tsv
python F1_thr_tsv1.py Nanocompore_id_label_pred.txt Nanocompore.tsv
python F1_thr_tsv2.py Xpore_id_label_pred.txt Xpore.tsv
python F1_thr_tsv.py DiffErr_id_label_pred.txt DiffErr.tsv
python F1_thr_tsv1.py DRUMMER_id_label_pred.txt DRUMMER.tsv
python F1_thr_tsv1.py ELIGOS_diff_id_label_pred.txt ELIGOS_diff.tsv
python F1_thr_tsv.py Epinano_delta_id_label_pred.txt Epinano_delta.tsv
#output tsv format
#precision	recall	F1_score	thresholds
#0.18720218950887643	1.0	0.31536698830772625	0.0
