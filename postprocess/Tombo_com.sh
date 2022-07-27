#!/bin/bash

tombo_com=path_to_Tombo_com_results
ref=path_to_reference_transcriptome

cd $tombo_com
awk '{if($0!=""){print $0}}' com.dampened_fraction_modified_reads.m6A.plus.wig > com_wig2bed.wig
wig2bed --multisplit tombo --sort-tmpdir tmp < com_wig2bed.wig > com.dampened_fraction_modified_reads.m6A.plus.wig.bed
bedtools intersect -a com.dampened_fraction_modified_reads.m6A.plus.wig.bed -b com.coverage.sample.plus.bedgraph -wao | bedtools intersect -a - -b com.coverage.control.plus.bedgraph -wao > com.dampened_fraction_modified_reads.m6A.coverage.plus.wig.bed
awk 'BEGIN{OFS=""}{if($9>=5){print $1,"\t",$3,"\t",$5,"\t",$9,"|",$14"\t",$1,"|",$3}}' com.dampened_fraction_modified_reads.m6A.coverage.plus.wig.bed > com_c5rrach_id.bed
awk 'BEGIN{OFS="\t"}{print $1,$2-3,$2+2}' com_c5rrach_id.bed > 1.bed
bedtools getfasta -fi $ref -bed 1.bed -name | awk '{if(NR%2==0){print toupper($0)}}' > 2.bed
paste com_c5rrach_id.bed 2.bed > com_c5rrach_idkmer.bed
