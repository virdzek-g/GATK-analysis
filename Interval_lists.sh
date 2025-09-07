# Preparation of interval list file for GATK WES analysis
cat twist_exome.bed | sed 's/chr//g' > twist_exome_v2.bed

# removed contig from the bed file
cat twist_exome_v2.bed | sed '/7_gl000195_random/d' > twist_exome_v3.bed

# convert a BED file to a picard interval list 
source /software/scripts/useuse
reuse Picard-Tools
reuse Java-1.8

java -jar picard.jar BedToIntervalList \
      I=/dir/twist_exome_v3.bed \
      O=/dir/twist_exome.interval_list \
      SD=/dir/reference_hg19/Homo_sapiens_assembly19.fasta



#cmbine the intervals from two interval lists, and keeping only overlapping intervals
java -jar picard.jar IntervalListTools \
       ACTION=OVERLAPS \
       I=dir/twist_exome_v3.bed \
       SI=dir/IDT.interval_list \
       O=dir/combined.interval_list 



