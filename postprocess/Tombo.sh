#!/bin/bash

tombo=path_to_Tombo_results
ref=path_to_reference_transcriptome

cd $tombo
awk '{if($0!=""){print $0}}' wt_rrach.dampened_fraction_modified_reads.m6A.plus.wig > wt_wig2bed.wig
wig2bed --multisplit tombo --sort-tmpdir tmp < wt_wig2bed.wig > wt_rrach.dampened_fraction_modified_reads.m6A.plus.wig.bed
bedtools intersect -a wt_rrach.dampened_fraction_modified_reads.m6A.plus.wig.bed -b wt_rrach.coverage.plus.bedgraph -wao > wt_rrach.dampened_fraction_modified_reads.coverage.m6A.plus.wig.bed
awk 'BEGIN{OFS=""}{if($9>=5){print $1,"\t",$3,"\t",$5,"\t",$9,"\t",$1,"|",$3}}' wt_rrach.dampened_fraction_modified_reads.coverage.m6A.plus.wig.bed > wt_c5rrach_id.bed
awk 'BEGIN{OFS="\t"}{print $1,$2-3,$2+2}' wt_c5rrach_id.bed > wt_1.bed
bedtools getfasta -fi $ref -bed wt_1.bed -name | awk '{if(NR%2==0){print $0}}' > wt_2.bed
paste wt_c5rrach_id.bed wt_2.bed > wt_c5rrach_idkmer.bed

#apply the same operation in ko
