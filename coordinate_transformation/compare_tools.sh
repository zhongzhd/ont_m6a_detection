#!/bin/bash

tombo_com=path_to_Tombo_com_results
nanocompore=path_to_Nanocompore_results
xpore=path_to_Xpore_results
differr=path_to_DiffErr_results
drummer=path_to_DRUMMER_results
eligos_diff=path_to_ELIGOS_diff_results
epinano_delta=path_to_Epinano_delta_results
bed=path_to_genome_transcriptome_coordinate

#bed format
#chr|pos|strand transcript|pos
#chr1|3073252|+ ENSMUST00000193812.1|1

cp tombo_com/com_c5rrach_idkmer.bed Tombo_com.bed
cp nanocompore/diffmod/all.bed Nanocompore.bed
cp xpore/diffmod/diffmod_rrach_all.bed Xpore.bed
cp differr/differr_rrach_all.bed DiffErr.bed
cp drummer/com/w-k/rrach_c5_all.bed DRUMMER.bed
cp eligos_diff/com/all_rrach_c5.bed ELIGOS_diff.bed
cp epinano_delta/com_rrach_all.bed Epinano_delta.bed

#assign values to null
awk -F '[|\t]' 'BEGIN{OFS=""}{print $1,"\t",$2,"\t",$3,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}' Tombo_com.bed > tmp
mv tmp Tombo_com.bed
awk -F '[|\t]' 'BEGIN{OFS=""}{if($3!="Na" && $3!="nan"){print $1,"\t",$2,"\t",$3,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}else{print $1,"\t",$2,"\t",1,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}}' Nanocompore.bed > tmp
mv tmp Nanocompore.bed
awk 'BEGIN{OFS="\t"}{if($3=="Na_overlap0" || $3=="Na_antimr1" || $3=="Na_antimu2"){print $1,$2,0,$4,$5,$6}else{print $1,$2,$3,$4,$5,$6}}' Xpore.bed > tmp
mv tmp Xpore.bed
awk -F '[\t|]' 'BEGIN{OFS=""}{print $1,"\t",$2,"\t",$3,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}' Xpore.bed > tmp
mv tmp Xpore.bed
awk -F '[|\t]' 'BEGIN{OFS=""}{if($3!="Na"){print $1,"\t",$2,"\t",$4,"\t",$5,"|",$6,"\t",$7,"|",$8,"\t",$9,"\t",$5}else{print $1,"\t",$2,"\t",0,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}}' DiffErr.bed > tmp
mv tmp DiffErr.bed
awk 'BEGIN{OFS="\t"}{if($3=="inf"){print $1,$2,250,$4,$5,$6,$7}else{print $0}}' DiffErr.bed > tmp
mv tmp DiffErr.bed
awk -F '[|\t]' 'BEGIN{OFS=""}{if($3!="Na"){print $1,"\t",$2,"\t",$4,"\t",$5,"|",$6,"\t",$7,"|",$8,"\t",$9,"\t",$5}else{print $1,"\t",$2,"\t",1,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}}' DRUMMER.bed > tmp
mv tmp DRUMMER.bed
awk -F '[|\t]' 'BEGIN{OFS=""}{if($3!="Na"){print $1,"\t",$2,"\t",$4,"\t",$5,"|",$6,"\t",$7,"|",$8,"\t",$9,"\t",$5}else{print $1,"\t",$2,"\t",1,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}}' ELIGOS.bed > tmp
mv tmp ELIGOS.bed
awk -F '[\t|]' 'BEGIN{OFS=""}{print $1,"\t",$2,"\t",$3,"\t",$4,"|",$5,"\t",$6,"|",$7,"\t",$8,"\t",$4}' Epinano.bed > tmp
mv tmp Epinano.bed

#transform transcriptomic coordinates to genomic coordinates
for file in *bed
do
awk 'BEGIN{OFS="\t"}''NR==FNR{a[$5]=$0;next}{if($2 in a){print $1,a[$2]}}' $file $bed | awk -F '[|\t]' 'BEGIN{OFS=""}''{print $1,"\t",$2,"\t",$2+1,"\t",$6,"\t",$7,"|",$8,"\t",$3,"\t",$1,"|",$2,"|",$3,"\t",$4,"|",$5,"\t",$11,"\t",$12}' > ${file%%.bed}_chr0.bed
done

#merge sites derived from multiple transcriptomic coordinates but aligned to the same genomic coordinate
python 1.py Tombo_chr0.bed Tombo_chr1.bed
sed -i '1d' Tombo_chr1.bed
python 2.py Nanocompore_chr0.bed Nanocompore_chr1.bed
sed -i '1d' Nanocompore_chr1.bed
python 2.py Xpore_chr0.bed Xpore_chr1.bed
sed -i '1d' Xpore_chr1.bed
python 2.1.py DiffErr_chr0.bed DiffErr_chr1.bed
sed -i '1d' DiffErr_chr1.bed
python 2.py DRUMMER_chr0.bed DRUMMER_chr1.bed
sed -i '1d' DRUMMER_chr1.bed
python 2.py ELIGOS_chr0.bed ELIGOS_chr1.bed
sed -i '1d' ELIGOS_chr1.bed
python 1.py Epinano_chr0.bed Epinano_chr1.bed
sed -i '1d' Epinano_chr1.bed

*chr1.bed format
#chr pos0 pos1 scores coverage(wt|ko) strand genome_id transcriptome_id motif coverage(wt)
#chr1	4774310	4774311	0.151500	39|15	-	chr1|4774310|-	ENSMUST00000130201.7|789	AAACT	39

