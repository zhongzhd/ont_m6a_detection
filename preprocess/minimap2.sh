#!/bin/bash

ref=path_to_reference_transcriptome
wt_fastq=path_to_fastq_file
ko_fastq=path_to_fastq_file

minimap2 -ax map-ont --MD -t 16 $ref $wt_fastq > wt.sam
samtools view -@ 16 -bh -F 2324 wt.sam | samtools sort -@ 16 -o wt.bam
samtools index wt.bam

minimap2 -ax map-ont --MD -t 16 $ref $ko.fastq > ko.sam
samtools view -@ 16 -bh -F 2324 ko.sam | samtools sort -@ 16 -o ko.bam
samtools index ko.bam
