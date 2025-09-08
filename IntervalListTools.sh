#! /bin/bash
#$ -e /GATK_MergeIntervals/errs/
#$ -o /GATK_MergeIntervals/outs/
#$ -l h_vmem=64G
#$ -l h_rt=72:00:00
#$ -N GV_IntervalListTools

source /broad/software/scripts/useuse
reuse Picard-Tools
reuse Java-1.8

java -jar /seq/software/picard/current/bin/picard-private.jar IntervalListTools \
ACTION=OVERLAPS \
I= ./GATK_bed_to_interval_list/intervalList_results/idt_xGenPlusCNV_2019Nov20.GRCh37.interval_list \
SI= ./GATK_bed_to_interval_list/intervalList_results/hg19_exome_v2.0.2_targets_sorted_validated.interval_list \
O= ./GATK_MergeIntervals/intervalMerge_results/overlap_idt_twist.interval_list
