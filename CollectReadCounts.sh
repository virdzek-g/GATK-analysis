#! /bin/bash
#$ -e ./GATK_CreateReadCountPoN/errs/
#$ -o ./GATK_CreateReadCountPoN/outs/
#$ -l h_vmem=64G
#$ -l h_rt=72:00:00
#$ -N GV_CollectReadCounts

source /broad/software/scripts/useuse
reuse Picard-Tools
reuse Java-1.8

java -jar /seq/software/picard/current/bin/picard-private.jar CollectReadCounts \
I= ./
L= ./GATK_MergeIntervals/intervalMerge_results/overlap_idt_twist.interval_list \
O= ./GATK_CreateReadCountPoN/results/sample.counts.hdf5
