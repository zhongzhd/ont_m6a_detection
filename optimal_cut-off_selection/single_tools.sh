#/bin/bash


validated_set_bed=path_to_validated_set

cp coordinate_transformation/single_tools/*chr1.bed .

#choose sites
awk '$5>=5' Tombo_chr1.bed > Tombo_chr2.bed
awk '$5>=5' MINES_chr1.bed | grep "[GA][GA]AC[ACT]" > MINES_chr2.bed
awk '$5>=5' Nanom6A_chr1.bed > Nanom6A_chr2.bed
awk '$5>=20' m6Anet_chr1.bed > m6Anet_chr2.bed
awk '$5>=5' ELIGOS_chr1.bed > ELIGOS_chr2.bed
awk '$5>=5' Epinano_chr1.bed > Epinano_chr2.bed

#calculate F1 socres
for file in *chr2.bed
do
bedtools intersect -a $file -b $validated_set_bed -wa -s -u > ${file%%chr2.bed}m6a.bed
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$7]=$7;next}{if($7 in a){print $7,1}else{print $7,0}}' ${file%%chr2.bed}m6a.bed $file > ${file%%chr2.bed}id_label.txt
cut -f 4 $file > ${file%%chr2.bed}pred.txt
paste ${file%%chr2.bed}id_label.txt ${file%%chr2.bed}pred.txt > ${file%%chr2.bed}id_label_pred.txt
python F1_thr_tsv.py ${file%%chr2.bed}id_label_pred.txt ${file%%_chr2.bed}.tsv
done
#output tsv format
#precision	recall	F1_score	thresholds
#0.1858214591775967	1.0	0.3134054587044994	0.0
